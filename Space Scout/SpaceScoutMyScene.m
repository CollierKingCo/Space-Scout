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
#import "SpaceScoutPlayer.h"
#import "Joystick.h"

#define kMinPlayerToEdgeDistance 50

@interface SpaceScoutMyScene () <SKPhysicsContactDelegate>

@property SpaceScoutPlayer* player2;
@property SKSpriteNode* player;
@property SKSpriteNode* enemy;
@property SKSpriteNode* bomb;
@property SKSpriteNode* enemyBomb;
@property SKSpriteNode* collectButtonNode;
@property SKSpriteNode* progressBar;
@property SKSpriteNode* planet;
@property SKSpriteNode* planet2;
@property SKSpriteNode* shopPlanet;
@property SKSpriteNode* background;
@property SKSpriteNode* darkScreen;
@property SKSpriteNode* resumeButton;
@property SKSpriteNode* pauseButton;

@property SKLabelNode* scrapLabel;
@property SKLabelNode* healthLabel;
@property SKNode *world;
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

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.scrap = 100;
        self.maxHealth = 10000;
        self.health = 10000;
//#error fix yo death boy
#warning fix yo daeth boy
        self.middlePoint = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        self.physicsWorld.gravity = CGVectorMake(0,0);
        self.physicsWorld.contactDelegate = self;
        
        self.background = [SKSpriteNode spriteNodeWithImageNamed:@"Orion-nebula-viewed-by-WISE.jpg"];
        self.background.position = self.middlePoint;
        self.background.size = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        
        [self addChild:self.background];
        
        _world = [[SKNode alloc] init];
        [self addChild:_world];
        
        [self addPlanets];
        // [self addShopPlanet];
        [self addEnemy];
        [self addPlayer];
        
        SKSpriteNode *jsThumb = [SKSpriteNode spriteNodeWithImageNamed:@"joystick.png"];
        SKSpriteNode *jsBackdrop = [SKSpriteNode spriteNodeWithImageNamed:@"dpad"];
        self.joystick = [Joystick joystickWithThumb:jsThumb andBackdrop:jsBackdrop];
        self.joystick.position = CGPointMake(jsBackdrop.size.width, jsBackdrop.size.height);
        self.joystick.position = CGPointMake(90, 90);
        [self addChild:self.joystick];
        
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
    SKAction * actionMove = [SKAction moveTo:self.player.position duration:5];
    [self.enemy runAction:actionMove];
    
    [self.scrapLabel removeFromParent];
    [self addScrapLabel];
    [self.healthLabel removeFromParent];
    [self addHealthLabel];
    [self checkHealth];
    
}

- (void)addScrapLabel {
    self.scrapLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    
    self.scrapLabel.text = [NSString stringWithFormat:@"Scrap: %@", @(self.scrap)];
    self.scrapLabel.fontSize = 20;
    self.scrapLabel.position = CGPointMake(64, 286);
    
    [self addChild:self.scrapLabel];
}

- (void)addHealthLabel {
    self.healthLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    
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
    [self.bomb removeFromParent];
	[self addDarkScreen];
    [self addResumeButton];
    self.scene.paused = YES;
}



#pragma mark ---------------------- Create Enemy ----------------------

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
}

- (void)shoot {
    [self addEnemyBomb];
    [self updateAllOutlets];
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
    self.planet2 = [SKSpriteNode spriteNodeWithImageNamed:@"Planet_3.png"];
    self.planet = [SKSpriteNode spriteNodeWithImageNamed:@"Planet_4.png"];
    self.planet2.size = CGSizeMake(64, 64);
    self.planet.size = CGSizeMake(128, 128);
    
    self.planet.position = self.middlePoint;
    self.planet2.position = CGPointMake(240, 260);
    self.planet.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.planet.size.width/2];
    self.planet2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.planet2.size];
    self.planet.physicsBody.categoryBitMask = planetCategory;
    self.planet2.physicsBody.categoryBitMask = planetCategory;
    self.planet.physicsBody.contactTestBitMask = playerCategory;
    self.planet2.physicsBody.contactTestBitMask = playerCategory;
    self.planet.physicsBody.collisionBitMask = 0;
    self.planet2.physicsBody.collisionBitMask = 0;
    self.planet.physicsBody.dynamic = YES;
    self.planet2.physicsBody.dynamic = YES;
    
    [self addChild:self.planet];
    [self addChild:self.planet2];
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

