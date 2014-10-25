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
#import "SpaceScoutCredit.h"
#import "SpaceScoutCreditCell.h"

@interface SpaceScoutCreditsViewController ()
@property (nonatomic) SpaceScoutCredits *credits;
@end

@implementation SpaceScoutCreditsViewController


-(SpaceScoutCredits *)credits {
    if (!_credits) _credits = [[SpaceScoutCredits alloc] init];
    return _credits;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSArray * tempArray = self.credits.allCredits;
    return [tempArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray * tempArray = self.credits.allCredits;
    SpaceScoutCredit *credit = [tempArray objectAtIndex:indexPath.row];
    SpaceScoutCreditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCell" forIndexPath:indexPath];
    
    
    //SpaceScoutCredits *s = [self.products.allCredits objectAtIndex:indexPath.row];
        cell.creditAchievmentLabel.text = [NSString stringWithFormat:@"%@", credit.credit];
        cell.creditAwardedTooLabel.text = [NSString stringWithFormat:@"%@", credit.whoGotCredit];
    cell.creditBackgroundImage.image = [UIImage imageNamed:@"background-hd.png"];
    
    return cell;
}
@end
