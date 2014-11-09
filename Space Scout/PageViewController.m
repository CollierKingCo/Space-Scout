//
//  PageViewController.m
//  Space Scout
//
//  Created by felix king on 28/10/2014.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import "PageViewController.h"


@implementation PageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"delegated language %d", [self.delegate getTheCurrentLanguage]);

    // Create the data model
    _pageTitles = @[/*@"Please select a Language",*/@"It's time for you to learn how to play!", @"When were you born?", @"", @""];
    _pageImages = @[/*@"page1.png",*/ @"page2.png", @"page3.png", @"page4.png", @"Laser.png"];
    _pageButtons = @[/*@" ",*/ @" ", @" ", @" ",@"Play"];
    _pageSubTitles = @[/*@"",*/ @"It's simple! Dodge bullets and shoot what ever moves.",@""/*@"Since you're an expert now I think it's time for you to tweek the settings so they perectly fit your awesomeness."*/, @"", @""];
    _pageAdImages = @[/*@"",*/ @"", @"", @"buy buy buy.jpg", @""];
    _pageAdLabel = @[/*@"",*/ @"", @"", @"Advertisment :)", @""];
    _pageTutImages = @[/*@"",*/ @"page1.png", @"", @"", @""];
    _pageTutImages2 = @[/*@"",*/ @"page2.png", @"", @"", @""];
    _dateLabels = @[/*@"", */@"", @"Your age is",@"", @""];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 0);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startWalkthrough:(id)sender {
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.buttonText = self.pageButtons[index];
    pageContentViewController.subTitleText = self.pageSubTitles[index];
    pageContentViewController.adImageFile = self.pageAdImages[index];
    pageContentViewController.adText = self.pageAdLabel[index];
    pageContentViewController.howToPlayImageFile = self.pageTutImages[index];
    pageContentViewController.howToPlayImageFile2 = self.pageTutImages2[index];
    pageContentViewController.dateLabelText = self.dateLabels[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end

