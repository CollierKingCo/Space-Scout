//
//  SpaceScoutHomePageViewController.h
//  Space Scout
//
//  Created by Felix King on 9/3/14.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpaceScoutPlayer.h"

@interface SpaceScoutHomePageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *playerTokens;
@property (weak, nonatomic) IBOutlet UILabel *playerMoney;

@property (weak, nonatomic) IBOutlet UITextView *quoteOfTheDayTextBox;
@property (weak, nonatomic) IBOutlet UILabel *whoDidQuote;
- (IBAction)newQuoteButtonPressed:(UIButton *)sender;
- (IBAction)playSpecialSongButtonPressed:(UIButton *)sender;

@property NSInteger counter;
@end
