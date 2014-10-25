//
//  SpaceScoutHighScore.h
//  Space Scout
//
//  Created by felix king on 31/08/2014.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HighscoreType) {
    HighscoreTypeAwesomness1,
    HighscoreTypeAwesomness2,
    HighscoreTypeAwesomness3,
    HighscoreTypeAwesomness4,
    HighscoreTypeAwesomness5,
    HighscoreTypeAwesomness6,
    HighscoreTypeAwesomness7,
    HighscoreTypeAwesomness8,
    HighscoreTypeAwesomness9,
    HighscoreTypeAwesomness10,
    HighscoreTypeAwesomness11,
    HighscoreTypeAwesomness12,
};

@interface SpaceScoutHighScore : NSObject

+ (instancetype) makeHighscoreOfType:(HighscoreType)type;
@property NSString *highscore;
@property NSString *whoGotHighscore;


@end
