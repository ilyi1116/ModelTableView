//
//  YXCustomCellDelegate.h
//  ModelTableViewFramework
//
//  Created by Vladislav Alekseev on 04.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXCustomCellInfo;

/**
 This protocol formalizes process of creating and configuring custom cells.
 */

@protocol YXCustomCellInfoDelegate <NSObject>

@required
/**
 This method invoked when UITableView needs new cell with corresponding Cell Identifier. 
 @param cellInfo Cell Info object that describes UITableViewCell object structure and content.
 @return New UITableViewCell autoreleased object.
 */
- (UITableViewCell *)constructTableViewCellForCellInfo:(YXCustomCellInfo *)cellInfo;

/**
 This method invoked before UITableView will display cell and allow you to configure cell using information described by Cell Info object.
 @param cell UITableViewCell object that should be reconfigured.
 @param cellInfo YXCustomCellInfo object that describes cell that will be configured and displayed.
 */
- (void)prepareTableViewCellForReuse:(UITableViewCell *)cell usingCellInfo:(YXCustomCellInfo *)cellInfo;

@end
