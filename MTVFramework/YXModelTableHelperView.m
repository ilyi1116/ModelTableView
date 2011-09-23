//
//  YXModelTableViewHeaderView.m
//  YandexMaps
//
//  Created by Ruslan Sokolov on 4/20/11.
//  Copyright 2011 Yandex. All rights reserved.
//

#import "YXModelTableHelperView.h"
#import "YXStyleInfo.h"

@interface YXModelTableHelperView (HeaderViewInsider) 
- (void)applyStyle;
- (CGRect)labelFrame;
@end

@implementation YXModelTableHelperView

@synthesize tableViewStyle = _tableViewStyle;
@synthesize styleInfo = _styleInfo;
@synthesize mission = _mission;

+ (UIImage *)defaultPlainSectionBackgroundWithStyle:(YXStyleInfo *)styleInfo {
	CGSize imageSize = CGSizeMake(1.0, 17);
	
	UIGraphicsBeginImageContext(imageSize);
	
	CGContextRef currentContext = UIGraphicsGetCurrentContext();
	
	CGGradientRef glossGradient;
	CGColorSpaceRef rgbColorspace;
	size_t num_locations = 2;
	CGFloat locations[2] = { 0.0, 1.0 };

	CGFloat components[8] = { 0.565, 0.624, 0.667, 0.5,  // Start color
		0.722, 0.757, 0.784, 0.5 }; // End color
	
	rgbColorspace = CGColorSpaceCreateDeviceRGB();
	glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);

	CGPoint topCenter = CGPointMake(0.0f, 0.0f);
	CGPoint bottomCenter = CGPointMake(0.0f, imageSize.height);
	CGContextDrawLinearGradient(currentContext, glossGradient, topCenter, bottomCenter, 0);
	
	CGGradientRelease(glossGradient);
	CGColorSpaceRelease(rgbColorspace); 
	CGContextSetLineWidth(currentContext, 1.0);
	
	UIColor *bottomLineColor = [styleInfo tableViewCellSeparatorColor];
	CGContextSetStrokeColorWithColor(currentContext, [bottomLineColor CGColor]);
	CGContextMoveToPoint(currentContext, 0, bottomCenter.y);
	CGContextAddLineToPoint(currentContext, 1.0, bottomCenter.y);
	
	CGContextStrokePath(currentContext);
	
	UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	return [outputImage stretchableImageWithLeftCapWidth:0 topCapHeight:8];
}

+ (id)tableSectionView {
	YXModelTableHelperView *sectionView = [[self alloc] initWithFrame:CGRectZero];
	return [sectionView autorelease];
}

- (id)init {
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.numberOfLines = 0;
		
		_backgroundImageView = [[UIImageView alloc] initWithFrame:frame];
		[_backgroundImageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight]; 
		[self addSubview:_backgroundImageView];
        [self addSubview:_label];
		
//		[[_label layer] setBorderColor:[[UIColor grayColor] CGColor]];
//		[[_label layer] setBorderWidth:0.5];
//		[[self layer] setBorderColor:[[UIColor blackColor] CGColor]];
//		[[self layer] setBorderWidth:0.5];
		
		[self applyStyle];
    }
    return self;
}

- (CGRect)labelFrame {
	[_label sizeToFit];
	
	// получили размер лейбла
	CGRect labelFitnessFrame = [_label frame];
	
	return labelFitnessFrame;
}

- (CGSize)optimalSize {
	return [self optimalSizeForWidth:320.0];
}

- (CGSize)optimalSizeForWidth:(CGFloat)width {
	CGFloat labelLeftOffset;
	if ([self tableViewStyle] == UITableViewStyleGrouped) {
		labelLeftOffset = fmaxf((width - 130.0f) / 10.0f, 0.0f);
	}
	else {
		labelLeftOffset = 12.0f;
	}
	
	CGFloat fitsWidth = width - labelLeftOffset*2;
	CGFloat fitsHeight = MAXFLOAT;
	CGSize fits = [_label sizeThatFits:CGSizeMake(fitsWidth, fitsHeight)];
	
	CGSize optimalSize = CGSizeMake(width, 0.0);	
	if ([[_label text] length] == 0) {
		if (self.mission == YXModelTableViewHeaderViewMissionHeader && self.tableViewStyle == UITableViewStyleGrouped) {
			optimalSize = CGSizeMake(fits.width, 10.0f);
		}
		else if (self.tableViewStyle != UITableViewStylePlain) {
			optimalSize = CGSizeMake(fits.width, 10.0f);
		}
	}
	else {
		if ([self tableViewStyle] == UITableViewStylePlain) {
			optimalSize = CGSizeMake(fits.width, fits.height + 4.0f);
		}
		else {
			if (_mission == YXModelTableViewHeaderViewMissionHeader)
				optimalSize = CGSizeMake(fits.width, fits.height + 9.0f + 5.0f);
			else 
				optimalSize = CGSizeMake(fits.width, fits.height + 10.0f);
		}
	}
	
	return optimalSize;
}

