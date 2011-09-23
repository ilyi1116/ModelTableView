//
//  YXSwitchCellDelegate.h
//  ModelTableViewFramework
//
//  Created by Vladislav Alekseev on 04.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YXSwitchCellInfo;

@protocol YXSwitchCellInfoDelegate <NSObject>

@required
- (BOOL)booleanStateForSwitchCellInfo:(YXSwitchCellInfo *)cellInfo;
@optional
- (void)switchCellInfo:(YXSwitchCellInfo *)cellInfo didChangeValue:(BOOL)newValue;

@end
