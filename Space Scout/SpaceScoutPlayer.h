//
//  SpaceScoutPlayer.h
//  Space Scout
//
//  Created by Josh Collier on 8/12/14.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import "SpaceScoutShop.h"
#import "SpaceScoutHomePageViewController.h"

@interface SpaceScoutPlayer : NSObject 

@property NSInteger health;
@property NSInteger maxHealth;
@property NSInteger damage;
@property NSInteger speed;
@property NSInteger exp;
@property NSInteger maxExp;
@property NSInteger lvl;
@property NSInteger lvlCap;
@property NSInteger money;
@property NSInteger tokens;
@property (nonatomic) CGSize size;

@end
