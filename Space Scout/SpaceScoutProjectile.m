//
//  SpaceScoutProjectile.m
//  Space Scout
//
//  Created by felix king on 18/11/2014.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import "SpaceScoutProjectile.h"
#import "SpaceScoutPhysicsBodyCategory.h"
#import "SpaceScoutEnemy.h"

@implementation SpaceScoutProjectile

- (id)initWithPower:(CGFloat)power {
    self.size = CGSizeMake(32, 32);
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:8];
    self.physicsBody.dynamic = YES;
    
    self.physicsBody.categoryBitMask = PhysicsBodyCategoryProjectile;
    
    return self;
}
@end
