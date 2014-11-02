//
//  SpaceScout18AndOverViewController.m
//  Space Scout
//
//  Created by felix king on 2/11/2014.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import "SpaceScout18AndOverViewController.h"

@interface SpaceScout18AndOverViewController ()

@end

@implementation SpaceScout18AndOverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundImage.image = [UIImage imageNamed:@"restricted.png"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Whoops!?"
                                                    message:@"Are you sure you're over 18?"
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self performSegueWithIdentifier:@"inAppPurchaseSegue" sender:self];
    }
    if (buttonIndex == 0) {
        [self performSegueWithIdentifier:@"backToStartSegue" sender:self];
    }
    else {
        NSLog(@"Dafuq?");
    }
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
