//
//  SpaceScoutMyScene.m
//  Space Scout
//
//  Created by Josh Collier on 8/11/14.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "SpaceScoutMyScene.h"
#import "SpaceScoutPlayViewController.h"
#import "SpaceScoutPlayer.h"
#import "SpaceScoutEnemy.h"
#import "SpaceScoutEnemyTeam.h"
#import "SpaceScoutPhysicsBodyCategory.h"
#import "Joystick.h"

@interface SpaceScoutMyScene () <SKPhysicsContactDelegate>

@property SKSpriteNode* player;
@property SKSpriteNode* playerProjectile;
@property SKSpriteNode* enemyProjectile;
@property SKSpriteNode* collectButtonNode;
@property SKSpriteNode* progressBar;
@property SKSpriteNode* planet;
@property SKSpriteNode* shopPlanet;
@property SKSpriteNode* background;
@property SKSpriteNode* darkScreen;
@property SKSpriteNode* resumeButton;
@property SKSpriteNode* pauseButton;
@property SpaceScoutEnemy* enemy;

@property SKLabelNode* scrapLabel;
@property SKLabelNode* healthLabel;
@property NSInteger scrap;
@property NSInteger health;
@property NSInteger maxHealth;
@property NSInteger frameWidth;
@property NSInteger frameHeight;
@property NSInteger enemyCount;

@property NSTimer* projectileShoot;

@property CGPoint middlePoint;

@property Joystick* joystick;

@property NSMutableArray *explosionTextures;
@property SKEmitterNode *fireTrail;

@property BOOL enemyIsDead;

@property (nonatomic) NSArray* armies;

@end

static const uint32_t bombCategory     =  0x1 << 0;
static const uint32_t enemyCategory        =  0x1 << 1;
static const uint32_t playerCategory        =  0x1 << 2;
static const uint32_t planetCategory        =  0x1 << 3;
static const uint32_t enemyBombCategory        =  0x1 << 4;
static const uint32_t shopPlanetCategory        =  0x1 << 5;

static inline CGPoint rwAdd(CGPoint a, CGPoint b) {
    return CGPointMake(a.x + b.x, a.y + b.y);
}

static inline CGPoint rwSub(CGPoint a, CGPoint b) {
    return CGPointMake(a.x - b.x, a.y - b.y);
}

static inline CGPoint rwMult(CGPoint a, float b) {
    return CGPointMake(a.x * b, a.y * b);
}

static inline float rwLength(CGPoint a) {
    return sqrtf(a.x * a.x + a.y * a.y);
}

static inline CGPoint rwNormalize(CGPoint a) {
    float length = rwLength(a);
    return CGPointMake(a.x / length, a.y / length);
}

@implementation SpaceScoutMyScene

- (NSArray *)armies {
    if (!_armies) {
        SpaceScoutEnemyTeam* xerionian = [[SpaceScoutEnemyTeam alloc] init];
        SpaceScoutEnemyTeam* mutantPlant = [[SpaceScoutEnemyTeam alloc] init];
        xerionian.alignment = Xerionian;
        mutantPlant.alignment = MutantPlant;
        _armies = @[xerionian, mutantPlant];
    }
    return _armies;
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        NSInteger random = arc4random_uniform(5) + 1;
        self.enemyIsDead = NO;
        self.scrap = 100;
        self.maxHealth = 10000;
        self.health = 10000;
        self.middlePoint = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        // Set World Physics
        self.physicsWorld.gravity = CGVectorMake(0,0);
        self.physicsWorld.contactDelegate = self;
        
        // Add Background
        self.background = [SKSpriteNode spriteNodeWithImageNamed:@"Orion-nebula-viewed-by-WISE.jpg"];
        self.background.position = self.middlePoint;
        self.background.size = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        [self addChild:self.background];
        
        // Add Objects
        [self addPlanets];
        // [self addShopPlanet];
        [self addPlayer];
        [self addEnemy];
        [self addJoystick];
        
        self.frameWidth = arc4random_uniform(200);
        self.frameHeight = arc4random_uniform(200);
        
        CADisplayLink *velocityTick = [CADisplayLink displayLinkWithTarget:self selector:@selector(joystickMovement)];
        [velocityTick addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
        SKTextureAtlas *explosionAtlas = [SKTextureAtlas atlasNamed:@"EXPLOSION"];
        NSArray *textureNames = [explosionAtlas textureNames];
        _explosionTextures = [NSMutableArray new];
        for (NSString *name in textureNames) {
            SKTexture *texture = [explosionAtlas textureNamed:name];
            [_explosionTextures addObject:texture];
            
        }
        [self addPauseButton];
        [self updateAllOutlets];
        
        [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(addEnemy) userInfo:nil repeats:YES];
        
    }
    return self;
}

