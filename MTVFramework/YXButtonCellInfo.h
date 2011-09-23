//
//  YXButtonCell.h
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

UIKIT_EXTERN NSString *const YXButtonCellInfoDefaultReuseIdentidier;

#import <Foundation/Foundation.h>
#import "YXCellInfo.h"

/**
 YXButtonCellInfo is Cell Info class that represents Button with centered Title in face of UITableViewCell object. This "button cell" can be tapped and corresponding action will be invoked on the target.
 */

@interface YXButtonCellInfo : YXCellInfo {
	NSString * _title;
	id _target;
	SEL _action;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;

/**
 Constructor of YXButtonCellInfo object, returns YXButtonCellInfo object with default reuse identifier.
 @param title Title of the button that will be centered.
 @param target Object on which action will be invoked on tap.
 @param action Selector that will be invoked on tap. Selector signature has to be like this: 
 - (void)buttonCellInfoTapped:(YXButtonCell *)cellInfo;
 */
+ (id)cellWithTitle:(NSString *)title target:(id)target action:(SEL)action;

/**
 Default constructor of YXButtonCellInfo object. 
 @param reuseIdentifier Cell Identifier.
 @param title Title of the button that will be centered.
 @param target Object on which action will be invoked on tap.
 @param action Selector that will be invoked on tap. Selector signature has to be like this: 
 - (void)buttonCellInfoTapped:(YXButtonCell *)cellInfo;
*/
+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                        title:(NSString *)title 
                       target:(id)target 
                       action:(SEL)action;

@end
