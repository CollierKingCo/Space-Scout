//
//  PageContentViewController.m
//  Space Scout
//
//  Created by felix king on 28/10/2014.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import "PageContentViewController.h"


@interface PageContentViewController ()

@end

@implementation PageContentViewController

//@synthesize datePicker;
//@synthesize datelabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NSLog(@"delegated language %d", [self.delegate getTheCurrentLanguage]);
    
  //  NSLog(@"passed on selected langauge %d", self.delegate.sel);
    
  //  NSLog(@"langauge type: %d", self.currentlySelectedLanguage);
    
    self.backgroundImageView.image = [UIImage imageNamed:self.imageFile];
    self.titleLabel.text = self.titleText;
    self.titleButtonLabel.text = self.buttonText;
    self.subTitleTextLabel.text = self.subTitleText;
    self.adBannerImage.image = [UIImage imageNamed:self.adImageFile];
    self.adLabel.text = self.adText;
    self.howToPlayImage.image = [UIImage imageNamed:self.howToPlayImageFile];
    self.howToPlay2Image.image = [UIImage imageNamed:self.howToPlayImageFile2];
    self.dateLabel.text = self.dateLabelText;
    
    if (self.pageIndex == 3) {
        self.playButtonLabel.enabled = YES;
    }
    else {
        self.playButtonLabel.enabled = NO;
    }
    if (self.pageIndex == 1) {
        self.datePicker.hidden = NO;
        self.datePickerButtonLabel.enabled = YES;
        [self.datePickerButtonLabel setTitle:self.checkAgeButtonText forState:UIControlStateNormal];
    }
    else {
        self.datePicker.hidden = YES;
        self.datePickerButtonLabel.enabled = NO;
        [self.datePickerButtonLabel setTitle:@"" forState:UIControlStateNormal];
    }
    /*if (self.pageIndex != 0) {
        self.youChooseLabel.text = @"";
        self.LanguageLabel.text = @"";
        self.picker.hidden = YES;
    } else {
        self.youChooseLabel.text = @"You choose:";
        self.LanguageLabel.text = @"Nothing";
        self.picker.hidden = NO;
    }*/
    self.youChooseLabel.text = @"";
    self.LanguageLabel.text = @"";
    self.picker.hidden = NO;
    
    // Do any additional setup after loading the view, typically from a nib.
    //self.languageArray  = [[NSArray alloc] initWithObjects:@"Latin",@"English", @"German", @"Elvish", @"Volcan", @"Sylvan", nil];
    
    NSDate *now = [NSDate date];
    [self.datePicker setDate:now animated:YES];
    
    
  /*
    datelabel = [[UILabel alloc] init];
    datelabel.frame = CGRectMake(10, 200, 300, 40);
    datelabel.backgroundColor = [UIColor clearColor];
    datelabel.textColor = [UIColor whiteColor];
    datelabel.font = [UIFont fontWithName:@"Verdana-Bold" size: 20.0];
    datelabel.textAlignment = NSTextAlignmentCenter;
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;
    datelabel.text = [NSString stringWithFormat:@"%@",
                      [df stringFromDate:[NSDate date]]];
    [df release];
    [self.view addSubview:datelabel];
    [datelabel release];
    
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 250, 325, 300)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.hidden = NO;
    datePicker.date = [NSDate date];
    
    [datePicker addTarget:self
                   action:@selector(LabelChange:)
         forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];
    
    [datePicker release];*/
    
}

