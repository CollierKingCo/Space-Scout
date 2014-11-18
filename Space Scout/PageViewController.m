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
    _pageTutImages = @[/*@"",*/ @"tut 1.png", @"", @"", @""];
    _pageTutImages2 = @[/*@"",*/ @"tut 2.png", @"", @"", @""];
    _pageAdImages = @[/*@"",*/ @"", @"", @"buy buy buy.jpg", @""];
    _pageImages = @[/*@"page1.png",*/ @"page2.png", @"page3.png", @"page4.png", @"Laser.png"];
    _pageLanguageNumber = [self.delegate getTheCurrentLanguage];

    if ([self.delegate getTheCurrentLanguage] == 2) {
        _pageTitles = @[/*@"Please select a Language",*/@"It's time for you to learn how to play!", @"When were you born?", @"", @""];
        _pageButtons = @[/*@" ",*/ @" ", @" ", @" ",@"Play"];
        _pageSubTitles = @[/*@"",*/ @"It's simple! Dodge bullets and shoot what ever moves.",@""/*@"Since you're an expert now I think it's time for you to tweek the settings so they perectly fit your awesomeness."*/, @"", @""];
        _pageAdLabel = @[/*@"",*/ @"", @"", @"Advertisment :)", @""];
        _dateLabels = @[/*@"", */@"", @"Your age is",@"", @""];
        _checkAgeLabel = @"Check age!";
        _inAppPurchase29Labels = @[@"Whoops!?", @"This requires an in-app purchase of $29.98", @"Cancel", @"Pay $29.98"];
        _YourAgeLabels = @[@"When you were born!", @"You were born in", @"Ok"];
        _areYouSureYour18Labels = @[@"Whoops!?", @"Are you sure you're over 18?", @"No", @"I don't know", @"Yes"];
    }
    else if ([self.delegate getTheCurrentLanguage] == 1) {
        _pageTitles = @[@"Aliquam vobis discere ludere!", @"Quando natus es?", @"", @""];
        _pageButtons = @[@" ", @" ", @" ",@"Fabula"];
        _pageSubTitles = @[@"Sed simplex! LATEBRA glandes et mittet id quod semper movetur",@"", @"", @""];
        _pageAdLabel = @[@"", @"", @"Advertisment :)", @""];
        _dateLabels = @[@"", @"Ea aetas tua",@"", @""];
        _checkAgeLabel = @"Lorem agea!";
        _inAppPurchase29Labels = @[@"Lets committitur!?", @"Haec requirit in App emptio $XXIX", @"Cancel", @"Redde $XXIX"];
        _YourAgeLabels = @[@"Quando natus es tu:", @"Morti natus es, in", @"CALLIDE"];
        _areYouSureYour18Labels = @[@"Lets committitur!?", @"Certus es te super XVIII ?", @"No", @"Nescio", @"etiam"];
    }
    else if ([self.delegate getTheCurrentLanguage] == 3) {
        _pageTitles = @[@"Es ist Zeit für Sie zu lernen, wie man spielt!", @"Wann sind Sie geboren ?", @"", @""];
        _pageButtons = @[@" ", @" ", @" ",@"spielen"];
        _pageSubTitles = @[@"Es ist ganz einfach! Kugeln ausweichen und schießen, was überhaupt bewegt.",@"", @"", @""];
        _pageAdLabel = @[@"", @"", @"Anzeige :)", @""];
        _dateLabels = @[@"", @"Ihr Alter ist",@"", @""];
        _checkAgeLabel = @"überprüfen Alter!";
        _inAppPurchase29Labels = @[@"hoppla!?", @"Dies erfordert eine In-App- Kauf von 29,98 $", @"stornieren", @"zahlen 29,98 $"];
        _YourAgeLabels = @[@"Als du geboren wurdest!", @"Sie wurden geboren", @"Ok"];
        _areYouSureYour18Labels = @[@"hoppla!?", @"Sind Sie sicher, dass Sie über 18 sind?", @"keine", @"Ich weiß nicht", @"ja"];
    }
    else if ([self.delegate getTheCurrentLanguage] == 4) {
        _pageTitles = @[@"It's time for you to learn how to play!", @"When were you born?", @"", @""];
        _pageButtons = @[@" ", @" ", @" ",@"Play"];
        _pageSubTitles = @[@"It's simple! Dodge bullets and shoot what ever moves.",@"", @"", @""];
        _pageAdLabel = @[@"", @"", @"Advertisment :)", @""];
        _dateLabels = @[@"", @"Your age is",@"", @""];
        _checkAgeLabel = @"Check age!";
        _inAppPurchase29Labels = @[@"Whoops!?", @"This requires an in-app purchase of $29.98", @"Cancel", @"Pay $29.98"];
        _YourAgeLabels = @[@"When you were born!", @"You were born in", @"Ok"];
        _areYouSureYour18Labels = @[@"Whoops!?", @"Are you sure you're over 18?", @"No", @"I don't know", @"Yes"];
    }
    else if ([self.delegate getTheCurrentLanguage] == 5) {
        _pageTitles = @[@"It's time for you to learn how to play!", @"When were you born?", @"", @""];
        _pageButtons = @[@" ", @" ", @" ",@"Play"];
        _pageSubTitles = @[@"It's simple! Dodge bullets and shoot what ever moves.",@"", @"", @""];
        _pageAdLabel = @[@"", @"", @"Advertisment :)", @""];
        _dateLabels = @[@"", @"Your age is",@"", @""];
        _checkAgeLabel = @"Check age!";
        _inAppPurchase29Labels = @[@"Whoops!?", @"This requires an in-app purchase of $29.98", @"Cancel", @"Pay $29.98"];
        _YourAgeLabels = @[@"When you were born!", @"You were born in", @"Ok"];
        _areYouSureYour18Labels = @[@"Whoops!?", @"Are you sure you're over 18?", @"No", @"I don't know", @"Yes"];
    }
    else if ([self.delegate getTheCurrentLanguage] == 6) {
        _pageTitles = @[@"It's time for you to learn how to play!", @"When were you born?", @"", @""];
        _pageButtons = @[@" ", @" ", @" ",@"Play"];
        _pageSubTitles = @[@"It's simple! Dodge bullets and shoot what ever moves.",@"", @"", @""];
        _pageAdLabel = @[@"", @"", @"Advertisment :)", @""];
        _dateLabels = @[@"", @"Your age is",@"", @""];
        _checkAgeLabel = @"Check age!";
        _inAppPurchase29Labels = @[@"Whoops!?", @"This requires an in-app purchase of $29.98", @"Cancel", @"Pay $29.98"];
        _YourAgeLabels = @[@"When you were born!", @"You were born in", @"Ok"];
        _areYouSureYour18Labels = @[@"Whoops!?", @"Are you sure you're over 18?", @"No", @"I don't know", @"Yes"];
    }
    
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
    pageContentViewController.checkAgeButtonText = self.checkAgeLabel;
    pageContentViewController.inAppPurchase29s = self.inAppPurchase29Labels;
    pageContentViewController.areYouSure18s = self.areYouSureYour18Labels;
    pageContentViewController.yourAges = self.YourAgeLabels;
    pageContentViewController.languageNumber = self.pageLanguageNumber;
    
    
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

