//
//  YXStyleInfo.h
//  MTVFrameworkSamples
//
//  Created by Vladislav Alekseev on 19.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YXStyleInfo : NSObject {
    UIColor *_controllerBackgroundColor;
    
    UIColor                             *_tableViewBackgroundColor;
    UITableViewCellSeparatorStyle       _tableViewCellSeparatorStyle;
    UIColor                             *_tableViewCellSeparatorColor;
    
    UIColor                             *_tableViewHeaderBackgroundColor;
    UIFont                              *_tableViewHeaderFont;
    UIColor                             *_tableViewHeaderTextColor;
    UITextAlignment                     _tableViewHeaderTextAlignment;
    UIColor                             *_tableViewHeaderShadowColor;
    CGSize                              _tableViewHeaderShadowOffset;
    
    UIColor                             *_tableViewFooterBackgroundColor;
    UIFont                              *_tableViewFooterFont;
    UIColor                             *_tableViewFooterTextColor;
    UITextAlignment                     _tableViewFooterTextAlignment;
    UIColor                             *_tableViewFooterShadowColor;
    CGSize                              _tableViewFooterShadowOffset;
}

+ (YXStyleInfo *)defaultStyleInfo;
+ (YXStyleInfo *)defaultInvertedStyleInfo;

+ (YXStyleInfo *)iOSStyleInfo;
+ (YXStyleInfo *)iOSInvertedStyleInfo;

@property (nonatomic, retain) UIColor *controllerBackgroundColor;
@property (nonatomic, retain) UIColor *controllerGroupedBackgroundColor;

@property (nonatomic, retain) UIColor *tableViewBackgroundColor;
@property (nonatomic, retain) UIColor *tableViewGroupedBackgroundColor;
@property (nonatomic, assign) UITableViewCellSeparatorStyle tableViewCellSeparatorStyle;
@property (nonatomic, retain) UIColor *tableViewCellSeparatorColor;

// headers and footers for UITableViewStylePlain
@property (nonatomic, retain) UIColor *tableViewHeaderBackgroundColor;
@property (nonatomic, retain) UIFont *tableViewHeaderFont;
@property (nonatomic, retain) UIColor *tableViewHeaderTextColor;
@property (nonatomic, assign) UITextAlignment tableViewHeaderTextAlignment;
@property (nonatomic, retain) UIColor *tableViewHeaderShadowColor;
@property (nonatomic, assign) CGSize tableViewHeaderShadowOffset;

@property (nonatomic, retain) UIColor *tableViewFooterBackgroundColor;
@property (nonatomic, retain) UIFont *tableViewFooterFont;
@property (nonatomic, retain) UIColor *tableViewFooterTextColor;
@property (nonatomic, assign) UITextAlignment tableViewFooterTextAlignment;
@property (nonatomic, retain) UIColor *tableViewFooterShadowColor;
@property (nonatomic, assign) CGSize tableViewFooterShadowOffset;

// headers and footers for UITableViewStyleGrouped
@property (nonatomic, retain) UIColor *tableViewGroupedHeaderBackgroundColor;
@property (nonatomic, retain) UIFont *tableViewGroupedHeaderFont;
@property (nonatomic, retain) UIColor *tableViewGroupedHeaderTextColor;
@property (nonatomic, assign) UITextAlignment tableViewGroupedHeaderTextAlignment;
@property (nonatomic, retain) UIColor *tableViewGroupedHeaderShadowColor;
@property (nonatomic, assign) CGSize tableViewGroupedHeaderShadowOffset;

@property (nonatomic, retain) UIColor *tableViewGroupedFooterBackgroundColor;
@property (nonatomic, retain) UIFont *tableViewGroupedFooterFont;
@property (nonatomic, retain) UIColor *tableViewGroupedFooterTextColor;
@property (nonatomic, assign) UITextAlignment tableViewGroupedFooterTextAlignment;
@property (nonatomic, retain) UIColor *tableViewGroupedFooterShadowColor;
@property (nonatomic, assign) CGSize tableViewGroupedFooterShadowOffset;

// cells
@property (nonatomic, retain) UIColor *cellBackgroundColor;
@property (nonatomic, assign) UITableViewCellSelectionStyle cellSelectionStyle;

@property (nonatomic, retain) UIFont *cellDefaultTextFont;
@property (nonatomic, retain) UIColor *cellDefaultTextColor;
@property (nonatomic, retain) UIColor *cellDefaultTextColorHighlighted;
@property (nonatomic, retain) UIFont *cellSubtitleTextFont;
@property (nonatomic, retain) UIColor *cellSubtitleTextColor;
@property (nonatomic, retain) UIColor *cellSubtitleTextColorHighlighted;
@property (nonatomic, retain) UIFont *cellValue1TextFont;
@property (nonatomic, retain) UIColor *cellValue1TextColor;
@property (nonatomic, retain) UIColor *cellValue1TextColorHighlighted;
@property (nonatomic, retain) UIFont *cellValue2TextFont;
@property (nonatomic, retain) UIColor *cellValue2TextColor;
@property (nonatomic, retain) UIColor *cellValue2TextColorHighlighted;
@property (nonatomic, retain) UIFont *cellSubtitleDetailTextFont;
@property (nonatomic, retain) UIColor *cellSubtitleDetailTextColor;
@property (nonatomic, retain) UIColor *cellSubtitleDetailTextColorHighlighted;
@property (nonatomic, retain) UIFont *cellValue1DetailTextFont;
@property (nonatomic, retain) UIColor *cellValue1DetailTextColor;
@property (nonatomic, retain) UIColor *cellValue1DetailTextColorHighlighted;
@property (nonatomic, retain) UIFont *cellValue2DetailTextFont;
@property (nonatomic, retain) UIColor *cellValue2DetailTextColor;
@property (nonatomic, retain) UIColor *cellValue2DetailTextColorHighlighted;

@property (nonatomic, retain) UIImage *disclosureIndicatorCellIndicatorImage;
@property (nonatomic, retain) UIImage *disclosureIndicatorCellIndicatorImageHighlighted;
@property (nonatomic, retain) UIImage *checkmarkCellIndicatorImage;
@property (nonatomic, retain) UIImage *checkmarkCellIndicatorImageHighlighted;
@property (nonatomic, retain) UIColor *checkmarkCellCheckedTextColor;

@property (nonatomic, retain) UIFont *editableCellTextFont;
@property (nonatomic, retain) UIColor *editableCellTextColor;
@property (nonatomic, retain) UIColor *editableCellHighlightedTextColor;
@property (nonatomic, retain) UIFont *editableCellTextFieldFont;
@property (nonatomic, retain) UIColor *editableCellTextFieldColor;

@end
