//
//  YXSegmentedTableViewCell.h
//  ModelTableViewFramework
//
//  Created by Vladislav Alekseev on 10.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat const kSegmentedHeightPlainStyle;
UIKIT_EXTERN CGFloat const kSegmentedHeightBarStyle;
UIKIT_EXTERN CGFloat const kSegmentedHeightBezeledStyle;

@interface YXSegmentedTableViewCell : UITableViewCell {
    UISegmentedControl *_segmentedControl;
	UITableViewStyle _tableViewStyle;
}
@property (nonatomic, retain) UISegmentedControl *segmentedControl;

- (void)setTarget:(id)target action:(SEL)action;

@end
