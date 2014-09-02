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

@property (nonatomic) SpaceScoutCreditsAmount *products;

@end

@implementation SpaceScoutCreditsViewController


-(SpaceScoutCreditsAmount *)products {
    if (!_products) _products = [[SpaceScoutCreditsAmount alloc] init];
    return _products;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.products.allCredits count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"ProductCell"
                             forIndexPath:indexPath];
    
    SpaceScoutCredits *s = [self.products.allCredits objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", s.credit];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", s.whoGotCredit];
    
    return cell;
}
@end
