//
//  YXCell.h
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Sets UITableViewCell selection style. 
 */
typedef enum {
    YXCellInfoSelectionStyleNone,       /**< Represents UITableViewCellSelectionStyleNone. */
    YXCellInfoSelectionStyleBlue,       /**< Represents UITableViewCellSelectionStyleBlue. */
    YXCellInfoSelectionStyleGray,       /**< Represents UITableViewCellSelectionStyleGray. */
    YXCellInfoSelectionStyleInherited   /**< Attempts to get style from YXStyleInfo object. If no YXStyleInfo object set for the styleInfo property, uses UITableViewCellSelectionStyleBlue. */
} YXCellInfoSelectionStyle;

@class YXSectionInfo;
@class YXStyleInfo;

/**
 Abstract class that represents Cell Info object. This is the mother for all Cell Infos.
 You don't need to instantinate objects of YXCellInfo class directly. Instead, create objects of it's descendants.
 In fact, it won't allow you to instantinate object, it will return nil.
 */

@interface YXCellInfo : NSObject {
	NSString * _reuseIdentifier;
	id _userInfo;
    YXSectionInfo *_sectionInfo;
    CGFloat _rowHeight;
    BOOL _supportsSwipeToDelete;
    BOOL _allowsSelection;
    BOOL _deselectsAutomatically;
	BOOL _recessed;
    YXCellInfoSelectionStyle _selectionStyle;
    YXStyleInfo *_styleInfo;
}

/**
 Cell Identifier that will be used by UITableView to identify dequeueable cells.
 */
@property (nonatomic, copy) NSString *reuseIdentifier;
/**
 Object that can be attached to this Cell Info.
 */
@property (nonatomic, retain) id userInfo;
/**
 Section Info object that owns this Cell Info.
 */
@property (assign) YXSectionInfo *sectionInfo;
/**
 UITableViewCell height.
 */
@property (nonatomic, assign) CGFloat rowHeight;
/**
 Indicates whether cell supports swipe-to-delete gesture or not.
 */
@property (nonatomic, assign) BOOL supportsSwipeToDelete;
/**
 Indicates whether cell supports selection or not. If YES, cell will be selected and deselected in animated way. If no, cell will be highlighted on long-tap and deselected immedeatly without any animation.
 */
@property (nonatomic, assign) BOOL allowsSelection;
/**
 Indicates whether cell supports automatic deselection or not. If YES, cell will be deselected automatically (animated if allowsSelection is YES).
 */
@property (nonatomic, assign) BOOL deselectsAutomatically;

@property (nonatomic, assign) BOOL recessed;

@property (nonatomic, assign) YXCellInfoSelectionStyle selectionStyle;

@property (nonatomic, retain) YXStyleInfo *styleInfo;

/**
 Returns cell's default reuse identifier used by UITableView.
 @return NSString object that represents cell reuse idenifier. YXCellInfo class throws exception.
 */
+ (NSString *)defaultReuseIdentifier;

/**
 Returns stretchable UIImage object with thin white line at the top. When cell is has recessed property set to YES, 
 this image displayed in UIImageView background view of a table view cell and it looks like there is some kind of relief.
 */
+ (UIImage *)recessedBoundsImage;

/**
 Designated Initializer. 
 @param reuseIdentifier Cell Identifier that will be used by UITableView to identify dequeueable cells.
 @return Cell Info object with specified reuseIdentifier; nil if you are trying to create object of YXCellInfo class.
 */
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

/**
 This method is called when UITableView needs a new UITableViewCell object. Cell Info object responsible for creation ob this object.
 @return UITableViewCell ready to configure.
 */
- (UITableViewCell *)tableViewCell;

/**
 This method is called when UITableViewCell needs to be reconfigured and filled with new data. 
 Don't forget to [super configureCell:reusableCell] from subclass!
 @param reusableCell UITableViewCell object to configure.
 */
- (void)configureCell:(UITableViewCell *)reusableCell;

/**
 This method allows cellInfo to apply style described by YXStyleObject to a UITableViewCell. 
 If you subclass it, please call [super applyStyleForCell:cell];.
 @param cell UITableViewCell object to stylize.
 */
- (void)applyStyleForCell:(UITableViewCell *)cell;

/**
 Call this method to perform cell update. Usually this method invokes corresponding UITableView methods that updates the cell with UITableViewRowAnimationFade animation style.
 @param animated Indicates whether UITableView should update cell in animated way or not.
 */
- (void)updateCellAppearenceAnimated:(BOOL)animated;

/**
 This method called right before UITableView will update UITableViewCell and allows Cell Info to refresh UITableViewCell state using it's own manner and animations. Return YES to perform default update of tableViewCell using animation specified in animationStyle. If you want to implement your own animation or update cell state without reloading the whole UITableViewCell object, do this here and return NO. Default implementation returns YES.
 @param tableViewCell UITableViewCell object that is about to be reloaded
 @param animationStyle UITableViewRowAnimation style that will be used to update tableViewCell
 @return YES if you want to allow default UITableView cell reloading behaivor, or NO if you will perform update by yourself.
 */
- (BOOL)shouldUpdateCell:(UITableViewCell *)tableViewCell usingRowAnimation:(UITableViewRowAnimation)animationStyle;

/**
 Sent to Cell Info right before UITableViewCell will be shown on screen. This method applies style to the cell so you have to call super implementation of this method from your subclass.
 @param tableView UITableView that will show this cell
 @param cell UITableViewCell object that will be displayed in tableView
 @param indexPath NSIndexPath that describes cell place in tableView cells hierarchy.
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

/**
 Sent to Cell Info right before UITableViewCell will be selected. To allow selection return YES, otherwise return NO. Default implementation returns YES.
 @param tableView UITableView that serves the cell
 @param cell UITableViewCell object that will be selected in tableView
 @param indexPath NSIndexPath that describes cell place in tableView cells hierarchy.
 @return YES if you allow cell to be selected, otherwise NO.
 */
- (BOOL)tableView:(UITableView *)tableView willSelectCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

/**
 Sent to Cell Info right after UITableViewCell was selected. By default this method does nothing.
 @param tableView UITableView that serves the cell
 @param cell UITableViewCell object that was selected in tableView
 @param indexPath NSIndexPath that describes cell place in tableView cells hierarchy.
 */
- (void)tableView:(UITableView *)tableView didSelectCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView *)tableView didDeselectCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

/**
 Sent to Cell Info right after UITableViewCell's accessory button was tapped. By default this method does nothing.
 @param tableView UITableView that serves the cell
 @param cell UITableViewCell object whose accessory button was tapped
 @param indexPath NSIndexPath that describes cell place in tableView cells hierarchy.
 */
- (void)tableView:(UITableView *)tableView cellAccessoryButtonTapped:(UITableViewCell *)cell aIndexPath:(NSIndexPath *)indexPath;

@end
