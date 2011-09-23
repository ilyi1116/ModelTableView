//
//  MYCustomCellInfo.m
//  ModelTableViewFramework
//
//  Created by Vladislav Alekseev on 10.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

#import "YXCustomCellInfo.h"
#import "MYCustomCellInfo.h"

#import "MYCustomCellView.h"

#import <QuartzCore/QuartzCore.h>

@implementation MYCustomCellInfo

@synthesize someNumberToDisplay;

- (BOOL)shouldUpdateCell:(UITableViewCell *)tableViewCell usingRowAnimation:(UITableViewRowAnimation)animationStyle {
    if (animationStyle == UITableViewRowAnimationNone)
        return YES;
    
    MYCustomCellView *cell = (MYCustomCellView *)tableViewCell;
    
    CATransition *transition = [CATransition animation];
    [transition setType:kCATransitionFade];
    
    [[[cell centerLabel] layer] addAnimation:transition forKey:kCATransition];
    
    NSString *centerText = [NSString stringWithFormat:@"Row %d", self.someNumberToDisplay];
    [[cell centerLabel] setText:centerText];
    
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