- (void)joystickMovement {
    if (self.joystick.velocity.x !=0 || self.joystick.velocity.y != 0) {
        self.player.position = CGPointMake(self.player.position.x + .1 *self.joystick.velocity.x, self.player.position.y + .1 * self.joystick.velocity.y);
    }
    if (self.joystick.velocity.x != 0 || self.joystick.velocity.y != 0)
    {
        self.player.zRotation = self.joystick.angularVelocity;
    }
    [self updateAllOutlets];
    
}

- (void)updateAllOutlets {
    self.enemyIsDead = NO;
    
    [self.scrapLabel removeFromParent];
    [self addScrapLabel];
    [self.healthLabel removeFromParent];
    [self addHealthLabel];
    [self checkHealth];
    
}

- (void)addScrapLabel {
    self.scrapLabel = [SKLabelNode labelNodeWithFontNamed:@"Ariel"];
    self.scrapLabel.text = [NSString stringWithFormat:@"Scrap: %@", @(self.scrap)];
    self.scrapLabel.fontSize = 20;
    self.scrapLabel.position = CGPointMake(64, 286);
    
    [self addChild:self.scrapLabel];
}

- (void)addHealthLabel {
    self.healthLabel = [SKLabelNode labelNodeWithFontNamed:@"manaspc"];
    
    self.healthLabel.fontSize = 20;
    self.healthLabel.position = CGPointMake(128, 256);
    
    [self addChild:self.healthLabel];
}

- (void)addShop {
    [self pauseGame];
    
}

- (void)addButton {
    self.collectButtonNode = [SKSpriteNode spriteNodeWithImageNamed:@"Collect_Button.png"];
    self.collectButtonNode.position = CGPointMake(260, 64);
    self.collectButtonNode.size = CGSizeMake(128, 32);
    self.collectButtonNode.name = @"collectButtonNode";
    [self addChild:self.collectButtonNode];
    [self updateAllOutlets];
}

- (void)addDarkScreen {
    self.darkScreen = [SKSpriteNode spriteNodeWithImageNamed:@"darkScreen.png"];
    self.darkScreen.position = self.middlePoint;
    self.darkScreen.size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    [self addChild:self.darkScreen];
}

- (void)addResumeButton {
    self.resumeButton = [SKSpriteNode spriteNodeWithImageNamed:@"resumeButton.png"];
    self.resumeButton.position = CGPointMake(self.frame.size.width - 128, self.frame.size.height - 32);
    self.resumeButton.size = CGSizeMake(128, 32);
    self.resumeButton.name = @"resumeButton";
    [self addChild:self.resumeButton];
}

- (void)addPauseButton {
    self.pauseButton = [SKSpriteNode spriteNodeWithImageNamed:@"pauseButton.png"];
    self.pauseButton.position = CGPointMake(self.frame.size.width - 32, self.frame.size.height - 32);
    self.pauseButton.size = CGSizeMake(32, 32);
    self.pauseButton.name = @"pauseButton";
    [self addChild:self.pauseButton];
}

- (void)pauseGame {
    [self.playerProjectile removeFromParent];
    [self addDarkScreen];
    [self addResumeButton];
    self.scene.paused = YES;
    self.enemyIsDead = YES;
}



#pragma mark ---------------------- Create Enemy ----------------------

