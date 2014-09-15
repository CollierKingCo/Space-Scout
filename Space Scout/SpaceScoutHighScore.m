//
//  SpaceScoutHighScore.m
//  Space Scout
//
//  Created by felix king on 31/08/2014.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import "SpaceScoutHighScore.h"

@implementation SpaceScoutHighScore

+ (SpaceScoutHighScore *)randomHighscore {
    SpaceScoutHighScore *s = [[SpaceScoutHighScore alloc]init];
    int randNum = arc4random_uniform(10);
    
    if (randNum == 0) {
        s.highscore = @"Awesomness";
        s.whoGotHighscore = @"Felix King";
    }
    else if (randNum == 1) {
        s.highscore = @"Awesomness1";
        s.whoGotHighscore = @"Felix King";
    }
    else if (randNum == 2) {
        s.highscore = @"Awesomness2";
        s.whoGotHighscore = @"Felix King";
    }
    else if (randNum == 3) {
        s.highscore = @"Awesomness3";
        s.whoGotHighscore = @"Felix King";
    }
    else if (randNum == 4) {
        s.highscore = @"Awesomness4";
        s.whoGotHighscore = @"Felix King";
    }
    else if (randNum == 5) {
        s.highscore = @"Awesomness5";
        s.whoGotHighscore = @"Felix King";
    }
    else if (randNum == 6) {
        s.highscore = @"Awesomness6";
        s.whoGotHighscore = @"Felix King";
    }
    else if (randNum == 7) {
        s.highscore = @"Awesomness7";
        s.whoGotHighscore = @"Felix King";
    }
    else if (randNum == 8) {
        s.highscore = @"Awesomness8";
        s.whoGotHighscore = @"Felix King";
    }
    else if (randNum == 9) {
        s.highscore = @"Awesomness9";
        s.whoGotHighscore = @"Felix King";
    }
    else {
        s.highscore = @"Awesomness10";
        s.whoGotHighscore = @"Felix King";
    }
    
    return s;
}


@end
