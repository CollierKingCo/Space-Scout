//
//  SpaceScoutHomePageViewController.h
//  Space Scout
//
//  Created by Felix King on 9/3/14.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpaceScoutPlayer.h"
#import "SpaceScoutWeaponsStoreViewController.h"
#import "SpaceScoutVanityStoreViewController.h"

/*@protocol HomePageDelgate <NSObject>
- (NSInteger)whatIsTheCurrentLangugae;
@end*/

@protocol TheHomePageDelegate <NSObject>

- (NSInteger)currentLanaguge;

@end

@protocol TheOtherHomePageDelegate <NSObject>

- (NSInteger)currentLangugeOther;

@end

@interface SpaceScoutHomePageViewController : UIViewController <PlayerInfoDelegate>
@property (weak, nonatomic) IBOutlet UILabel *playerTokens;
@property (weak, nonatomic) IBOutlet UILabel *playerMoney;

@property (weak, nonatomic) IBOutlet UITextView *quoteOfTheDayTextBox;
@property (weak, nonatomic) IBOutlet UILabel *whoDidQuote;
- (IBAction)newQuoteButtonPressed:(UIButton *)sender;
- (IBAction)playSpecialSongButtonPressed:(UIButton *)sender;
- (IBAction)stopMusicButtonPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

//@property id<HomePageDelgate> delegate;
@property id<TheHomePageDelegate> homeDelegate;
@property id<TheOtherHomePageDelegate> homeDelegateOther;

@property NSInteger actualLanguageNumber;
@property BOOL isOver18;

@property NSInteger counter;

@property (weak, nonatomic) IBOutlet UIButton *playButtonLabel;
@property (weak, nonatomic) IBOutlet UIButton *highscoreButtonLabel;
@property (weak, nonatomic) IBOutlet UIButton *creditsButtonLabel;
@property (weak, nonatomic) IBOutlet UIButton *shopButtonLabel;
@property (weak, nonatomic) IBOutlet UIButton *easterEggButtonLabel;

@end
