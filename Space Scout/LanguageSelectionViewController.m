//
//  LanguageSelectionViewController.m
//  Space Scout
//
//  Created by felix king on 8/11/2014.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import "LanguageSelectionViewController.h"

@interface LanguageSelectionViewController ()

@end

@implementation LanguageSelectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.selectorButtonLabel.enabled = NO;
    [self.selectorButtonLabel setTitle:@"" forState:UIControlStateNormal];
    NSTimer *t = [NSTimer scheduledTimerWithTimeInterval: 3.0
                                                  target: self
                                                selector:@selector(onTick:)
                                                userInfo: nil repeats:YES];
    self.infoLabel.text = @"Please select a language";
    self.langaugeLabel.text = @"";
    
    self.languageArray  = [[NSArray alloc] initWithObjects:@"Latin",@"English", @"German", @"Elvish", @"Volcan", @"Sylvan", nil];
    self.infoArray = [[NSArray alloc] initWithObjects:@"Lat", @"Eng", @"Ger", @"Elv", @"Vol", @"Syl",nil];
}
-(void)onTick:(NSTimer *)timer {
    self.infoCounter ++;
    if (self.infoCounter >= [self.infoArray count]) {
        self.infoCounter = 0;
    }
    [self updateInfoOutlets];
}

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
            self.langaugeLabel.text = @"Latin";
            self.langaugeLabel.textColor = [UIColor colorWithRed:0.0f/255.0f green: 0.0f/255.0f blue:255.0f/255.0f alpha:255.0f/255.0f];
            self.currentlySelectedLanguage = lanagugeTypeLatin;
            [self updateAllOutlets];
            break;
        case 1:
            self.langaugeLabel.text = @"Englosh";
            self.langaugeLabel.textColor = [UIColor colorWithRed:0.0f/255.0f green: 255.0f/255.0f blue:0.0f/255.0f alpha:255.0f/255.0f];
            self.currentlySelectedLanguage = lanagugeTypeEnglish;
            [self updateAllOutlets];
            break;
        case 2:
            self.langaugeLabel.text = @"German";
            self.langaugeLabel.textColor = [UIColor colorWithRed:205.0f/255.0f green: 140.0f/255.0f blue:31.0f/255.0f alpha:255.0f/255.0f];
            self.currentlySelectedLanguage = lanagugeTypeGerman;
            [self updateAllOutlets];
            break;
        case 3:
            self.langaugeLabel.text = @"Elvish";
            self.langaugeLabel.textColor = [UIColor colorWithRed:255.0f/255.0f green: 0.0f/255.0f blue:255.0f/255.0f alpha:255.0f/255.0f];
            self.currentlySelectedLanguage = lanagugeTypeElvish;
            [self updateAllOutlets];
            break;
        case 4:
            self.langaugeLabel.text = @"Volcan";
            self.langaugeLabel.textColor = [UIColor colorWithRed:255.0f/255.0f green: 0.0f/255.0f blue:0.0f/255.0f alpha:255.0f/255.0f];
            self.currentlySelectedLanguage = lanagugeTypeVolcan;
            [self updateAllOutlets];
            break;
        case 5:
            self.langaugeLabel.text = @"Sylvan";
            self.langaugeLabel.textColor = [UIColor colorWithRed:255.0f/255.0f green: 255.0f/255.0f blue:0.0f/255.0f alpha:255.0f/255.0f];
            self.currentlySelectedLanguage = lanagugeTypeSlyvan;
            [self updateAllOutlets];
            break;
    }
    NSLog(@"langauge type: %d", self.currentlySelectedLanguage);
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    return [self.languageArray objectAtIndex:row];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toTheScroll"]) {
        
        // Get destination view        
        PageViewController *vc = [segue destinationViewController];
        
        // Pass the information to your destination view
        //[vc.delegate getTheCurrentLanguage];
    }
}

- (void) updateAllOutlets {
    self.selectorButtonLabel.enabled = YES;
    [self.selectorButtonLabel setTitle:@"select lanaguage!" forState:UIControlStateNormal];
}

- (void) updateInfoOutlets {
    self.infoLabel.text = self.infoArray[self.infoCounter];
}
- (IBAction)selectorButtonPressed:(UIButton *)sender {
    NSLog(@"selected language %d", self.currentlySelectedLanguage);
 //   [self performSegueWithIdentifier:@"toTheScroll" sender:self];

}

- (NSInteger)getTheCurrentLanguage {
    return self.currentlySelectedLanguage;
}
@end