- (id)initEnemy {
    return self;
}

/*
 - (void)addEnemy {
 int maxXCoord = CGRectGetMaxX(self.frame);
 int maxYCoord = CGRectGetMaxY(self.frame);
 
 int x = arc4random()% maxXCoord + 40;
 int y = arc4random()% maxYCoord + 40;
 
 self.enemy = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship_3.png"];
 self.enemy.position = CGPointMake(x, y);
 self.enemy.size = CGSizeMake(64, 64);
 self.enemy.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.enemy.size]; // 1
 self.enemy.physicsBody.dynamic = YES;
 self.enemy.physicsBody.categoryBitMask = enemyCategory; // 3
 self.enemy.physicsBody.contactTestBitMask = bombCategory;
 self.enemy.physicsBody.collisionBitMask = 0;
 [self addChild:self.enemy];
 [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(shoot) userInfo:nil repeats:NO];
 [self updateAllOutlets];
 self.enemyIsDead = NO;
 SKAction* action = [SKAction moveTo:self.player.position duration:5];
 [self.enemy runAction:action];
 }
 */

- (void)addEnemy {
    UnitAlignment alignment;
    alignment = MutantPlant;
    
    int maxXCoord = CGRectGetMaxX(self.frame);
    int maxYCoord = CGRectGetMaxY(self.frame);
    
    int x = arc4random() % maxXCoord + 40;
    int y = arc4random() % maxYCoord + 40;
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(shoot) userInfo:nil repeats:NO];
    
    self.enemy = [self.armies[alignment] deployNextEnemy];
    self.enemy.position = CGPointMake(x, y);
    
    // SKAction* action = [SKAction moveByX:enemy.velocity y:0 duration:1];
    // [enemy runAction:[SKAction repeatActionForever:action]];
    
    [self addChild:self.enemy];
    
    SKAction* action = [SKAction moveTo:self.player.position duration:5];
    SKAction* repeat = [SKAction repeatActionForever:action];
    [self.enemy runAction:repeat];
    /*
     self.enemy.position = CGPointMake(x, y);
     self.enemy.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.enemy.size]; // 1
     self.enemy.physicsBody.dynamic = YES;
     self.enemy.physicsBody.categoryBitMask = enemyCategory; // 3
     self.enemy.physicsBody.contactTestBitMask = bombCategory;
     self.enemy.physicsBody.collisionBitMask = 0;
     */
    
}


- (void)shoot {
    [self addEnemyProjectile];
    
}

#pragma mark ---------------------- Create Player ----------------------

- (void)addPlayer {
    self.player = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship_2.png"];
    self.player.position = self.middlePoint;
    self.player.size = CGSizeMake(64, 64);
    self.player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.player.size]; // 1
    self.player.physicsBody.dynamic = YES;
    self.player.physicsBody.categoryBitMask = playerCategory;
    self.player.physicsBody.contactTestBitMask = planetCategory;
    self.player.physicsBody.collisionBitMask = 0;
    
    [self addChild:self.player];
}

#pragma mark ---------------------- Create Planets ----------------------

