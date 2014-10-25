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
    self.counter = arc4random_uniform([self.quotes count]);
    [self updateAllOutlets];
    
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
        
        [_quotes addObject:@"All or dreams can come true - if we have the courage to pursue them."];
        [_quotes addObject:@"What the mind can concieve, it can achieve."];
        [_quotes addObject:@"It is not becuase things are difficult that we do not dare; it is because we do not dare that things are difficult."];
        [_quotes addObject:@"First they ignore you. Then they laugh at you. Then they fight you. Then you win."];
        [_quotes addObject:@"When you can't change the direction of the wind - adjust your sails."];
        [_quotes addObject:@"Our greatest weakness lies in giving up. The most certain way to succeed is always to try just one more time."];
        [_quotes addObject:@"If."];
        [_quotes addObject:@"If you can dream it, you can do it."];
        [_quotes addObject:@"Don't watch the clock; do what it does. Kepp going."];

        
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
    if (self.player.tokens <= 1) {
        self.playerTokens.text = [NSString stringWithFormat:@"Token: %d", self.player.tokens];
    } else {
        self.playerTokens.text = [NSString stringWithFormat:@"Tokens: %d", self.player.tokens];
    }
    self.playerMoney.text = [NSString stringWithFormat:@"Money: %d", self.player.money ];
    
    self.counter += 1;
    if (self.counter >= [self.quotes count]) {
        self.counter = 0;
    }
    
    self.quoteOfTheDayTextBox.text = [self.quotes objectAtIndex:self.counter];
    self.whoDidQuote.text = [self.whoDidQuotes objectAtIndex:self.counter];
}

- (IBAction)newQuoteButtonPressed:(UIButton *)sender {
    [self updateAllOutlets];
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
@end
