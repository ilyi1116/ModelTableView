//
//  YXSectionDelegat.h
//  ModelTableViewFramework
//
//  Created by Vladislav Alekseev on 10.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXSectionInfo;
@class YXCellInfo;

@protocol YXSectionInfoDelegate <NSObject>
@required
- (void)section:(YXSectionInfo *)section didInsertCellInfo:(YXCellInfo *)cellInfo wantsAnimate:(UITableViewRowAnimation)animationStyle;
- (void)section:(YXSectionInfo *)section didRemoveCellInfo:(YXCellInfo *)cellInfo atIndex:(NSUInteger)index wantsAnimate:(UITableViewRowAnimation)animationStyle;
- (void)section:(YXSectionInfo *)section didRemoveCellsWithIndexes:(NSIndexSet *)indexes wantsAnimate:(UITableViewRowAnimation)animationStyle;
- (void)reloadSection:(YXSectionInfo *)section withAnimationStyle:(UITableViewRowAnimation)animationStyle;
- (void)section:(YXSectionInfo *)section reloadRowsWithIndexes:(NSIndexSet *)indexes wantsAnimate:(UITableViewRowAnimation)animationStyle;

@end