- (void)addPlanets {
    SKSpriteNode* planet2;
    SKSpriteNode* planet3;
    SKSpriteNode* planet4;
    SKSpriteNode* planet5;
    
    int maxXCoord = CGRectGetMaxX(self.frame);
    int maxYCoord = CGRectGetMaxY(self.frame);
    
    int a = arc4random() % maxXCoord;
    int b = arc4random() % maxYCoord;
    int c = arc4random() % maxXCoord;
    int d = arc4random() % maxYCoord;
    int e = arc4random() % maxXCoord;
    int f = arc4random() % maxYCoord;
    
    
    self.planet = [SKSpriteNode spriteNodeWithImageNamed:@"Planet_3.png"];
    planet2 = [SKSpriteNode spriteNodeWithImageNamed:@"Planet_4.png"];
    planet3 = [SKSpriteNode spriteNodeWithImageNamed:@"Planet_4.png"];
    planet4 = [SKSpriteNode spriteNodeWithImageNamed:@"Planet_4.png"];
    planet5 = [SKSpriteNode spriteNodeWithImageNamed:@"Planet_4.png"];
    
    self.planet.size = CGSizeMake(64, 64);
    self.planet.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.planet.size.width/2];
    self.planet.physicsBody.categoryBitMask = planetCategory;
    self.planet.physicsBody.contactTestBitMask = playerCategory;
    self.planet.physicsBody.collisionBitMask = 0;
    self.planet.physicsBody.dynamic = YES;
    self.planet.position = CGPointMake(a, b);
    [self addChild:self.planet];
    
    planet2.size = CGSizeMake(64, 64);
    planet2.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:planet2.size.width/2];
    planet2.physicsBody.categoryBitMask = planetCategory;
    planet2.physicsBody.contactTestBitMask = playerCategory;
    planet2.physicsBody.collisionBitMask = 0;
    planet2.physicsBody.dynamic = YES;
    planet2.position = CGPointMake(c, d);
    
    [self addChild:planet2];
    
    planet3.size = CGSizeMake(64, 64);
    planet3.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:planet3.size.width/2];
    planet3.physicsBody.categoryBitMask = planetCategory;
    planet3.physicsBody.contactTestBitMask = playerCategory;
    planet3.physicsBody.collisionBitMask = 0;
    planet3.physicsBody.dynamic = YES;
    planet3.position = CGPointMake(e, f);
    
    [self addChild:planet3];
    
    /*
     planet3 = self.planet;
     planet3.position = CGPointMake(a, b);
     [self addChild:planet3];
     
     planet4 = self.planet;
     planet4.position = CGPointMake(a, b);
     [self addChild:planet4];
     
     planet5 = self.planet;
     planet5.position = CGPointMake(a, b);
     [self addChild:planet5];
     */
    
}

- (void)addShopPlanet {
    self.shopPlanet = [SKSpriteNode spriteNodeWithImageNamed:@"ShopPlanet.png"];
    self.shopPlanet.position = CGPointMake(self.frame.size.width/4, (self.frame.size.height/4)*3);
    self.shopPlanet.size = CGSizeMake(128, 128);
    self.shopPlanet.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.shopPlanet.size.width/2];
    self.shopPlanet.physicsBody.categoryBitMask = shopPlanetCategory;
    self.shopPlanet.physicsBody.contactTestBitMask = playerCategory;
    self.shopPlanet.physicsBody.collisionBitMask = 0;
    self.shopPlanet.physicsBody.dynamic = YES;
    [self addChild:self.shopPlanet];
    
}

- (void)addJoystick {
    SKSpriteNode *jsThumb = [SKSpriteNode spriteNodeWithImageNamed:@"joystick"];
    SKSpriteNode *jsBackdrop = [SKSpriteNode spriteNodeWithImageNamed:@"dpad"];
    self.joystick = [Joystick joystickWithThumb:jsThumb andBackdrop:jsBackdrop];
    self.joystick.position = CGPointMake(jsBackdrop.size.width, jsBackdrop.size.height);
    [self addChild:self.joystick];
}

