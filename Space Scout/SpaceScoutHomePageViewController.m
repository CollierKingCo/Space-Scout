//
//  SpaceScoutHomePageViewController.m
//  Space Scout
//
//  Created by Felix King on 9/3/14.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import "SpaceScoutHomePageViewController.h"

@import AVFoundation;
@interface SpaceScoutHomePageViewController ()
@property (nonatomic) SpaceScoutPlayer *player;
@property (nonatomic) NSMutableArray *quotes;
@property (nonatomic) NSMutableArray *whoDidQuotes;
@property (nonatomic) AVAudioPlayer * backgroundMusicPlayer;
@end

@implementation SpaceScoutHomePageViewController

- (SpaceScoutPlayer *)player {
    if (!_player) {
        _player = [[SpaceScoutPlayer alloc] init];
    }
    return _player;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

   // NSLog(@"selected Language %d", [self.delegate whatIsTheCurrentLangugae]);
    NSLog(@"The homeDelegate %d", [self.homeDelegate currentLanaguge]);
    NSLog(@"The Other homeDelegate %d", [self.homeDelegateOther currentLangugeOther]);
    
    if ([self.homeDelegate currentLanaguge] != 0) {
        self.isOver18 = NO;
        self.actualLanguageNumber = [self.homeDelegate currentLanaguge];
    }
    else if ([self.homeDelegateOther currentLangugeOther] != 0) {
        self.isOver18 = YES;
        self.actualLanguageNumber = [self.homeDelegateOther currentLangugeOther];
    }
    
    self.counter = arc4random_uniform([self.quotes count]);
    self.backgroundImage.image = [UIImage imageNamed:@"homePageWallpaper.jpg"];
    [self updateAllOutlets];
    [self updateAllQuotes];
    
    if (self.actualLanguageNumber == 2) {

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank you!"
                                                        message:@"Your purchase was greatly appretiated"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok..."
                                              otherButtonTitles:nil];
        [alert show];
    }
    else if (self.actualLanguageNumber == 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"gratias ago tibi,"
                                                        message:@"Emptum esse erratam tuum valde"
                                                       delegate:self
                                              cancelButtonTitle:@"CALLIDE..."
                                              otherButtonTitles:nil];
        [alert show];
    }
    
#warning turn off exception breakpoints to play!!!

    NSError *error;
    NSURL * backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"Aaron Smith - Dancin (KRONO Remix)" withExtension:@"mp3"];
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    self.backgroundMusicPlayer.numberOfLoops = -1;
    [self.backgroundMusicPlayer prepareToPlay];
    [self.backgroundMusicPlayer play];

}

- (NSMutableArray *)quotes {
    if (!_quotes) {
        _quotes = [[NSMutableArray alloc] init];
        
        if (self.actualLanguageNumber == 2) {
            
            [_quotes addObject:@"All or dreams can come true - if we have the courage to pursue them."];
            [_quotes addObject:@"What the mind can concieve, it can achieve."];
            [_quotes addObject:@"It is not becuase things are difficult that we do not dare; it is because we do not dare that things are difficult."];
            [_quotes addObject:@"First they ignore you. Then they laugh at you. Then they fight you. Then you win."];
            [_quotes addObject:@"When you can't change the direction of the wind - adjust your sails."];
            [_quotes addObject:@"Our greatest weakness lies in giving up. The most certain way to succeed is always to try just one more time."];
            [_quotes addObject:@"If."];
            [_quotes addObject:@"If you can dream it, you can do it."];
            [_quotes addObject:@"Don't watch the clock; do what it does. Keep going."];
        }
        else if (self.actualLanguageNumber == 1) {
            
            [_quotes addObject:@"Omnes possunt somnia vera aut - si prosequi veritus."];
            [_quotes addObject:@"Quid mens concieve, præstare potest."];
            [_quotes addObject:@"Non quia difficilia sunt non audemus versatus ; quod ideo dicit, quia non audemus difficilia sunt."];
            [_quotes addObject:@"Primo enim, non cognoverunt te. Et subsannabo cum vobis. Et bellabunt adversum te. Tunc vobis vincere."];
            [_quotes addObject:@"Cum ventus non mutare directionem - componite velis."];
            [_quotes addObject:@"Nihil magis negari cedente. Temptant certissima semel via succedere semper."];
            [_quotes addObject:@"If."];
            [_quotes addObject:@"Si somnia, ideo potest."];
            [_quotes addObject:@"Nec tamen adeo; Duis facere quod facit. custodi ire."];
        }
    }
    return _quotes;
}

