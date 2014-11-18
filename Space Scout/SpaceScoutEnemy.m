//
//  SpaceScoutEnemy.m
//  Space Scout
//
//  Created by felix king on 18/11/2014.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import "SpaceScoutEnemy.h"
#import "SpaceScoutPhysicsBodyCategory.h"

@interface SpaceScoutEnemy ()

@property CFTimeInterval age;
@property BOOL shootsProjectiles;
@property CFTimeInterval timeBetweenProjectiles;
@property NSInteger projectilesShot;

@end

@implementation SpaceScoutEnemy

- (id)initWithAlignment:(UnitAlignment)alignment {
    
    if (alignment == Xerionian) {
        self = [super initWithImageNamed:@"Spaceship_3.png"];
        self.type = @"Enemy";
        self.mHealth = 500;
        self.health = self.mHealth;
        self.race = @"Xerionian";
    } else {
        self = [super initWithImageNamed:@"Spaceship_3.png"];
        self.type = @"Enemy";
        self.mHealth = 500;
        self.health = self.mHealth;
        self.race = @"Mutant Plant";
    }
    
    self.isDeployed = NO;
    self.unitSpeed = 30;
    self.alignment = alignment;
    
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.dynamic = YES;
    self.physicsBody.collisionBitMask = 0;
    
    if (alignment == MutantPlant) {
        self.physicsBody.categoryBitMask = PhysicsBodyCategoryEnemy;
    } else {
        self.physicsBody.categoryBitMask = PhysicsBodyCategoryEnemy;
    }
    
    self.size = CGSizeMake(64, 64);
    
    self.shootsProjectiles = YES;
    
    
    return self;
}

- (NSInteger)velocity {
    return self.unitSpeed;
    
}

- (id)init {
    return [self initWithAlignment:MutantPlant];
}

- (void)update:(CFTimeInterval)timeInterval {
    self.age += timeInterval;
}

- (void)projectileHasBeenShot {
    self.projectilesShot += 1;
}

- (void)hitBy:(SKSpriteNode*)projectile {
    self.health -= 1;
}

@end
