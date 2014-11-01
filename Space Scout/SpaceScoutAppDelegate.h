//
//  SpaceScoutAppDelegate.h
//  Space Scout
//
//  Created by Josh Collier on 8/11/14.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PageContentViewController;

@interface SpaceScoutAppDelegate : UIResponder <UIApplicationDelegate> {
    UIWindow *window1;
    PageContentViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window1;
@property (nonatomic, retain) IBOutlet PageContentViewController *viewController;

@property (strong, nonatomic) UIWindow *window;


@end
