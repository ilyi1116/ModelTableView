//
//  YXTitleCellInfo.m
//  YandexFoundation
//
//  Created by Ruslan Sokolov on 7/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YXTitleCellInfo.h"
#import "YXStyleInfo.h"

NSString *const YXTitleCellInfoDefaultReuseIdentidier = @"YXTitleCellInfoDefaultReuseIdentidier";

@implementation YXTitleCellInfo

+ (NSString *)defaultReuseIdentifier {
	return YXTitleCellInfoDefaultReuseIdentidier;
}

+ (id)cellWithTitle:(NSString *)title {
    return [super cellWithTitle:title value:nil];
}

- (UITableViewCell *)tableViewCell {
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:[self reuseIdentifier]] autorelease];
    return cell;
}

- (void)applyStyleForCell:(UITableViewCell *)cell {
	[super applyStyleForCell:cell];
	
	[[cell textLabel] setFont:self.styleInfo.cellSubtitleTextFont];
	[[cell textLabel] setTextColor:self.styleInfo.cellSubtitleTextColor];
	[[cell textLabel] setHighlightedTextColor:self.styleInfo.cellSubtitleTextColorHighlighted];
}

- (void)configureCell:(UITableViewCell *)reusableCell {
    [super configureCell:reusableCell];
	
	reusableCell.textLabel.textAlignment = UITextAlignmentCenter;
}

@end
