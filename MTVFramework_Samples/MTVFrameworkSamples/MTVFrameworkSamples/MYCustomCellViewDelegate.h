//
//  MYCustomCellViewDelegate.h
//  ModelTableViewFramework
//
//  Created by Vladislav Alekseev on 10.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MYCustomCellView;

@protocol MYCustomCellViewDelegate <NSObject>

- (void)customCellViewWantsToAddCellToTop:(MYCustomCellView *)cellView;
- (void)customCellViewWantsToAddCellToBottom:(MYCustomCellView *)cellView;
- (void)customCellView:(MYCustomCellView *)cellView wantsToDeleteWithAnimation:(UITableViewRowAnimation)animationStyle;

@end
