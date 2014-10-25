//
//  SpaceScoutHighScoreCell.h
//  Space Scout
//
//  Created by Felix King on 10/22/14.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpaceScoutHighScoreCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *whoGotHighScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *highScoreAchievmentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *highScoreBackgroundImage;

@end
