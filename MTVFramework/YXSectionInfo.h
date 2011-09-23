//
//  YXSection.h
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXSectionInfoDelegate.h"

@class YXModelTableViewController;
@class YXModelTableHelperView;
@class YXCellInfo;
@class YXStyleInfo;

/**
 YXSectionInfo represets UITableView Section, wrapping several YXCellInfo objects. 
 It can have header and footer, they can be regular NSStrings or UIViews. 
 YXSectionInfo object handles cell info manupulations, allowing you to perform adding, 
 inserting, updating and deleting operations.
 */

@interface YXSectionInfo : NSObject {
    YXModelTableViewController <YXSectionInfoDelegate> *_modelTableViewController;
    YXStyleInfo *_styleInfo;
	NSString * _header;
	NSString * _footer;
    YXModelTableHelperView * _headerView;
	YXModelTableHelperView * _footerView;
	NSMutableArray * _cells;
    BOOL _cellsCollapsed;
}
@property (assign) YXModelTableViewController <YXSectionInfoDelegate> *modelTableViewController;
@property (nonatomic, retain) YXStyleInfo *styleInfo;
@property (nonatomic, retain) YXModelTableHelperView *headerView;
@property (nonatomic, retain) YXModelTableHelperView *footerView;
@property (nonatomic, copy) NSString *header;
@property (nonatomic, copy) NSString *footer;
@property (nonatomic, readonly) NSArray *cells;
@property (nonatomic, assign) BOOL cellsCollapsed;

/**
 Creates and returns new autoreleased YXSectionInfo object with empty header and footer.
 */
+ (id)sectionInfo;

/**
 Creates and returns new autoreleased YXSectionInfo object with given header and footer.
 */
+ (id)sectionInfoWithHeader:(NSString *)header footer:(NSString*)footer;

/**
 Returns class which instance will be used as header view for this section.
 You can subclass this method to make section use your own header class without setting header view manually.
 */
+ (Class)headerHelperViewClass;

/**
 Returns class which instance will be used as footer view for this section. 
 You can subclass this method to make section use your own footer class without setting footer view manually.
 */
+ (Class)footerHelperViewClass;

/**
 Creates and returns new YXSectionInfo object with given header and footer.
 */
- (id)initWithHeader:(NSString *)header footer:(NSString*)footer;

/**
 Adds given YXCellInfo object into the section and performs insertion with given animation style if UITableView loaded by View Controller.
 @param cellInfo YXCellInfo object to insert into the section.
 @param animationStyle UITableViewRowAnimation to apply when inserting cellInfo.
 */
- (void)addCellInfo:(YXCellInfo *)cellInfo animateWithStyle:(UITableViewRowAnimation)animationStyle;

/**
 Adds given YXCellInfo object into the section and performs insertion with fade animation if UITableView loaded by View Controller.
 @param cellInfo YXCellInfo object to insert into the section.
 @param animated Indicates whether to apply UITableViewRowAnimationFade animation when inserting cellInfo.
 */
- (void)addCellInfo:(YXCellInfo *)cellInfo animated:(BOOL)animated;

/**
 Adds given YXCellInfo object into the section.
 @param cellInfo YXCellInfo object to insert into the section.
 */
- (void)addCellInfo:(YXCellInfo *)cellInfo;

/**
 Inserts given YXCellInfo object into the section at given index and performs insertion with given animation style if UITableView loaded by View Controller.
 @param cellInfo YXCellInfo object to insert into the section.
 @param index Inserts YXCellInfo object at this index.
 @param animationStyle UITableViewRowAnimation to apply when inserting cellInfo.
 */
- (void)insertCellInfo:(YXCellInfo *)cellInfo atIndex:(NSUInteger)index animateWithStyle:(UITableViewRowAnimation)animationStyle;

/**
 Use this method to insert target cellInfo that can be used in transitions. 
 This method does not update tableView when you invoke it, it was designed specifically for transitions.
 @param cellInfo YXCellInfo object which cell will act as a target in transition.
 @param index Position at which cellInfo will be inserted.
 */
- (void)insertTransitionCellInfo:(YXCellInfo *)cellInfo atIndex:(NSUInteger)index;

/**
 Deletes YXCellInfo objects at given indexes from the section and performs deletion with given animation style if UITableView loaded by View Controller. UITableView performs this operation as one-step operation and removes corresponding cells simultaneously.
 @param indexSet NSIndexSet object with indexes to delete.
 @param animationStyle UITableViewRowAnimation to apply when deleting cellInfo at given indexes.
 */
- (void)deleteCellInfoWithIndexes:(NSIndexSet *)indexSet animateWithStyle:(UITableViewRowAnimation)animationStyle;

/**
 Deletes YXCellInfo object from the section and performs deletion with given animation style if UITableView loaded by View Controller.
 @param cellInfo YXCellInfo object to be removed from the section.
 @param animationStyle UITableViewRowAnimation to apply when deleting cellInfo at given indexes.
 */
- (void)removeCellInfo:(YXCellInfo *)cellInfo animateWithStyle:(UITableViewRowAnimation)animationStyle;

/**
Deletes YXCellInfo object from the section and performs deletion with fade animation style if UITableView loaded by View Controller.
@param cellInfo YXCellInfo object to be removed from the section.
@param animated Indicates whether to apply UITableViewRowAnimationFade animation when inserting cellInfo.
*/
- (void)removeCellInfo:(YXCellInfo *)cellInfo animated:(BOOL)animated;

/**
 Deletes YXCellInfo object from the section without animation.
 @param cellInfo YXCellInfo object to be removed from the section.
 */
- (void)removeCellInfo:(YXCellInfo *)cellInfo;

- (void)removeAllCellInfoAnimated:(BOOL)animated;
- (void)removeAllCellInfoWithAnimationStyle:(UITableViewRowAnimation)animationStyle;

/**
 This method was designed for transition purposes and you may not want to call it directly.
 It removes specified YXCellInfo object without updating tableView.
 This method is called automatically by YXModelTableViewController.
 @param cellInfo YXCellInfo object which cell will be removed from the section.
 */
- (void)transitionWantsToRemoveCellInfo:(YXCellInfo *)cellInfo;

/**
 Updates corresponding cells of YXCellInfo objects at given indexes of the section performing this operation with fade animation style if UITableView loaded by View Controller.
 @param indexSet NSIndexSet object with indexes whose corresponding cells should be updated.
 @param animated Indicates whether to apply UITableViewRowAnimationFade animation when updating cellInfo cells.
 */
- (void)updateRowsWithIndexes:(NSIndexSet *)indexSet animated:(BOOL)animated;

/**
 Reloads section content using fade animation if animated specified. All cells will be refreshed.
 @param animated Indicates whether to apply UITableViewRowAnimationFade animation when updating section content.
 */
- (void)updateSectionAnimated:(BOOL)animated;

/**
 Allows to animate hiding section's cells.
 @param collapsed If YES, cell will be hidden, if NO - shown.
 @param animated If YES, cell hiding will be animated.
 */
- (void)setCellsCollapsed:(BOOL)collapsed animated:(BOOL)animated;

/**
 Returns array of cells even if this section is collapsed.
 */
- (NSArray *)content;

@end