- (void)addEnemyBomb {
    CGPoint location = self.player.position;
    
    self.enemyBomb = [SKSpriteNode spriteNodeWithImageNamed:@"Laser.png"];
    self.enemyBomb.position = self.enemy.position;
    self.enemyBomb.zRotation = self.enemy.zRotation;
    self.enemyBomb.size = CGSizeMake(8, 32);
    self.enemyBomb.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.enemyBomb.size];
    self.enemyBomb.physicsBody.dynamic = YES;
    self.enemyBomb.physicsBody.categoryBitMask = enemyBombCategory;
    self.enemyBomb.physicsBody.contactTestBitMask = playerCategory;
    self.enemyBomb.physicsBody.collisionBitMask = 0;
    self.enemyBomb.physicsBody.usesPreciseCollisionDetection = YES;
    
    CGPoint offset = rwSub(location, self.enemyBomb.position);
    
    [self addChild:self.enemyBomb];
    
    CGPoint direction = rwNormalize(offset);
    
    CGPoint shootAmount = rwMult(direction, 1000);
    
    CGPoint realDest = rwAdd(shootAmount, self.enemyBomb.position);
    
    float velocity = 240.0/1.0;
    float realMoveDuration = self.size.width / velocity;
    SKAction * actionMove = [SKAction moveTo:realDest duration:realMoveDuration];
    SKAction * actionMoveDone = [SKAction removeFromParent];
    [self.enemyBomb runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(shoot) userInfo:nil repeats:YES];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        
        if (self.scene.paused == NO) {
            self.bomb = [SKSpriteNode spriteNodeWithImageNamed:@"Laser.png"];
            self.bomb.position = self.player.position;
            self.bomb.size = CGSizeMake(8, 32);
            self.bomb.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.bomb.size.width/2];
            self.bomb.physicsBody.dynamic = YES;
            self.bomb.physicsBody.categoryBitMask = bombCategory;
            self.bomb.physicsBody.contactTestBitMask = enemyCategory;
            self.bomb.physicsBody.collisionBitMask = 0;
            self.bomb.physicsBody.usesPreciseCollisionDetection = YES;
            
            CGPoint offset = rwSub(location, self.bomb.position);
            
            [self addChild:self.bomb];
            
            CGPoint direction = rwNormalize(offset);
            
            CGPoint shootAmount = rwMult(direction, 1000);
            
            CGPoint realDest = rwAdd(shootAmount, self.bomb.position);
            
            float velocity = 480.0/1.0;
            float realMoveDuration = self.size.width / velocity;
            SKAction * actionMove = [SKAction moveTo:realDest duration:realMoveDuration];
            SKAction * actionMoveDone = [SKAction removeFromParent];
            [self.bomb runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
            
        }
        
        if ([node.name isEqualToString:@"collectButtonNode"]) {
            self.scrap += 100;
        }
        if ([node.name isEqualToString:@"pauseButton"]) {
            [self pauseGame];
            
        }
        if ([node.name isEqualToString:@"resumeButton"]) {
            self.scene.paused = NO;
            [self.bomb removeFromParent];
            [self.darkScreen removeFromParent];
            [self.resumeButton removeFromParent];
            [self updateAllOutlets];
            
        }
    }
    
}

- (void)projectile:(SKSpriteNode*)projectile didCollideWithEnemy:(SKSpriteNode*)enemy {
    [self.bomb removeFromParent];
    [self.enemy removeFromParent];
    
    SKSpriteNode *explosion = [SKSpriteNode spriteNodeWithTexture:[_explosionTextures objectAtIndex:0]];
    explosion.zPosition = 1;
    explosion.scale = 0.6;
    explosion.position = self.enemy.position;
    
    [self addChild:explosion];
    
    SKAction *explosionAction = [SKAction animateWithTextures:_explosionTextures timePerFrame:0.07];
    SKAction *remove = [SKAction removeFromParent];
    [explosion runAction:[SKAction sequence:@[explosionAction,remove]]];
    
    self.scrap += 10;
    [self addEnemy];
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
    projectile = self.enemyBomb;
    [projectile removeFromParent];
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

/*
 -(void)EnemiesAndClouds{
 //not always come
 int GoOrNot = [self getRandomNumberBetween:0 to:1];
 
 if(GoOrNot == 1){
 
 SKSpriteNode *enemy;
 
 int randomEnemy = [self getRandomNumberBetween:0 to:1];
 if(randomEnemy == 0)
 enemy = [SKSpriteNode spriteNodeWithImageNamed:@"PLANE 1 N.png"];
 else
 enemy = [SKSpriteNode spriteNodeWithImageNamed:@"PLANE 2 N.png"];
 
 
 enemy.scale = 0.6;
 
 enemy.position = CGPointMake(screenRect.size.width/2, screenRect.size.height/2);
 enemy.zPosition = 1;
 
 
 CGMutablePathRef cgpath = CGPathCreateMutable();
 
 //random values
 float xStart = [self getRandomNumberBetween:0+enemy.size.width to:screenRect.size.width-enemy.size.width];
 float xEnd = [self getRandomNumberBetween:0+enemy.size.width to:screenRect.size.width-enemy.size.width];
 
 //ControlPoint1
 float cp1X = [self getRandomNumberBetween:0+enemy.size.width> to:screenRect.size.width-enemy.size.width];
 float cp1Y = [self getRandomNumberBetween:0+enemy.size.width to:screenRect.size.width-enemy.size.height];
 
 //ControlPoint2
 float cp2X = [self getRandomNumberBetween:0+<span class="skimlinks-unlinked">enemy.size.width</span> to:<span class="skimlinks-unlinked">screenRect.size.width-enemy.size.width</span> ];
 float cp2Y = [self getRandomNumberBetween:0 to:cp1Y];
 
 CGPoint s = CGPointMake(xStart, 1024.0);
 CGPoint e = CGPointMake(xEnd, -100.0);
 CGPoint cp1 = CGPointMake(cp1X, cp1Y);
 CGPoint cp2 = CGPointMake(cp2X, cp2Y);
 CGPathMoveToPoint(cgpath,NULL, s.x, s.y);
 CGPathAddCurveToPoint(cgpath, NULL, cp1.x, cp1.y, cp2.x, cp2.y, e.x, e.y);
 
 SKAction *planeDestroy = [SKAction followPath:cgpath asOffset:NO orientToPath:YES duration:5];
 [self addChild:enemy];
 
 SKAction *remove = [SKAction removeFromParent];
 [enemy runAction:[SKAction sequence:@[planeDestroy,remove]]];
 
 CGPathRelease(cgpath);
 
 }
 
 }
 
 -(int)getRandomNumberBetween:(int)from to:(int)to {
 
 return (int)from + arc4random() % (to-from+1);
 }
 */

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

