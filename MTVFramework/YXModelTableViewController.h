//
//  YXModelTableViewController.h
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YXCustomCellInfo.h"

#import "YXSectionInfo.h"
#import "YXSectionInfoDelegate.h"

#import "UITableView+ExtendedAnimations.h"

@class YXStyleInfo;

/** 
 YXModelTableViewController is UIViewController that able to display UITableViewCells described by YXCellInfos organized into sections by means of YXSectionInfo objects. It's style can be described using YXStyleInfo objects. It provieds conveniet methods to manage UITableView content using YXCellInfo and YXSectionInfo objects, allowing you to insert, remove and update particular sections and cell info objects.
 */

/**
 Describes position where object will be inserted.
 */
typedef enum {
    YXSectionInsertionPositionTop,      /**< Inserts object at the top. */
    YXSectionInsertionPositionBottom    /**< Inserts object at the bottom */
} YXSectionInsertionPosition;

@interface YXModelTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, 
YXSectionInfoDelegate,
YXTableViewExtendedDelegate> {
	NSArray *_sections;
    YXStyleInfo *_styleInfo;
	UITableView *_tableView;
    UITableViewStyle _tableViewStyle;
}

/**
 NSArray of sections to be displayed.
 */
@property (nonatomic, copy) NSArray *sections;

/**
 Style that will be applied to UITableView, it's section and cells.
 */
@property (nonatomic, retain) YXStyleInfo *styleInfo;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

/**
 Style of UITableView. Can be changed in runtime (UITableView will be recreated)
 */
@property (nonatomic, assign) UITableViewStyle tableViewStyle;

- (id)initWithStyle:(UITableViewStyle)style;

/**
 Calls -beginUpdates method on the UITableView allowing you to specify operations to be processes atomically. You should call this method if you want to perform several updates, deletes or insertions as one atomic step (and especially if you want this to be animated)
 */
- (void)beginUpdates;

/**
 Calls -endUpdates method on the UITableView. After this UITableView will perform all queued operations (operations, that was specified between -beginUpdates and -endUpdates methods).
 */
- (void)endUpdates;

/**
 Replaces current sections with new. If you will pass animated, it will animate replacement procees with UITableViewRowAnimationFade animation style.
 @param sections NSArray of YXSectionInfo objects.
 @param animated Indicates whether replacement operation should animated using UITableViewRowAnimationFade animation style.
 */
- (void)setSections:(NSArray *)sections animated:(BOOL)animated;

- (void)insertSection:(YXSectionInfo *)section atPosition:(YXSectionInsertionPosition)position withAnimation:(UITableViewRowAnimation)animationStyle;
- (void)insertSection:(YXSectionInfo *)section atIndex:(NSUInteger)index withAnimation:(UITableViewRowAnimation)animationStyle;
- (void)deleteSection:(YXSectionInfo *)section withAnimation:(UITableViewRowAnimation)animationStyle;
- (void)deleteSectionAtIndex:(NSUInteger)sectionNumber withAnimationStyle:(UITableViewRowAnimation)animationStyle;

- (void)reloadSection:(YXSectionInfo *)section withAnimationStyle:(UITableViewRowAnimation)animationStyle;
- (void)reloadSection:(YXSectionInfo *)section animated:(BOOL)animated;
- (void)reloadSectionAtIndex:(NSUInteger)sectionNumber withAnimationStyle:(UITableViewRowAnimation)animationStyle;
- (void)reloadSection:(YXSectionInfo *)section;

/**
 Makes a transition from one cellInfo to another. Corresponding table view cell 
 moves from it's position while cross-fading to new cell for that new position. 
 This method uses UITableView+ExtendedAnimations category to perform transitions.
 Before calling this method, you need to create target YXCellInfo object and add it
 to the corresponding section using YXSectionInfo's insertTransitionCellInfo:atIndex: method.
 @param fromCellInfo YXCellInfo object which cell will be act as a source cell in this transition. 
 This cellInfo needs to be in it's sectionView and will be removed from it automatically when transition will be finished.
 @param toCellInfo YXCellInfo object which cell will be act as a target cell in this transition. 
 You need to add it to the target sectionInfo using YXSectionInfo's insertTransitionCellInfo:atIndex: method before calling this method.
 */
- (void)transitCellInfo:(YXCellInfo *)fromCellInfo toCellInfo:(YXCellInfo *)toCellInfo;

- (void)moveCellInfo:(YXCellInfo *)cellInfo toSectionInfo:(YXSectionInfo *)sectionInfo atIndex:(NSUInteger)index;

- (void)exchangeCellInfo:(YXCellInfo *)cellInfo1 withCellInfo:(YXCellInfo *)cellInfo2;

/**
 Attempts to find specified YXCellInfo object in sections' children. If such object can't be found, does nothing.
 @param cellInfo YXCellInfo object whose related UITableViewCell should be updated.
 @param animationType Animation type.
 */
- (void)updateCellForCellInfo:(YXCellInfo *)cellInfo withRowAnimation:(UITableViewRowAnimation)animationType;

/**
 Attempts to find specified YXCellInfo object in sections' children. If such object can't be found, does nothing.
 @param cellInfo YXCellInfo object whose related UITableViewCell should be updated.
 @param animated If YES, animates update process with UITableViewRowAnimationFade animation style.
 */
- (void)updateCellForCellInfo:(YXCellInfo *)cellInfo animated:(BOOL)animated;

/**
 Attempts to find specified YXCellInfo object in sections' children. If such object can't be found, does nothing.
 @param cellInfo YXCellInfo object whose related UITableViewCell should be updated.
 */
- (void)updateCellForCellInfo:(YXCellInfo *)cellInfo;

/**
 Returns YXCellInfo object at specified Index Path.
 @param indexPath NSIndexPath that specifies section and row of UITableViewCell whose YXCellInfo representation will be returned.
 @return YXCellInfo object.
 */
- (YXCellInfo *)cellInfoAtIndexPath:(NSIndexPath *)indexPath;

@end
