//
//  SpaceScoutHighScore.h
//  Space Scout
//
//  Created by felix king on 31/08/2014.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpaceScoutHighScore : NSObject

@property NSString *highscore;
@property NSString *whoGotHighscore;

+ (SpaceScoutHighScore *)randomHighscore;

@end
