//
//  SpaceScoutCreditsViewController.h
//  Space Scout
//
//  Created by Felix King on 9/1/14.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpaceScoutCreditsViewController : UITableViewController

@property NSString* achievment;
@property NSString* name;

@property (weak, nonatomic) IBOutlet UILabel *creditsAchievmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *creditsNameLabel;


@end
