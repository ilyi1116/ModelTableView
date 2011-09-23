//
//  YXStyleInfo.m
//  MTVFrameworkSamples
//
//  Created by Vladislav Alekseev on 19.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YXStyleInfo.h"

static inline NSBundle *MTVFBundle() {
	static NSBundle* bundle = nil;
	if (!bundle) {
		NSString* path = [[[NSBundle mainBundle] resourcePath]
						  stringByAppendingPathComponent:@"MTVFramework.bundle"];
		bundle = [[NSBundle bundleWithPath:path] retain];
	}
	return bundle;
}

@implementation YXStyleInfo

@synthesize controllerBackgroundColor = _controllerBackgroundColor;
@synthesize controllerGroupedBackgroundColor;

@synthesize tableViewBackgroundColor = _tableViewBackgroundColor;
@synthesize tableViewGroupedBackgroundColor;
@synthesize tableViewCellSeparatorStyle = _tableViewCellSeparatorStyle;
@synthesize tableViewCellSeparatorColor = _tableViewCellSeparatorColor;

// plain headers&footers
@synthesize tableViewHeaderBackgroundColor = _tableViewHeaderBackgroundColor;
@synthesize tableViewHeaderFont = _tableViewHeaderFont;
@synthesize tableViewHeaderTextColor = _tableViewHeaderTextColor;
@synthesize tableViewHeaderTextAlignment = _tableViewHeaderTextAlignment;
@synthesize tableViewHeaderShadowColor = _tableViewHeaderShadowColor;
@synthesize tableViewHeaderShadowOffset = _tableViewHeaderShadowOffset;

@synthesize tableViewFooterBackgroundColor = _tableViewFooterBackgroundColor;
@synthesize tableViewFooterFont = _tableViewFooterFont;
@synthesize tableViewFooterTextColor = _tableViewFooterTextColor;
@synthesize tableViewFooterTextAlignment = _tableVieFooterTextAlignment;
@synthesize tableViewFooterShadowColor = _tableViewFooterShadowColor;
@synthesize tableViewFooterShadowOffset = _tableViewFooterShadowOffset;

// grouped headers&footers
@synthesize tableViewGroupedHeaderBackgroundColor;
@synthesize tableViewGroupedHeaderFont;
@synthesize tableViewGroupedHeaderTextColor;
@synthesize tableViewGroupedHeaderTextAlignment;
@synthesize tableViewGroupedHeaderShadowColor;
@synthesize tableViewGroupedHeaderShadowOffset;

@synthesize tableViewGroupedFooterBackgroundColor;
@synthesize tableViewGroupedFooterFont;
@synthesize tableViewGroupedFooterTextColor;
@synthesize tableViewGroupedFooterTextAlignment;
@synthesize tableViewGroupedFooterShadowColor;
@synthesize tableViewGroupedFooterShadowOffset;

@synthesize cellBackgroundColor;
@synthesize cellSelectionStyle;

@synthesize cellDefaultTextFont;
@synthesize cellDefaultTextColor;
@synthesize cellDefaultTextColorHighlighted;
@synthesize cellSubtitleTextFont;
@synthesize cellSubtitleTextColor;
@synthesize cellSubtitleTextColorHighlighted;
@synthesize cellValue1TextFont;
@synthesize cellValue1TextColor;
@synthesize cellValue1TextColorHighlighted;
@synthesize cellValue2TextFont;
@synthesize cellValue2TextColor;
@synthesize cellValue2TextColorHighlighted;
@synthesize cellSubtitleDetailTextFont;
@synthesize cellSubtitleDetailTextColor;
@synthesize cellSubtitleDetailTextColorHighlighted;
@synthesize cellValue1DetailTextFont;
@synthesize cellValue1DetailTextColor;
@synthesize cellValue1DetailTextColorHighlighted;
@synthesize cellValue2DetailTextFont;
@synthesize cellValue2DetailTextColor;
@synthesize cellValue2DetailTextColorHighlighted;