- (void)addEnemyProjectile {
    if (self.enemyIsDead == YES) {
        return;
    }
    
    CGPoint location = self.player.position;
    
    UnitAlignment alignment;
    alignment = MutantPlant;
    
    self.enemyProjectile = [SKSpriteNode spriteNodeWithImageNamed:@"Laser.png"];
    self.enemyProjectile.position = self.enemy.position;
    self.enemyProjectile.size = CGSizeMake(8, 32);
    self.enemyProjectile.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.enemyProjectile.size];
    self.enemyProjectile.physicsBody.dynamic = YES;
    self.enemyProjectile.physicsBody.categoryBitMask = enemyBombCategory;
    self.enemyProjectile.physicsBody.contactTestBitMask = playerCategory;
    self.enemyProjectile.physicsBody.collisionBitMask = 0;
    self.enemyProjectile.physicsBody.usesPreciseCollisionDetection = YES;
    
    CGPoint offset = rwSub(location, self.enemyProjectile.position);
    
    [self addChild:self.enemyProjectile];
    
    CGPoint direction = rwNormalize(offset);
    
    CGPoint shootAmount = rwMult(direction, 1000);
    
    CGPoint realDest = rwAdd(shootAmount, self.enemyProjectile.position);
    
    float velocity = 240.0/1.0;
    float realMoveDuration = self.size.width / velocity;
    SKAction * actionMove = [SKAction moveTo:realDest duration:realMoveDuration];
    SKAction * actionMoveDone = [SKAction removeFromParent];
    [self.enemyProjectile runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(shoot) userInfo:nil repeats:NO];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        
        if (self.scene.paused == NO) {
            /*
             if([self.moveRightNode containsPoint: location]) {
             NSInteger xSpeed = yourSpeed;
             character.physicsBody.velocity = CGVectorMake(yourspeed, 0);
             }
             */
            
            if (location.x > CGRectGetMidX(self.frame)) {
                
                
            } else {
                /*
                 self.joystick.position = location;
                 
                 if (self.joystick.velocity.x !=0 || self.joystick.velocity.y != 0) {
                 self.player.position = CGPointMake(self.player.position.x + .1 *self.joystick.velocity.x, self.player.position.y + .1 * self.joystick.velocity.y);
                 }
                 if (self.joystick.velocity.x != 0 || self.joystick.velocity.y != 0)
                 {
                 self.player.zRotation = self.joystick.angularVelocity;
                 }
                 */
            }
            
            float b;
            float c;
            self.playerProjectile = [SKSpriteNode spriteNodeWithImageNamed:@"Laser.png"];
            self.playerProjectile.position = self.player.position;
            self.playerProjectile.size = CGSizeMake(8, 32);
            self.playerProjectile.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.playerProjectile.size.width/2];
            self.playerProjectile.physicsBody.dynamic = YES;
            self.playerProjectile.physicsBody.categoryBitMask = bombCategory;
            self.playerProjectile.physicsBody.contactTestBitMask = enemyCategory;
            self.playerProjectile.physicsBody.collisionBitMask = 0;
            self.playerProjectile.physicsBody.usesPreciseCollisionDetection = YES;
            
            CGPoint offset = rwSub(location, self.playerProjectile.position);
            
            [self addChild:self.playerProjectile];
            
            CGPoint direction = rwNormalize(offset);
            
            CGPoint shootAmount = rwMult(direction, 1000);
            
            CGPoint realDest = rwAdd(shootAmount, self.playerProjectile.position);
            
            float velocity = 480.0/1.0;
            float realMoveDuration = self.size.width / velocity;
            SKAction * actionMove = [SKAction moveTo:realDest duration:realMoveDuration];
            SKAction * actionMoveDone = [SKAction removeFromParent];
            [self.playerProjectile runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
            
            CGPoint point = [touch locationInView:self.view];
            NSLog(@"X location: %f", point.x);
            NSLog(@"Y Location: %f",point.y);
            
            b = self.player.position.x - point.x;
            c = self.player.position.y - point.y;
            
            float d = atan2(b, c);
            self.playerProjectile.zRotation = d;
            
        }
        
        if ([node.name isEqualToString:@"collectButtonNode"]) {
            self.scrap += 100;
        }
        if ([node.name isEqualToString:@"pauseButton"]) {
            [self pauseGame];
            
        }
        if ([node.name isEqualToString:@"resumeButton"]) {
            self.scene.paused = NO;
            [self.playerProjectile removeFromParent];
            [self.darkScreen removeFromParent];
            [self.resumeButton removeFromParent];
            [self updateAllOutlets];
            
        }
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    //[self.joystick removeFromParent];
    
}

