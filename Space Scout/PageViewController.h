//
//  PageViewController.h
//  Space Scout
//
//  Created by felix king on 28/10/2014.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"
@protocol ScrollPageDelegate <NSObject>

- (NSInteger)getTheCurrentLanguage;

@end

@interface PageViewController : UIViewController <UIPageViewControllerDataSource>

- (IBAction)startWalkthrough:(id)sender;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageSubTitles;
@property (strong, nonatomic) NSArray *pageImages;
@property (strong, nonatomic) NSArray *pageButtons;
@property (strong, nonatomic) NSArray *pageAdImages;
@property (strong, nonatomic) NSArray *pageAdLabel;
@property (strong, nonatomic) NSArray *pageTutImages;
@property (strong, nonatomic) NSArray *pageTutImages2;
@property (strong, nonatomic) NSArray *dateLabels;


@property id<ScrollPageDelegate> delegate;

@end
