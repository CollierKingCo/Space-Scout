//
//  SpaceScoutEnemyTeam.h
//  Space Scout
//
//  Created by felix king on 18/11/2014.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpaceScoutEnemy.h"

@interface SpaceScoutEnemyTeam : NSObject

@property UnitAlignment* alignment;
@property (readonly) NSArray* allEnemies;
@property (readonly) NSArray* deployedEnemies;
@property (readonly) NSInteger baseHitpoints;
- (SpaceScoutEnemy*)deployNextEnemy;

@end