- (void)projectile:(SKSpriteNode*)projectile didCollideWithEnemy:(SKSpriteNode*)enemy {
    
    [self.playerProjectile removeFromParent];
    [self.enemy removeFromParent];
    [self.enemy removeAllActions];
    [self.enemy removeAllChildren];
    
    SKSpriteNode *explosion = [SKSpriteNode spriteNodeWithTexture:[_explosionTextures objectAtIndex:0]];
    explosion.zPosition = 1;
    explosion.scale = 0.6;
    explosion.position = self.enemy.position;
    
    [self addChild:explosion];
    
    SKAction *explosionAction = [SKAction animateWithTextures:_explosionTextures timePerFrame:0.07];
    SKAction *remove = [SKAction removeFromParent];
    [explosion runAction:[SKAction sequence:@[explosionAction,remove]]];
    self.scrap += 10;
    self.enemyIsDead = YES;
    // [self addEnemy];
    [self updateAllOutlets];
    
}

- (void)player:(SKSpriteNode*)player didContactWithPlanet:(SKSpriteNode*)planet {
    [self addButton];
    [self updateAllOutlets];
}

- (void)player:(SKSpriteNode*)player didEndContactWithPlanet:(SKSpriteNode*)planet {
    [self.collectButtonNode removeFromParent];
    [self updateAllOutlets];
}

- (void)projectile:(SKSpriteNode*)projectile didCollideWithPlayer:(SKSpriteNode*)player {
    player = self.player;
    projectile = self.enemyProjectile;
    [self.enemyProjectile removeFromParent];
    [self.enemyProjectile removeAllChildren];
    [self.enemyProjectile removeAllActions];
    
    self.health--;
    [self updateAllOutlets];
}

- (void)checkHealth {
    if (self.health < 1) {
        self.healthLabel.text = @"You are DEAD";
        UIAlertView* death = [[UIAlertView alloc] initWithTitle:@"You Died" message:@"You have died" delegate:nil cancelButtonTitle:@"Restart" otherButtonTitles:nil];
        [death show];
        self.scrap = 0;
    } else {
        self.healthLabel.text = [NSString stringWithFormat:@"Health: %@/ %@", @(self.health), @(self.maxHealth)];
    }
}

- (void)update:(CFTimeInterval)currentTime {
    for (SpaceScoutEnemyTeam* army in self.armies) {
        for (SpaceScoutEnemy* enemy in army.deployedEnemies) {
            [enemy update:currentTime];
        }
    }
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    SKPhysicsBody *playerBody, *otherBody;
    
    if (firstBody.categoryBitMask & playerCategory) {
        playerBody = firstBody;
        otherBody = secondBody;
    } else if (secondBody.categoryBitMask & playerCategory) {
        playerBody = secondBody;
        otherBody = firstBody;
    }
    
    if (playerBody) {
        if (otherBody.categoryBitMask & planetCategory) {
            [self player:(SKSpriteNode*)firstBody.node didContactWithPlanet:(SKSpriteNode*)secondBody.node];
        }
        if (otherBody.categoryBitMask & enemyBombCategory) {
            [self projectile:(SKSpriteNode*)firstBody.node didCollideWithPlayer:(SKSpriteNode*)secondBody.node];
        }
        if (otherBody.categoryBitMask & shopPlanetCategory) {
            
        }
    }
    
    else {
        if ((firstBody.categoryBitMask & bombCategory) && (secondBody.categoryBitMask & enemyCategory)){
            [self projectile:(SKSpriteNode*)firstBody.node didCollideWithEnemy:(SKSpriteNode*)secondBody.node];
        }
        
    }
    
}

- (void)didEndContact:(SKPhysicsContact *)contact {
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    SKPhysicsBody *playerBody, *otherBody;
    
    if (firstBody.categoryBitMask & playerCategory) {
        playerBody = firstBody;
        otherBody = secondBody;
    } else if (secondBody.categoryBitMask & playerCategory) {
        playerBody = secondBody;
        otherBody = firstBody;
    }
    
    if (playerBody) {
        if (otherBody.categoryBitMask & planetCategory){
            [self player:(SKSpriteNode*)firstBody.node didEndContactWithPlanet:(SKSpriteNode*)secondBody.node];
        }
    }
    else {
        
    }
    
    
}

@end
