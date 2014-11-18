//
//  SpaceScoutEnemyTeam.m
//  Space Scout
//
//  Created by felix king on 18/11/2014.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import "SpaceScoutEnemyTeam.h"
#import "SpaceScoutEnemy.h"

@interface SpaceScoutEnemyTeam()

@property (nonatomic) NSMutableArray* enemies;
@property (readwrite) NSInteger baseHitpoints;

@end

@implementation SpaceScoutEnemyTeam

- (NSMutableArray *)enemies {
    if (!_enemies) {
        _enemies = [[NSMutableArray alloc] init];
    }
    return _enemies;
}

- (NSArray *)allEnemies {
    return self.enemies;
}

- (NSArray *)deployedEnemies {
    NSMutableArray* matches = [[NSMutableArray alloc] init];
    for (SpaceScoutEnemy* enemy in self.enemies) {
        if (enemy.isDeployed) {
            [matches addObject:enemy];
        }
    }
    return matches;
}

- (SpaceScoutEnemy *)deployNextEnemy {
    SpaceScoutEnemy* enemy;
    
    if ([self.enemies count] > [[self deployedEnemies] count]) {
        for (SpaceScoutEnemy* emeny in self.enemies) {
            if (!enemy.isDeployed) {
                enemy.isDeployed = YES;
                break;
            }
        }
    } else {
        enemy = [[SpaceScoutEnemy alloc] initWithAlignment:MutantPlant];
        [self.enemies addObject:enemy];
        enemy.isDeployed = YES;
    }
    return enemy;
}

@end