/*

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return 6;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSLog(@"Selected Row %d", row);
    switch(row)
    {
            
        case 0:
            self.LanguageLabel.text = @"Latin";
            self.LanguageLabel.textColor = [UIColor colorWithRed:0.0f/255.0f green: 0.0f/255.0f blue:255.0f/255.0f alpha:255.0f/255.0f];
            self.currentlySelectedLanguage = lanagugeTypeLatin;
            break;
        case 1:
            self.LanguageLabel.text = @"Englosh";
            self.LanguageLabel.textColor = [UIColor colorWithRed:0.0f/255.0f green: 255.0f/255.0f blue:0.0f/255.0f alpha:255.0f/255.0f];
            self.currentlySelectedLanguage = lanagugeTypeEnglish;
            break;
        case 2:
            self.LanguageLabel.text = @"German";
            self.LanguageLabel.textColor = [UIColor colorWithRed:205.0f/255.0f green: 140.0f/255.0f blue:31.0f/255.0f alpha:255.0f/255.0f];
            self.currentlySelectedLanguage = lanagugeTypeGerman;
            break;
        case 3:
            self.LanguageLabel.text = @"Elvish";
            self.LanguageLabel.textColor = [UIColor colorWithRed:255.0f/255.0f green: 0.0f/255.0f blue:255.0f/255.0f alpha:255.0f/255.0f];
            self.currentlySelectedLanguage = lanagugeTypeElvish;
            break;
        case 4:
            self.LanguageLabel.text = @"Volcan";
            self.LanguageLabel.textColor = [UIColor colorWithRed:255.0f/255.0f green: 0.0f/255.0f blue:0.0f/255.0f alpha:255.0f/255.0f];
            self.currentlySelectedLanguage = lanagugeTypeVolcan;
            break;
        case 5:
            self.LanguageLabel.text = @"Sylvan";
            self.LanguageLabel.textColor = [UIColor colorWithRed:255.0f/255.0f green: 255.0f/255.0f blue:0.0f/255.0f alpha:255.0f/255.0f];
            self.currentlySelectedLanguage = lanagugeTypeSlyvan;
            break;
    }
    NSLog(@"langauge type: %d", self.currentlySelectedLanguage);
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    return [self.languageArray objectAtIndex:row];
}
*/
- (IBAction)inAppPurchase:(UIButton *)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:self.inAppPurchase29s[0]
                                                    message:self.inAppPurchase29s[1]
                                                   delegate:self
                                          cancelButtonTitle:self.inAppPurchase29s[2]
                                          otherButtonTitles:self.inAppPurchase29s[3], nil];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1 && self.pageIndex == 3) {
        [self performSegueWithIdentifier:@"PlayGameSegue" sender:self];
    }
    else if (buttonIndex == 1 && self.pageIndex == 1) {
        NSLog(@"It doesn't know");
    }
    else if (buttonIndex == 2 && self.pageIndex == 1) {
        [self performSegueWithIdentifier:@"over18Segue" sender:self];
    }
    else {
        NSLog(@"Dafuq?");
    }
}
/*
- (NSInteger)whatIsTheCurrentLangugae {
    return 1;
}
- (NSInteger)currentNavigationLanaguge {
    return 1;
}*/

- (NSInteger)currentLanaguge {
    return self.languageNumber;
}

- (NSInteger)CurrentLanguageOver18 {
    return self.languageNumber;
}
// This will get called too before the view appears
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"PlayGameSegue"]) {
        
        // Get destination view
        
        SpaceScoutHomePageViewController *viewController = [segue destinationViewController];
        
       /* if (![viewController isKindOfClass:[SpaceScoutHomePageViewController class]]) {
            NSLog(@"Oh dear");
        }*/
        
        // Pass the information to your destination view
        viewController.homeDelegate = self;
    }
    else if ([[segue identifier] isEqualToString:@"over18Segue"]) {
        SpaceScout18AndOverViewController *vc = [segue destinationViewController];
        vc.overDelegate = self;
    }
}


/*

#pragma mark – View lifecycle
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.


- (void)LabelChange:(id)sender{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;
    datelabel.text = [NSString stringWithFormat:@"%@",
                      [df stringFromDate:datePicker.date]];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}*/

/*
-(IBAction)showdate:(id)sender
{
    NSLog(@"Button Pressed");
    NSDate *selected = [picker date];
    NSString *message = [[NSString alloc] initWithFormat:@"DATE AND TIME IS: %@", selected];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SELECTED DATE AND TIME" message:message delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
}*/

- (IBAction)datePickerButtonPressed:(UIButton *)sender {

    NSDate *selected = [self.datePicker date];
    NSString *date = [NSString stringWithFormat:@"%@", selected];
    NSDate *theDay = [NSDate date];
    NSString *strToday = [NSString stringWithFormat:@"%@", theDay];
    
    if (date.integerValue +18 <= strToday.integerValue) {
        NSLog(@"yay");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:self.areYouSure18s[0]
                                                        message:self.areYouSure18s[1]
                                                       delegate:self
                                              cancelButtonTitle:self.areYouSure18s[2]
                                              otherButtonTitles:self.areYouSure18s[3], self.areYouSure18s[4], nil];
        [alert show];
    }
    else {
        NSString *message = [[NSString alloc] initWithFormat:@"%@ %@", self.yourAges[1], selected];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:self.yourAges[0]
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:self.yourAges[2]
                                              otherButtonTitles:nil];
        [alert show];
    }
}


@end
