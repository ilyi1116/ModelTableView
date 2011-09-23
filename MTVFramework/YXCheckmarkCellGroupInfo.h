//
//  YXCheckmarkCellGroup.h
//  YandexMaps
//
//  Created by Mikhail Kalugin on 6/30/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXCheckmarkCellInfo.h"

/**
 YXCheckmarkCellGroupInfo is object that allows you to group several YXCheckmarkCellInfo objects so only one selection can be made between several variants. Objects of this class DON'T represent visual objects. This is logic controller. You still have to add these YXCheckmarkCellInfo objects into YXSectionInfo in order to display them in UITableView. YXCheckmarkCellInfo objects grouped into YXCheckmarkCellGroupInfo will behave like UISegmentedControl, each representing one item. Selecting one YXCheckmarkCellInfo object will automatically deselect previously selected YXCheckmarkCellInfo object. Additionally, YXCheckmarkCellGroupInfo supports Target-Action.
 */

@interface YXCheckmarkCellGroupInfo : NSObject {
	NSMutableArray *_cells;
	YXCheckmarkCellInfo *_selectedCell;
	
	id _delegate;
	SEL _changeHandler; // checkmarkCellGroup:group selectedCell:cell
}

/**
 Cells that currently in the group.
 */
@property (nonatomic, retain) NSArray *cells;

/**
 Returns currently selected YXCheckmarkCellInfo object.
 */
@property (nonatomic, assign) YXCheckmarkCellInfo *selectedCell;

/**
 Read-write property that returns index of currently selected cell and sets new selection if you will call setter method. If cell selection yet, returns NSUIntegerMax. If you will call setter with value more than maximum allowed index then cell with maximum allowed index will be selected.
 */
@property (nonatomic, readwrite) NSUInteger selectedIndex;

/**
 Target object on which will be invoked changeHandler when selection changes.
 */
@property (nonatomic, assign) id delegate;

/**
 Selector with the following sample signature:
 - (void)myCheckmarkGroup:(YXCheckmarkCellGroupInfo *)groupInfo didSelectCellWithIndex:(NSNumber *)newIndex;
 */
@property (nonatomic, assign) SEL changeHandler;

/**
 Returns new empty autoreleased group.
 @return New empty autoreleased group.
 */
+ (id)checkmarkCellGroup;

/** 
 Adds Checkmark Cell Info into the group. Instead of using this method directly, use more convinient method +cellWithReuseIdentifier:title:image:group:selected: of YXCheckmarkCellInfo object. 
 @param cell YXCheckmarkCellInfo object that will be added to the group.
 @param selected Indicates whether a cell should be marked as selected.
 */
- (void)addCheckmarkCellInfo:(YXCheckmarkCellInfo *)cell setSelected:(BOOL)selected;

/**
 Removes cell from group.
 @param cell YXCheckmarkCellInfo object that will be removed from the group.
 */
- (void)removeCheckmarkCellInfo:(YXCheckmarkCellInfo *)cell;

/**
 Marks cell as selected.
 */
- (void)selectCell:(YXCheckmarkCellInfo *)cell;

@end