@synthesize disclosureIndicatorCellIndicatorImage;
@synthesize disclosureIndicatorCellIndicatorImageHighlighted;
@synthesize checkmarkCellIndicatorImage;
@synthesize checkmarkCellIndicatorImageHighlighted;
@synthesize checkmarkCellCheckedTextColor;

@synthesize editableCellTextFont;
@synthesize editableCellTextColor;
@synthesize editableCellHighlightedTextColor;

@synthesize editableCellTextFieldFont;
@synthesize editableCellTextFieldColor;

+ (YXStyleInfo *)defaultStyleInfo {
	return [self iOSStyleInfo];
}

+ (YXStyleInfo *)defaultInvertedStyleInfo {
	return [self iOSInvertedStyleInfo];
}

+ (YXStyleInfo *)iOSStyleInfo {
    YXStyleInfo *styleInfo = [[self alloc] init];
	
	NSBundle *yandexFoundationBundle = MTVFBundle();
    
    [styleInfo setControllerBackgroundColor:[UIColor whiteColor]];
    [styleInfo setControllerGroupedBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    [styleInfo setTableViewBackgroundColor:[UIColor clearColor]];
    [styleInfo setTableViewGroupedBackgroundColor:[UIColor clearColor]];
    
    [styleInfo setTableViewCellSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [styleInfo setTableViewCellSeparatorColor:[UIColor grayColor]];
    
    [styleInfo setTableViewHeaderBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5]];
    [styleInfo setTableViewHeaderTextColor:[UIColor whiteColor]];
    [styleInfo setTableViewHeaderTextAlignment:UITextAlignmentLeft];
    [styleInfo setTableViewHeaderFont:[UIFont boldSystemFontOfSize:16.0f]];
    [styleInfo setTableViewHeaderShadowColor:[UIColor darkGrayColor]];
    [styleInfo setTableViewHeaderShadowOffset:CGSizeMake(0, 1)];
	
    [styleInfo setTableViewFooterBackgroundColor:[UIColor clearColor]];
    [styleInfo setTableViewFooterTextColor:[UIColor whiteColor]];
    [styleInfo setTableViewFooterTextAlignment:UITextAlignmentLeft];
    [styleInfo setTableViewFooterFont:[UIFont boldSystemFontOfSize:16.0f]];
    [styleInfo setTableViewFooterShadowColor:[UIColor grayColor]];
    [styleInfo setTableViewFooterShadowOffset:CGSizeMake(0, 1)];
    
    [styleInfo setTableViewGroupedHeaderBackgroundColor:[UIColor clearColor]];
    [styleInfo setTableViewGroupedHeaderTextColor:[UIColor colorWithRed:76.0/255.0 green:86.0/255.0 blue:106.0/255.0 alpha:1.0]];
    [styleInfo setTableViewGroupedHeaderTextAlignment:UITextAlignmentLeft];    
    [styleInfo setTableViewGroupedHeaderFont:[UIFont boldSystemFontOfSize:16]];
    [styleInfo setTableViewGroupedHeaderShadowColor:[UIColor colorWithWhite:1.0 alpha:0.95]];
    [styleInfo setTableViewGroupedHeaderShadowOffset:CGSizeMake(0, 1)];
	
    [styleInfo setTableViewGroupedFooterBackgroundColor:[UIColor clearColor]];
    [styleInfo setTableViewGroupedFooterTextColor:[UIColor colorWithRed:76.0/255.0 green:86.0/255.0 blue:106.0/255.0 alpha:1.0]];
    [styleInfo setTableViewGroupedFooterTextAlignment:UITextAlignmentCenter];
    [styleInfo setTableViewGroupedFooterFont:[UIFont systemFontOfSize:12]];
    [styleInfo setTableViewGroupedFooterShadowColor:[UIColor colorWithWhite:1.0 alpha:0.95]];
    [styleInfo setTableViewGroupedFooterShadowOffset:CGSizeMake(0, 1)];
    
    [styleInfo setCellBackgroundColor:[UIColor whiteColor]];
    [styleInfo setCellSelectionStyle:UITableViewCellSelectionStyleBlue];
    
	// Default
    [styleInfo setCellDefaultTextFont:[UIFont boldSystemFontOfSize:16]];
    [styleInfo setCellDefaultTextColor:[UIColor blackColor]];
    [styleInfo setCellDefaultTextColorHighlighted:[UIColor whiteColor]];
	
	// Value1
	[styleInfo setCellValue1TextFont:[UIFont boldSystemFontOfSize:16.0]];
	[styleInfo setCellValue1TextColor:[UIColor blackColor]];
	[styleInfo setCellValue1TextColorHighlighted:[UIColor whiteColor]];
	[styleInfo setCellValue1DetailTextFont:[UIFont systemFontOfSize:15]];
	[styleInfo setCellValue1DetailTextColor:[UIColor colorWithRed:0.196f green:0.309f blue:0.522f alpha:1.000f]];
	[styleInfo setCellValue1DetailTextColorHighlighted:[UIColor whiteColor]];
	
	// Value2
	[styleInfo setCellValue2TextFont:[UIFont boldSystemFontOfSize:12]];
	[styleInfo setCellValue2TextColor:[UIColor colorWithRed:0.318 green:0.400 blue:0.569 alpha:1.000]];
	[styleInfo setCellValue2TextColorHighlighted:[UIColor whiteColor]];
	[styleInfo setCellValue2DetailTextFont:[UIFont boldSystemFontOfSize:15]];
	[styleInfo setCellValue2DetailTextColor:[UIColor blackColor]];
	[styleInfo setCellValue2DetailTextColorHighlighted:[UIColor whiteColor]];
	
	// Subtitle
	[styleInfo setCellSubtitleTextFont:[UIFont boldSystemFontOfSize:17]];
	[styleInfo setCellSubtitleTextColor:[UIColor blackColor]];
	[styleInfo setCellSubtitleTextColorHighlighted:[UIColor whiteColor]];
	[styleInfo setCellSubtitleDetailTextFont:[UIFont systemFontOfSize:14]];
	[styleInfo setCellSubtitleDetailTextColor:[UIColor lightGrayColor]];
	[styleInfo setCellSubtitleDetailTextColorHighlighted:[UIColor whiteColor]];
	
	// disclosure
	NSString *disclosureIndicatorGrayPath = [yandexFoundationBundle pathForResource:@"YXDisclosureIndicatorGray" ofType:@"png"];
	UIImage *disclosureIndicatorGray = [UIImage imageWithContentsOfFile:disclosureIndicatorGrayPath];
	[styleInfo setDisclosureIndicatorCellIndicatorImage:disclosureIndicatorGray];
	NSString *disclosureIndicatorWhitePath = [yandexFoundationBundle pathForResource:@"YXDisclosureIndicatorWhite" ofType:@"png"];
	UIImage *disclosureIndicatorWhite = [UIImage imageWithContentsOfFile:disclosureIndicatorWhitePath];
	[styleInfo setDisclosureIndicatorCellIndicatorImageHighlighted:disclosureIndicatorWhite];
	
	// checkmark
	NSString *checkmarkIndicatorBluePath = [yandexFoundationBundle pathForResource:@"YXCheckmarkBlue" ofType:@"png"];
	UIImage *checkmarkIndicatorBlue = [UIImage imageWithContentsOfFile:checkmarkIndicatorBluePath];
	[styleInfo setCheckmarkCellIndicatorImage:checkmarkIndicatorBlue];
	NSString *checkmarkIndicatorWhitePath = [yandexFoundationBundle pathForResource:@"YXCheckmarkBlue" ofType:@"png"];
	UIImage *checkmarkIndicatorWhite = [UIImage imageWithContentsOfFile:checkmarkIndicatorWhitePath];
	[styleInfo setCheckmarkCellIndicatorImageHighlighted:checkmarkIndicatorWhite];
	[styleInfo setCheckmarkCellCheckedTextColor:[UIColor colorWithRed:0.196f green:0.309f blue:0.522f alpha:1.000f]];
	
	// Editable Cell
	[styleInfo setEditableCellTextFont:[UIFont boldSystemFontOfSize:16]];
	[styleInfo setEditableCellTextColor:[UIColor blackColor]];
	[styleInfo setEditableCellHighlightedTextColor:[UIColor whiteColor]];
	
	[styleInfo setEditableCellTextFieldFont:[UIFont systemFontOfSize:14]];
	[styleInfo setEditableCellTextFieldColor:[UIColor darkTextColor]];
    
    return [styleInfo autorelease];
}

+ (YXStyleInfo *)iOSInvertedStyleInfo {
    YXStyleInfo *styleInfo = [[self alloc] init];
	
	NSBundle *bundle = MTVFBundle();
    
    [styleInfo setControllerBackgroundColor:[UIColor blackColor]];
    [styleInfo setControllerGroupedBackgroundColor:[UIColor viewFlipsideBackgroundColor]];
    
    [styleInfo setTableViewBackgroundColor:[UIColor clearColor]];
    [styleInfo setTableViewGroupedBackgroundColor:[UIColor clearColor]];
    
    [styleInfo setTableViewCellSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [styleInfo setTableViewCellSeparatorColor:[UIColor lightGrayColor]];
    
    [styleInfo setTableViewHeaderBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
    [styleInfo setTableViewHeaderTextColor:[UIColor blackColor]];
    [styleInfo setTableViewHeaderTextAlignment:UITextAlignmentLeft];
    [styleInfo setTableViewHeaderFont:[UIFont boldSystemFontOfSize:16.0f]];
    [styleInfo setTableViewHeaderShadowColor:[UIColor lightGrayColor]];
    [styleInfo setTableViewHeaderShadowOffset:CGSizeMake(0, -1)];
	
    [styleInfo setTableViewFooterBackgroundColor:[UIColor clearColor]];
    [styleInfo setTableViewFooterTextColor:[UIColor blackColor]];
    [styleInfo setTableViewFooterTextAlignment:UITextAlignmentLeft];
    [styleInfo setTableViewFooterFont:[UIFont boldSystemFontOfSize:16.0f]];
    [styleInfo setTableViewFooterShadowColor:[UIColor lightGrayColor]];
    [styleInfo setTableViewFooterShadowOffset:CGSizeMake(0, -1)];
    
    [styleInfo setTableViewGroupedHeaderBackgroundColor:[UIColor clearColor]];
    [styleInfo setTableViewGroupedHeaderTextColor:[UIColor whiteColor]];
    [styleInfo setTableViewGroupedHeaderTextAlignment:UITextAlignmentLeft];    
    [styleInfo setTableViewGroupedHeaderFont:[UIFont boldSystemFontOfSize:16]];
    [styleInfo setTableViewGroupedHeaderShadowColor:[UIColor blackColor]];
    [styleInfo setTableViewGroupedHeaderShadowOffset:CGSizeMake(0, -1)];
	
    [styleInfo setTableViewGroupedFooterBackgroundColor:[UIColor clearColor]];
    [styleInfo setTableViewGroupedFooterTextColor:[UIColor whiteColor]];
    [styleInfo setTableViewGroupedFooterTextAlignment:UITextAlignmentCenter];
    [styleInfo setTableViewGroupedFooterFont:[UIFont systemFontOfSize:12]];
    [styleInfo setTableViewGroupedFooterShadowColor:[UIColor blackColor]];
    [styleInfo setTableViewGroupedFooterShadowOffset:CGSizeMake(0, -1)];
    
    [styleInfo setCellBackgroundColor:[UIColor blackColor]];
    [styleInfo setCellSelectionStyle:UITableViewCellSelectionStyleGray];
    
	// Default
    [styleInfo setCellDefaultTextFont:[UIFont boldSystemFontOfSize:16]];
    [styleInfo setCellDefaultTextColor:[UIColor whiteColor]];
    [styleInfo setCellDefaultTextColorHighlighted:[UIColor whiteColor]];
	
	// Value1
	[styleInfo setCellValue1TextFont:[UIFont boldSystemFontOfSize:16.0]];
	[styleInfo setCellValue1TextColor:[UIColor whiteColor]];
	[styleInfo setCellValue1TextColorHighlighted:[UIColor whiteColor]];
	[styleInfo setCellValue1DetailTextFont:[UIFont systemFontOfSize:14]];
	[styleInfo setCellValue1DetailTextColor:[UIColor whiteColor]];
	[styleInfo setCellValue1DetailTextColorHighlighted:[UIColor whiteColor]];
	
	// Value2
	[styleInfo setCellValue2TextFont:[UIFont boldSystemFontOfSize:12]];
	[styleInfo setCellValue2TextColor:[UIColor colorWithRed:0.318 green:0.400 blue:0.569 alpha:1.000]];
	[styleInfo setCellValue2TextColorHighlighted:[UIColor whiteColor]];
	[styleInfo setCellValue2DetailTextFont:[UIFont boldSystemFontOfSize:15]];
	[styleInfo setCellValue2DetailTextColor:[UIColor whiteColor]];
	[styleInfo setCellValue2DetailTextColorHighlighted:[UIColor whiteColor]];
	
	// Subtitle
	[styleInfo setCellSubtitleTextFont:[UIFont boldSystemFontOfSize:16]];
	[styleInfo setCellSubtitleTextColor:[UIColor whiteColor]];
	[styleInfo setCellSubtitleTextColorHighlighted:[UIColor whiteColor]];
	[styleInfo setCellSubtitleDetailTextFont:[UIFont systemFontOfSize:12]];
	[styleInfo setCellSubtitleDetailTextColor:[UIColor whiteColor]];
	[styleInfo setCellSubtitleDetailTextColorHighlighted:[UIColor whiteColor]];
	
	// disclosure
	NSString *disclosureIndicatorGrayPath = [bundle pathForResource:@"YXDisclosureIndicatorGray" ofType:@"png"];
	UIImage *disclosureIndicatorGray = [UIImage imageWithContentsOfFile:disclosureIndicatorGrayPath];
	[styleInfo setDisclosureIndicatorCellIndicatorImage:disclosureIndicatorGray];
	[styleInfo setDisclosureIndicatorCellIndicatorImageHighlighted:disclosureIndicatorGray];
	
	// checkmark
	NSString *checkmarkIndicatorWhitePath = [bundle pathForResource:@"YXCheckmarkBlue" ofType:@"png"];
	UIImage *checkmarkIndicatorWhite = [UIImage imageWithContentsOfFile:checkmarkIndicatorWhitePath];
	[styleInfo setCheckmarkCellIndicatorImage:checkmarkIndicatorWhite];
	[styleInfo setCheckmarkCellIndicatorImageHighlighted:checkmarkIndicatorWhite];
	[styleInfo setCheckmarkCellCheckedTextColor:[UIColor colorWithRed:1.000 green:0.980 blue:0.788 alpha:1.000]];
	
	// Editable Cell
	[styleInfo setEditableCellTextFont:[UIFont boldSystemFontOfSize:16]];
	[styleInfo setEditableCellTextColor:[UIColor whiteColor]];
	[styleInfo setEditableCellHighlightedTextColor:[UIColor whiteColor]];
	
	[styleInfo setEditableCellTextFieldFont:[UIFont systemFontOfSize:14]];
	[styleInfo setEditableCellTextFieldColor:[UIColor lightTextColor]];
    
    return [styleInfo autorelease];
}


@end
