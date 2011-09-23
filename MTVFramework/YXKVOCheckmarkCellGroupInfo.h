//
//  YXKVOCheckmarkCellGroup.h
//  ModelTableViewFramework
//
//  Created by Vladislav Alekseev on 06.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXCheckmarkCellGroupInfo.h"

/**
 YXKVOCheckmarkCellGroupInfo is object that allows you to group several YXCheckmarkCellInfo objects so only one selection can be made between several variants. Objects of this class DON'T represent visual objects. This is logic controller. You still have to add these YXCheckmarkCellInfo objects into YXSectionInfo in order to display them in UITableView. 
 This object behaves very similar to YXCheckmarkCellGroupInfo, but instead of directly set index of selected cell, it allows you to tell it to observe specific key of specific object and automatically change it's selection when key's value changes. On other side, there's no Target-Action behaviour anymore; instead of firing action on target, it uses KVC to set new value for key on object that it is observing.
 Please note that you should still use YXCheckmarkCellInfo objects to fill up this group with variants (not YXKVOCheckmarkCellInfo!). When you use +cellWithReuseIdentifier:title:image:group:selected: method of YXCheckmarkCellInfo with YXKVOCheckmarkCellGroupInfo, selected: argument will be ignored.
 */

@interface YXKVOCheckmarkCellGroupInfo : YXCheckmarkCellGroupInfo {
    id _object;
    NSString *_key;
}
@property (nonatomic, retain) id object;
@property (nonatomic, copy) NSString *key;

/**
 Creates and returns YXKVOCheckmarkCellGroupInfo object that listens for change notifications of key's value for given object.
 @param object Object to observe.
 @param key Object's key which value will be observed by this group.
 */
+ (id)checkmarkCellGroupObservingObject:(id)object forKey:(NSString *)key;

/**
 Puts YXCheckmarkCellInfo object into this group. 
 @param cellInfo YXCheckmarkCellInfo object to add into this group.
 */
- (void)addCheckmarkCellInfo:(YXCheckmarkCellInfo *)cellInfo;

@end
