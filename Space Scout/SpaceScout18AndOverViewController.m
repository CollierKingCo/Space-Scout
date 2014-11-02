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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Whoops!?"
                                                    message:@"Are you sure you're over 18?"
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"I don't know", @"Yes", nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
