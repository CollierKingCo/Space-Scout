//
//  SpaceScoutMyScene.m
//  Space Scout
//
//  Created by Josh Collier on 8/11/14.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import "SpaceScoutMyScene.h"
#import "SpaceScoutPlayer.h"

@interface SpaceScoutMyScene ()

@property SpaceScoutPlayer* player;
@property SKSpriteNode* sprite;
@property NSInteger credits;
@property NSInteger random;

@end

@implementation SpaceScoutMyScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.credits = 100;
        self.random = arc4random_uniform(2);
        
        CGPoint location = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        SKLabelNode* money = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        
        money.text = [NSString stringWithFormat:@"Credits %d", self.credits];
        money.fontSize = 10;
        money.position = CGPointMake(40, 330);
        
        [self addChild:money];
        
        self.backgroundColor = [SKColor grayColor];
        
        SKSpriteNode *leftButton = [SKSpriteNode spriteNodeWithImageNamed:@"500px-Aiga_leftarrow_inv.svg.png"];
        leftButton.position = CGPointMake(20, 250);
        leftButton.name = @"leftButtonNode";
        leftButton.size = CGSizeMake(16, 16);
        [self addChild:leftButton];
        
        SKSpriteNode *upButton = [SKSpriteNode spriteNodeWithImageNamed:@"upArrow.png"];
        upButton.position = CGPointMake(40, 270);
        upButton.name = @"upButtonNode";
        upButton.size = CGSizeMake(16, 16);
        [self addChild:upButton];
        
        SKSpriteNode *rightButton = [SKSpriteNode spriteNodeWithImageNamed:@"9ipe7bbkT.gif"];
        rightButton.position = CGPointMake(60, 250);
        rightButton.name = @"rightButtonNode";
        rightButton.size = CGSizeMake(16, 16);
        [self addChild:rightButton];
        
        SKSpriteNode *downButton = [SKSpriteNode spriteNodeWithImageNamed:@"downArrow.png"];
        downButton.position = CGPointMake(40, 230);
        downButton.name = @"downButtonNode";
        downButton.size = CGSizeMake(16, 16);
        [self addChild:downButton];
        
        SKSpriteNode* planet;
        
        if (self.random == 0) {
            planet = [SKSpriteNode spriteNodeWithImageNamed:@"Planet_3.png"];
        } else {
            planet = [SKSpriteNode spriteNodeWithImageNamed:@"Planet_4.png"];
        }
        planet.size = CGSizeMake(64, 64);
        planet.position = location;
        
        [self addChild:planet];
        
        if (self.random == 0) {
            planet = [SKSpriteNode spriteNodeWithImageNamed:@"Planet_3.png"];
        } else {
            planet = [SKSpriteNode spriteNodeWithImageNamed:@"Planet_4.png"];
        }
        planet.size = CGSizeMake(64, 64);
        planet.position = CGPointMake(100, 270);
        
        [self addChild:planet];
        
        self.sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship_2.png"];
        self.sprite.position = location;
        self.sprite.size = CGSizeMake(32, 32);
        
        [self addChild:self.sprite];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        
        SKAction* goLeft = [SKAction moveByX:-15 y:0 duration:1];
        SKAction* goUp = [SKAction moveByX:0 y:+15 duration:1];
        SKAction* goRight = [SKAction moveByX:+15 y:0 duration:1];
        SKAction* goDown = [SKAction moveByX:0 y:-15 duration:1];
        
        if ([node.name isEqualToString:@"leftButtonNode"]) {
            [self.sprite runAction:goLeft];
            self.sprite.zRotation = M_PI/2.0f;
            
        }
        
        if ([node.name isEqualToString:@"upButtonNode"]) {
            [self.sprite runAction:goUp];
            self.sprite.zRotation = M_PI/360.0f;
            
        }
        
        if ([node.name isEqualToString:@"rightButtonNode"]) {
            [self.sprite runAction:goRight];
            self.sprite.zRotation = -M_PI/2.0f;
            
        }
        
        if ([node.name isEqualToString:@"downButtonNode"]) {
            [self.sprite runAction:goDown];
            self.sprite.zRotation = M_PI/1.0f;
            
        }
    }
    
}

-(void)update:(CFTimeInterval)currentTime {
    
}

@end
