//
//  YXKVOSwitchCell.h
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXSwitchCellInfo.h"

/**
 YXKVOSwitchCellInfo represents cell that has a UISwitch control. It uses KVO/KVC to observe object's value for specified key and update object's key with the new value.
 */

@interface YXKVOSwitchCellInfo : YXSwitchCellInfo {
	NSObject *_object;
	NSString *_key;
    BOOL _didChangeValue;
}

@property (nonatomic, retain) NSObject *object;
@property (nonatomic, copy) NSString *key;

+ (id)cellWithTitle:(NSString *)title 
      observeObject:(id)object 
             forKey:(NSString *)key;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                        title:(NSString *)title 
                observeObject:(id)object 
                       forKey:(NSString *)key;

@end
