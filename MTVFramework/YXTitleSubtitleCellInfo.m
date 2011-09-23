//
//  YXTitleSubtitleCellInfo.m
//  MTVFrameworkSamples
//
//  Created by Vladislav Alekseev on 24.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

#import "YXTitleSubtitleCellInfo.h"
#import "YXStyleInfo.h"

NSString *const YXTitleSubtitleCellInfoDefaultReuseIdentidier = @"YXTitleSubtitleCellInfoDefaultReuseIdentidier";

@implementation YXTitleSubtitleCellInfo

+ (NSString *)defaultReuseIdentifier {
	return YXTitleSubtitleCellInfoDefaultReuseIdentidier;
}

- (UITableViewCell *)tableViewCell {
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                    reuseIdentifier:[self reuseIdentifier]] autorelease];
    return cell;
}

- (void)applyStyleForCell:(UITableViewCell *)cell {
	[super applyStyleForCell:cell];
	
	[[cell textLabel] setFont:self.styleInfo.cellSubtitleTextFont];
	[[cell textLabel] setTextColor:self.styleInfo.cellSubtitleTextColor];
	[[cell textLabel] setHighlightedTextColor:self.styleInfo.cellSubtitleTextColorHighlighted];
	
	[[cell detailTextLabel] setFont:self.styleInfo.cellSubtitleDetailTextFont];
	[[cell detailTextLabel] setTextColor:self.styleInfo.cellSubtitleDetailTextColor];
	[[cell detailTextLabel] setHighlightedTextColor:self.styleInfo.cellSubtitleDetailTextColorHighlighted];
}

@end
