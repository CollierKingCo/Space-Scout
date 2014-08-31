//
//  SpaceScoutPlayer.m
//  Space Scout
//
//  Created by Josh Collier on 8/12/14.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import "SpaceScoutPlayer.h"

@implementation SpaceScoutPlayer

- (id)init {
    
    self.maxHealth = 50;
    self.health = self.maxHealth;
    self.lvl = 1;
    self.lvlCap = 10;
    self.exp = 1;
    self.maxExp = self.lvl * 100;
    self.size = CGSizeMake(32, 32);
    self.money = 50;
    
    
    if (self.exp == self.maxExp) {
        self.lvl += 1;
        self.exp = 1;
    }
    
    if (self.lvl == self.lvlCap) {
        self.maxExp = 0;
    }
    
    return self;
}

@end
