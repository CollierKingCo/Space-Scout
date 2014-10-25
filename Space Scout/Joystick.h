//
//  Joystick.h
//  Space Scout
//
//  Created by felix king on 14/10/2014.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Joystick : SKNode
{
    SKSpriteNode *thumbNode;
    BOOL isTracking;
    CGPoint velocity;
    CGPoint travelLimit;
    float angularVelocity;
    float size;
}

@property(nonatomic, readonly) CGPoint velocity;
@property(nonatomic, readonly) float angularVelocity;
@property(nonatomic, readonly) float size;

-(id) initWithThumb: (SKSpriteNode*) aNode;
+(id) joystickWithThumb: (SKSpriteNode*) aNode;
-(id) initWithThumb: (SKSpriteNode*) thumbNode andBackdrop: (SKSpriteNode*) backgroundNode;
+(id) joystickWithThumb: (SKSpriteNode*) thumbNode andBackdrop: (SKSpriteNode*) backgroundNode;
@end

