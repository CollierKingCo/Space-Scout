//
//  SpaceScoutCreditsViewController.m
//  Space Scout
//
//  Created by Felix King on 9/1/14.
//  Copyright (c) 2014 Collier King Co. All rights reserved.
//

#import "SpaceScoutCreditsViewController.h"
#import "SpaceScoutCredits.h"
#import "SpaceScoutCreditsAmount.h"

@interface SpaceScoutCreditsViewController ()

@property (nonatomic) SpaceScoutCredits *products;

@end

@implementation SpaceScoutCreditsViewController


-(SpaceScoutCredits *)products {
    if (!_products) _products = [[SpaceScoutCredits alloc] init];
    return _products;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 20;//[self.products.allCredits count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"ProductCell"
                             forIndexPath:indexPath];
    
    //SpaceScoutCredits *s = [self.products.allCredits objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"Coolness%d", indexPath.row + 1];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Felix King"];
    
    return cell;
}
@end
