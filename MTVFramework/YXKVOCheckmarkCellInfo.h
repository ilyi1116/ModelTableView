//
//  YXKVOCheckmarkCell.h
//  YandexMaps
//
//  Created by Mikhail Kalugin on 6/30/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXCheckmarkCellInfo.h"

/**
 YXKVOCheckmarkCellInfo represents cell that can be selected and deselected. When selected, checkmark appears as accessoryType. When deselected, nothing displayed. YXKVOCheckmarkCellInfo "binds" to an object and observes it's value for specified key, automatically changing it's visual appearence. When user taps on the cell, it uses KVC mechanism to update object's value for key.
 Please note that this object shouldn't be used together with YXCheckmarkCellGroupInfo or YXKVOCheckmarkCellGroupInfo. If you want groups, please use regular YXCheckmarkCellInfo.
 */

@interface YXKVOCheckmarkCellInfo : YXCheckmarkCellInfo {
	id _object;
	NSString * _key;
	SEL _updateAction;
	id _updateTarget;
}
@property (nonatomic, copy) NSString *key;
@property (nonatomic, retain) id object;

+ (id)cellWithTitle:(NSString *)title
              image:(UIImage  *)image
      observeObject:(id)object 
             forKey:(NSString *)key;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
						title:(NSString *)title
						image:(UIImage  *)image
                observeObject:(id)object 
                       forKey:(NSString *)key;

@end
