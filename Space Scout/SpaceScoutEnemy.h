//
//  SpaceScoutEnemy.h
//  Space Scout
//
//  Created by felix king on 18/11/2014.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#define MAX_LINES 5

#import <SpriteKit/SpriteKit.h>
#import "SpaceScoutProjectile.h"
#import "SpaceScoutPhysicsBodyCategory.h"

typedef NS_ENUM(NSInteger, UnitAlignment) {
    Xerionian = 0,
    MutantPlant = 1
};

@interface SpaceScoutEnemy : SKSpriteNode

@property BOOL isDeployed;
@property NSInteger unitSpeed;
@property (readonly) NSInteger velocity;
@property UnitAlignment alignment;
@property NSString* type;
@property NSInteger health;
@property NSInteger mHealth;
@property NSString* race;

- (id)initWithAlignment:(UnitAlignment)alignment;
- (void)update:(CFTimeInterval)timeInterval;
- (void)projectileHasBeenShot;
- (void)hitBy:(SpaceScoutProjectile*)projectile;

@end