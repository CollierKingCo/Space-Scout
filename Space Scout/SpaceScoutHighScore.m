//
//  SpaceScoutHighScore.m
//  Space Scout
//
//  Created by felix king on 31/08/2014.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import "SpaceScoutHighScore.h"

@implementation SpaceScoutHighScore

+ (instancetype)makeHighscoreOfType:(HighscoreType)type {
    SpaceScoutHighScore *highscore  = [[SpaceScoutHighScore alloc] init];
    
    if (type == HighscoreTypeAwesomness1) {
        highscore.highscore = @"Highest Health";
        highscore.whoGotHighscore = @"Felix King";
    }
    else if (type == HighscoreTypeAwesomness2) {
        highscore.highscore = @"Greatest Movement";
        highscore.whoGotHighscore = @"Felix King";
    }
    else if (type == HighscoreTypeAwesomness3) {
        highscore.highscore = @"Lowest fps";
        highscore.whoGotHighscore = @"Josh Collier";
    }
    else if (type == HighscoreTypeAwesomness4) {
        highscore.highscore = @"Highest node count";
        highscore.whoGotHighscore = @"Josh Collier";
    }
    else if (type == HighscoreTypeAwesomness5) {
        highscore.highscore = @"Greatness";
        highscore.whoGotHighscore = @"Felix King";
    }
    else if (type == HighscoreTypeAwesomness6) {
        highscore.highscore = @"Awesomness";
        highscore.whoGotHighscore = @"Felix King";
    }
    else if (type == HighscoreTypeAwesomness7) {
        highscore.highscore = @"Coolness";
        highscore.whoGotHighscore = @"Felix King";
    }
    else if (type == HighscoreTypeAwesomness8) {
        highscore.highscore = @"Style";
        highscore.whoGotHighscore = @"Felix King";
    }
    else if (type == HighscoreTypeAwesomness9) {
        highscore.highscore = @"Narcissism";
        highscore.whoGotHighscore = @"Felix King";
    }
    else if (type == HighscoreTypeAwesomness10) {
        highscore.highscore = @"Best artist";
        highscore.whoGotHighscore = @"Felix King";
    }
    else if (type == HighscoreTypeAwesomness11) {
        highscore.highscore = @"Best coder";
        highscore.whoGotHighscore = @"Felix King";
    }
    else if (type == HighscoreTypeAwesomness12) {
        highscore.highscore = @"Actual best coder";
        highscore.whoGotHighscore = @"Josh Collier";
    }
    return highscore;
}

@end
