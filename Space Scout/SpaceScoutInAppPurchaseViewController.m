//
//  SpaceScoutInAppPurchaseViewController.m
//  Space Scout
//
//  Created by felix king on 2/11/2014.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import "SpaceScoutInAppPurchaseViewController.h"

@interface SpaceScoutInAppPurchaseViewController ()

@end

@implementation SpaceScoutInAppPurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"current languge in app %d", [self.inDelegate CurrentLanguageInApp]);
    self.backgroundImage.image = [UIImage imageNamed:@"iap.jpg"];
    if ([self.inDelegate CurrentLanguageInApp] == 2) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Whoops!?"
                                                        message:@"This requires an in-app purchase of $49.98"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Pay $49.98", nil];
        [alert show];
    }
    else if ([self.inDelegate CurrentLanguageInApp] == 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Whoops!?"
                                                        message:@"This requires an in-app purchase of $49.98 adn for this thing to be translated into latin"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel and other cool latin dreams"
                                              otherButtonTitles:@"Pay $29.99 or as XXX I mean XXIX.XCIX", nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self performSegueWithIdentifier:@"playSegue" sender:self];
    }
    if (buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:Nil];
    }
    else {
        NSLog(@"Dafuq?");
    }
}

- (NSInteger)currentLangugeOther {
    return [self.inDelegate CurrentLanguageInApp];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SpaceScoutHomePageViewController *vc = [segue destinationViewController];
    vc.homeDelegateOther = self;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
