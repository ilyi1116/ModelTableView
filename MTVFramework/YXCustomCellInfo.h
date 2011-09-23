//
//  YXCell.h
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXCellInfo.h"
#import "YXCustomCellInfoDelegate.h"

/**
 YXCustomCellInfo allows you to create your own UITableViewCell objects by transferring cell building procedure to other object outside Cell Info. Delegate is responsible to provide new UITableViewCell objects and re-configure them when needed. YXCustomCellInfo allows to work with delegate in two ways: using protocol YXCustomCellInfoDelegate and using Target-Action style. 
 */

@interface YXCustomCellInfo : YXCellInfo {
	id _delegate;
    SEL _cellConstructorSelector;
	SEL _prepareForReuseSelector;
    
    id _target;
	SEL _action;
}
@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) id <YXCustomCellInfoDelegate> constructorDelegate;

/**
 Selector for a method that should return a new cell that is ready for configuring. Typical signature: 
 - (UITableViewCell *)tableViewCellForMyCustomCell:(YXCustomCellInfo *)cellInfo;
 */
@property (nonatomic, assign) SEL cellConstructorSelector;

/**
 Selector for a method that used for configuring UITableViewCell object for displaying new information that Cell Info represents. Typical signature: 
 - (void)prepareForReuseMyCustomCell:(UITableViewCell *)cell usingCellInfo:(YXCustomCellInfo *)cellInfo;
 */
@property (nonatomic, assign) SEL prepareForReuseSelector;

/**
 Object on which action will be invoked on tap.
 */
@property (nonatomic, assign) id target;

/**
 Selector that will be invoked when user taps on the cell. Typical signature: 
 - (void)customCellInfoTapped:(YXCustomCellInfo *)cellInfo;
 */
@property (nonatomic, assign) SEL action;

// For constructorSelector and prepareForReuseSelector titles look at YXCustomCellDelegate

/**
 This method creates and returns YXCustomCellInfo object that uses YXCustomCellInfoDelegate protocol mechanism to perform cell contruction and configuration processes and Target-Action to perform action process.
 @param reuseIdentifier Cell Reuse Identifier
 @param constructorDelegate Object that conforms to protocol YXCustomCellInfoDelegate.
 @param target Object on which action will be invoked on tap.
 @param action Selector that will be invoked when user taps on the cell. Typical signature: - (void)customCellInfoTapped:(YXCustomCellInfo *)cellInfo;
 @return YXCustomCellInfo object that uses YXCustomCellInfoDelegate protocol style for doing it's operations.
 */
+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
          constructorDelegate:(id <YXCustomCellInfoDelegate>)constructorDelegate
                       target:(id)target
                       action:(SEL)action;

/**
 This method creates and returns YXCustomCellInfo object that uses Target-Action mechanism to perform cell contruction, configuration and action processes.
 @param reuseIdentifier Cell Reuse Identifier
 @param delegate Object responsible for creating and configuring UITableViewCell object.
 @param constructorSelector Selector for a method that should return a new cell that is ready for configuring. Typical signature: - (UITableViewCell *)tableViewCellForMyCustomCell:(YXCustomCellInfo *)cellInfo;
 @param prepareForReuseSelector Selector for a method that used for configuring UITableViewCell object for displaying new information that Cell Info represents. Typical signature: - (void)prepareForReuseMyCustomCell:(UITableViewCell *)cell usingCellInfo:(YXCustomCellInfo *)cellInfo;
 @param target Object on which action will be invoked on tap.
 @param action Selector that will be invoked when user taps on the cell. Typical signature: - (void)customCellInfoTapped:(YXCustomCellInfo *)cellInfo;
 @return YXCustomCellInfo object that uses Target-Action style for doing it's operations.
 */
+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                     delegate:(id)delegate
          constructorSelector:(SEL)constructorSelector
      prepareForReuseSelector:(SEL)prepareForReuseSelector
                       target:(id)target
                       action:(SEL)action;

@end
