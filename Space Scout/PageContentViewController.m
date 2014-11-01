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
    
    self.backgroundImageView.image = [UIImage imageNamed:self.imageFile];
    self.titleLabel.text = self.titleText;
    self.titleButtonLabel.text = self.buttonText;
    self.subTitleTextLabel.text = self.subTitleText;
    self.adBannerImage.image = [UIImage imageNamed:self.adImageFile];
    self.adLabel.text = self.adText;
    self.howToPlayImage.image = [UIImage imageNamed:self.howToPlayImageFile];
    self.howToPlay2Image.image = [UIImage imageNamed:self.howToPlayImageFile2];
    self.dateLabel.text = self.dateLabelText;
    
    if (self.pageIndex == 4) {
        self.playButtonLabel.enabled = YES;
    }
    else {
        self.playButtonLabel.enabled = NO;
    }
    if (self.pageIndex == 2) {
        self.datePicker.hidden = NO;
        self.datePickerButtonLabel.enabled = YES;
        self.datePickerButtonLabel.titleLabel.text = @"Check age!";
    }
    else {
        self.datePicker.hidden = YES;
        self.datePickerButtonLabel.enabled = NO;
        self.datePickerButtonLabel.titleLabel.text = @"";
    }
    if (self.pageIndex != 0) {
        self.youChooseLabel.text = @"";
        self.LanguageLabel.text = @"";
        self.picker.hidden = YES;
    } else {
        self.youChooseLabel.text = @"You choose:";
        self.LanguageLabel.text = @"Nothing";
        self.picker.hidden = NO;
    }
    // Do any additional setup after loading the view, typically from a nib.
    self.languageArray  = [[NSArray alloc] initWithObjects:@"Mandarin",@"Spanish",@"English",@"Hindi",@"Arabic",@"Portuguese", nil];
    
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
            self.LanguageLabel.text = @"Mandarin";
            self.LanguageLabel.textColor = [UIColor colorWithRed:0.0f/255.0f green: 0.0f/255.0f blue:255.0f/255.0f alpha:255.0f/255.0f];
            break;
        case 1:
            self.LanguageLabel.text = @"Spanish";
            self.LanguageLabel.textColor = [UIColor colorWithRed:0.0f/255.0f green: 255.0f/255.0f blue:0.0f/255.0f alpha:255.0f/255.0f];
            break;
        case 2:
            self.LanguageLabel.text = @"English";
            self.LanguageLabel.textColor = [UIColor colorWithRed:205.0f/255.0f green: 140.0f/255.0f blue:31.0f/255.0f alpha:255.0f/255.0f];
            break;
        case 3:
            self.LanguageLabel.text = @"Hindi";
            self.LanguageLabel.textColor = [UIColor colorWithRed:255.0f/255.0f green: 0.0f/255.0f blue:255.0f/255.0f alpha:255.0f/255.0f];
            break;
        case 4:
            self.LanguageLabel.text = @"Arabic";
            self.LanguageLabel.textColor = [UIColor colorWithRed:255.0f/255.0f green: 0.0f/255.0f blue:0.0f/255.0f alpha:255.0f/255.0f];
            break;
        case 5:
            self.LanguageLabel.text = @"Portuguese";
            self.LanguageLabel.textColor = [UIColor colorWithRed:255.0f/255.0f green: 255.0f/255.0f blue:0.0f/255.0f alpha:255.0f/255.0f];
            break;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    return [self.languageArray objectAtIndex:row];
}

- (IBAction)inAppPurchase:(UIButton *)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Whoops!?"
                                                   message:@"This requires an in-app purchase of $29.98"
                                                  delegate:self
                                         cancelButtonTitle:@"Cancel"
                                         otherButtonTitles:@"Pay $29.98", nil];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self performSegueWithIdentifier:@"navigationController" sender:self];
    }
    else {
        NSLog(@"Dafuq?");
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
    NSLog(@"%@", selected);
    NSString *strNum = @"199";
    NSString *date = [NSString stringWithFormat:@"%@", selected];
    
    if (strNum.integerValue <= date.integerValue) {
        NSLog(@"Well this works");
    }
    NSLog(@"num = %@, date = %@", strNum, date);
    
    NSString *message = [[NSString alloc] initWithFormat:@"You are %@ years old", selected];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your age!" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}
@end
