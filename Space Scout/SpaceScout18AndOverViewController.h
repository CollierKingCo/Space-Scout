//
//  SpaceScout18AndOverViewController.h
//  Space Scout
//
//  Created by felix king on 2/11/2014.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpaceScoutInAppPurchaseViewController.h"
@protocol over18Delegate <NSObject>

- (NSInteger)CurrentLanguageOver18;

@end

@interface SpaceScout18AndOverViewController : UIViewController <inAppDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property id<over18Delegate> overDelegate;
@end