- (void)layoutSubviews {
    [super layoutSubviews];
	
	CGRect superviewFrame = [[_label superview] frame];
	
	// подогнали размер лейбла тютелька-в-тютельку (это на совести UIKit)
	[_label sizeToFit];
	
	// получили размер лейбла
	CGRect labelFitnessFrame = [_label bounds];
	
	// получили отступ лейбла от левого края
	CGFloat labelLeftOffset;
	CGFloat labelTopOffset;
	if ([self tableViewStyle] == UITableViewStyleGrouped) {
		labelLeftOffset = fmaxf((CGRectGetWidth(self.bounds) - 130.0f) / 10.0f, 0.0f);
		if (_mission == YXModelTableViewHeaderViewMissionHeader)
			labelTopOffset = 5.0f;
		else 
			labelTopOffset = 0.0f;
	}
	else {
		labelLeftOffset = 12.0f;
		labelTopOffset = 0.0f;
	}
	
	CGFloat fitsWidth = superviewFrame.size.width - labelLeftOffset*2;
	CGFloat fitsHeight = MAXFLOAT;
	CGSize fits = [_label sizeThatFits:CGSizeMake(fitsWidth, fitsHeight)];
	
	// установили ширину лейбла, равную ширине headerView
	labelFitnessFrame.size.width = fitsWidth;
	
	// высота - та, что подсчитали
	labelFitnessFrame.size.height = fits.height;
	
	CGRect labelCenteredFrame = CGRectMake((int)labelLeftOffset, 
										   (int)labelTopOffset,
										   (int)CGRectGetWidth(labelFitnessFrame),
										   (int)CGRectGetHeight(labelFitnessFrame));
    
    _label.frame = labelCenteredFrame;
}

- (NSString *)text {
    return [_label text];
}

- (void)setText:(NSString *)text {
    [_label setText:text];
	[self sizeToFit];
}

- (UIImage *)backgroundImage {
	return [_backgroundImageView image];
}

- (void)setBackgroundImage:(UIImage *)image {
	[_backgroundImageView setImage:image];
}

- (void)setTableViewStyle:(UITableViewStyle)tableViewStyle {
    _tableViewStyle = tableViewStyle;
    [self applyStyle];
}

- (void)setStyleInfo:(YXStyleInfo *)styleInfo {
    if (styleInfo == _styleInfo)
        return;
    
    [_styleInfo release], _styleInfo = [styleInfo retain];
    [self applyStyle];
}

- (void)applyStyle {
    if (!self.styleInfo)
        return;
    _label.backgroundColor = [UIColor clearColor];
    
	if (_mission == YXModelTableViewHeaderViewMissionHeader) {
		if (self.tableViewStyle == UITableViewStylePlain) {
			_label.font = self.styleInfo.tableViewHeaderFont;
			_label.textColor = self.styleInfo.tableViewHeaderTextColor;
			_label.textAlignment = self.styleInfo.tableViewHeaderTextAlignment;
			_label.shadowColor = self.styleInfo.tableViewHeaderShadowColor;
			_label.shadowOffset = self.styleInfo.tableViewHeaderShadowOffset;
			
			self.backgroundColor = self.styleInfo.tableViewHeaderBackgroundColor;
			[_backgroundImageView setImage:[[self class] defaultPlainSectionBackgroundWithStyle:self.styleInfo]];
		}
		else {
			_label.font = self.styleInfo.tableViewGroupedHeaderFont;
			_label.textColor = self.styleInfo.tableViewGroupedHeaderTextColor;
			_label.textAlignment = self.styleInfo.tableViewGroupedHeaderTextAlignment;
			_label.shadowColor = self.styleInfo.tableViewGroupedHeaderShadowColor;
			_label.shadowOffset = self.styleInfo.tableViewGroupedHeaderShadowOffset;
			
			self.backgroundColor = self.styleInfo.tableViewGroupedHeaderBackgroundColor;
			[_backgroundImageView setImage:nil];
		}
	}
	else {
		if (self.tableViewStyle == UITableViewStylePlain) {
			_label.font = self.styleInfo.tableViewFooterFont;
			_label.textColor = self.styleInfo.tableViewFooterTextColor;
			_label.textAlignment = self.styleInfo.tableViewFooterTextAlignment;
			_label.shadowColor = self.styleInfo.tableViewFooterShadowColor;
			_label.shadowOffset = self.styleInfo.tableViewFooterShadowOffset;
			
			self.backgroundColor = self.styleInfo.tableViewFooterBackgroundColor;
			[_backgroundImageView setImage:[[self class] defaultPlainSectionBackgroundWithStyle:self.styleInfo]];
		}
		else {
			_label.font = self.styleInfo.tableViewGroupedFooterFont;
			_label.textColor = self.styleInfo.tableViewGroupedFooterTextColor;
			_label.textAlignment = self.styleInfo.tableViewGroupedFooterTextAlignment;
			_label.shadowColor = self.styleInfo.tableViewGroupedFooterShadowColor;
			_label.shadowOffset = self.styleInfo.tableViewGroupedFooterShadowOffset;
			
			self.backgroundColor = self.styleInfo.tableViewGroupedFooterBackgroundColor;
			[_backgroundImageView setImage:nil];
		}
	}
}

- (void)dealloc {
    [_label release];
	[_backgroundImageView release];
    
    [super dealloc];
}

@end
