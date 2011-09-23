//
//  YMSwitchCell.h
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

UIKIT_EXTERN NSString *const YXSwitchCellInfoDefaultReuseIdentidier;

#import <Foundation/Foundation.h>
#import "YXCellInfo.h"
#import "YXSwitchCellInfoDelegate.h"

/**
 YXSwitchCellInfo represents cell that has a UISwitch control. It uses target-action mechanism to get current value and set new value. It also provides YXSwitchCellInfoDelegate protocol mechanism for interacting with controller.
 */

@interface YXSwitchCellInfo : YXCellInfo {
	NSString * _title;
	id _target;
    id <YXSwitchCellInfoDelegate> _delegate;
	SEL _initialValueGetter;
	SEL _action;
}
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) id <YXSwitchCellInfoDelegate> delegate;
/**
 @brief Object responseble for providing initial BOOL value wrapped into NSNumber object and action processing. Action is fired only when new value was set.
 */
@property (nonatomic, assign) id target;

/** 
 @brief Method Selector that is asked for initial value. It's signature should look like this:
 - (NSNumber *)initialValueForMySwitchCellInfo:(YXSwitchCell *)cellInfo;
 */
@property (nonatomic, assign) SEL initialValueGetter;

/** 
 @brief Method Selector that used to pass new value to delegate. Action is fired only when new value was set. It's signature should look like this:
 - (void)mySwitchCellInfo:(YXSwitchCell *)cellInfo valueDidChange:(NSNumber *)newValue;
 */
@property (nonatomic, assign) SEL action;

/**
 Creates and returns YXSwitchCellInfo object using default reuse identifier.
 @param title Title of the cell.
 @param delegate Object responseble for providing initial BOOL value wrapped into NSNumber object and action processing
 @param initialValueGetter Method Selector that is asked for initial value. It's signature should look like this:
 - (NSNumber *)initialValueForMySwitchCellInfo:(YXSwitchCell *)cellInfo;
 @param action Method Selector that used to pass new value to delegate. It's signature should look like this:
 - (void)mySwitchCellInfo:(YXSwitchCell *)cellInfo valueDidChange:(NSNumber *)newValue;
 */
+ (id)cellWithTitle:(NSString *)title 
             target:(id)target 
 initialValueGetter:(SEL)initialValueGetter 
             action:(SEL)action;

/**
 Creates and returns YXSwitchCellInfo object using provided reuse identifier.
 @param reuseIdentifier Cell reuse identifier.
 @param title Title of the cell.
 @param delegate Object responseble for providing initial BOOL value wrapped into NSNumber object and action processing
 @param initialValueGetter Method Selector that is asked for initial value. It's signature should look like this:
 - (NSNumber *)initialValueForMySwitchCellInfo:(YXSwitchCell *)cellInfo;
 @param action Method Selector that used to pass new value to delegate. It's signature should look like this:
 - (void)mySwitchCellInfo:(YXSwitchCell *)cellInfo valueDidChange:(NSNumber *)newValue;
 */
+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                        title:(NSString *)title 
                       target:(id)delegate 
           initialValueGetter:(SEL)initialValueGetter 
                       action:(SEL)action;

/**
 Creates and returns YXSwitchCellInfo object using provided reuse identifier ready to work using YXSwitchCellInfoDelegate protocol. 
 @param reuseIdentifier Cell reuse identifier.
 @param title Title of the cell.
 @param delegate Object that conforms to YXSwitchCellInfoDelegate protocol. If object does not conform to, this method returns nil.
 @return YXSwitchCellInfo object; nil if object does not conform to YXSwitchCellInfoDelegate protocol.
 */
+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                        title:(NSString *)title 
                     delegate:(id <YXSwitchCellInfoDelegate>)delegate;

@end
