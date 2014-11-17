//
//  SpaceScoutInAppPurchaseViewController.h
//  Space Scout
//
//  Created by felix king on 2/11/2014.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpaceScoutHomePageViewController.h"
@protocol inAppDelegate <NSObject>

- (NSInteger)CurrentLanguageInApp;

@end

@interface SpaceScoutInAppPurchaseViewController : UIViewController <TheOtherHomePageDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property id<inAppDelegate> inDelegate;

@end
