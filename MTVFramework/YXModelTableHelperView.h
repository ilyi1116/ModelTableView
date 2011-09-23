//
//  YXModelTableViewHeaderView.h
//  YandexMaps
//
//  Created by Ruslan Sokolov on 4/20/11.
//  Copyright 2011 Yandex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
	YXModelTableViewHeaderViewMissionHeader,
	YXModelTableViewHeaderViewMissionFooter
} YXModelTableViewHeaderViewMission;

@class YXStyleInfo;

@interface YXModelTableHelperView : UIView {
    UITableViewStyle _tableViewStyle;
	UIImageView *_backgroundImageView;
    UILabel * _label;
    YXStyleInfo *_styleInfo;
	YXModelTableViewHeaderViewMission _mission;
}

@property (nonatomic, assign) UITableViewStyle tableViewStyle;
@property (nonatomic, retain) UIImage *backgroundImage;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, retain) YXStyleInfo *styleInfo;
@property (nonatomic, assign) YXModelTableViewHeaderViewMission mission;

+ (UIImage *)defaultPlainSectionBackgroundWithStyle:(YXStyleInfo *)styleInfo;
+ (id)tableSectionView;
- (CGSize)optimalSize;
- (CGSize)optimalSizeForWidth:(CGFloat)width;


@end