- (NSMutableArray *)whoDidQuotes {
    if (!_whoDidQuotes) {
        _whoDidQuotes = [[NSMutableArray alloc] init];
        
        [_whoDidQuotes addObject:@"Walt Disney"];
        [_whoDidQuotes addObject:@"Napoleon Hill"];
        [_whoDidQuotes addObject:@"Seneca"];
        [_whoDidQuotes addObject:@"Mahatma Gandhi"];
        [_whoDidQuotes addObject:@"H.Jackson Brown Jr."];
        [_whoDidQuotes addObject:@"Thomas A. Edison"];
        [_whoDidQuotes addObject:@"Unknown"];
        [_whoDidQuotes addObject:@"Mark Twain"];
        [_whoDidQuotes addObject:@"Sam Levenson"];

        
    }
    return _whoDidQuotes;
}
- (void) updateAllOutlets {
    
    if (self.actualLanguageNumber == 2) {

        if (self.player.tokens <= 1) {
            self.playerTokens.text = [NSString stringWithFormat:@"Token: %d", self.player.tokens];
        } else {
            self.playerTokens.text = [NSString stringWithFormat:@"Tokens: %d", self.player.tokens];
        }
        self.playerMoney.text = [NSString stringWithFormat:@"Money: %d", self.player.money ];

    }
    else if (self.actualLanguageNumber == 1) {
        if (self.player.tokens <= 1) {
            self.playerTokens.text = [NSString stringWithFormat:@"Token: %d", self.player.tokens];
        } else {
            self.playerTokens.text = [NSString stringWithFormat:@"Tokens: %d", self.player.tokens];
        }
        self.playerMoney.text = [NSString stringWithFormat:@"Pecunia: %d", self.player.money ];
        
        [self.playButtonLabel setTitle:@"Fabula" forState:UIControlStateNormal];
        [self.highscoreButtonLabel setTitle:@"altum score" forState:UIControlStateNormal];
        [self.creditsButtonLabel setTitle:@"crediti" forState:UIControlStateNormal];
        [self.shopButtonLabel setTitle:@"tabernam" forState:UIControlStateNormal];
        [self.easterEggButtonLabel setTitle:@"pascha ovi," forState:UIControlStateNormal];
    }
}

- (void) updateAllQuotes {
    self.counter += 1;
    if (self.counter >= [self.quotes count]) {
        self.counter = 0;
    }
    self.quoteOfTheDayTextBox.text = [self.quotes objectAtIndex:self.counter];
    self.whoDidQuote.text = [self.whoDidQuotes objectAtIndex:self.counter];
}

- (IBAction)newQuoteButtonPressed:(UIButton *)sender {
    [self updateAllQuotes];
}

- (IBAction)playSpecialSongButtonPressed:(UIButton *)sender {
    self.player.money += 100;
    [self.backgroundMusicPlayer stop];
    NSError *error;
    NSURL * backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"Taylor Swift - Shake It Off" withExtension:@"mp3"];
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    self.backgroundMusicPlayer.numberOfLoops = 1;
    [self.backgroundMusicPlayer prepareToPlay];
    [self.backgroundMusicPlayer play];
    
    [self updateAllOutlets];
}

- (IBAction)stopMusicButtonPressed:(UIButton *)sender {
    [self.backgroundMusicPlayer stop];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"shopSegue"]) {
        
        // Get destination view
        UITabBarController *vc = [segue destinationViewController];
        SpaceScoutWeaponsStoreViewController *wvc = (SpaceScoutWeaponsStoreViewController *)[[vc childViewControllers] objectAtIndex:0];
        SpaceScoutVanityStoreViewController *vvc = (SpaceScoutVanityStoreViewController *)[[vc childViewControllers] objectAtIndex:1];
        // Pass the information to your destination view
        wvc.playerDelegate = self;
        vvc.playerDelegate = self;
    }
}

- (NSInteger)WhatIsPlayerMoney {
    return self.player.money;
}

- (NSInteger)WhatIsPlayerTokens {
    return self.player.tokens;
}
@end
