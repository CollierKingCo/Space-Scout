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
        highscore.highscore = @"Awesomness1";
        highscore.whoGotHighscore = @"Felix King";
    }
    else if (type == HighscoreTypeAwesomness2) {
        highscore.highscore = @"Awesomness2";
        highscore.whoGotHighscore = @"Felix King";
    }
    else if (type == HighscoreTypeAwesomness3) {
        highscore.highscore = @"Awesomness3";
        highscore.whoGotHighscore = @"Felix King";
    }
    else if (type == HighscoreTypeAwesomness4) {
        highscore.highscore = @"Awesomness4";
        highscore.whoGotHighscore = @"Felix King";
    }
    else if (type == HighscoreTypeAwesomness5) {
        highscore.highscore = @"Awesomness5";
        highscore.whoGotHighscore = @"Felix King";
    }
    return highscore;
}

@end
