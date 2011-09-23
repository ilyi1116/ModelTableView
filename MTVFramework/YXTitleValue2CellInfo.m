//
//  YXTitleValue2CellInfo.m
//  MTVFrameworkSamples
//
//  Created by Vladislav Alekseev on 24.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

#import "YXTitleValue2CellInfo.h"
#import "YXStyleInfo.h"

NSString *const YXTitleValue2CellInfoDefaultReuseIdentidier = @"YXTitleValue2CellInfoDefaultReuseIdentidier";

@implementation YXTitleValue2CellInfo

+ (NSString *)defaultReuseIdentifier {
	return YXTitleValue2CellInfoDefaultReuseIdentidier;
}

- (UITableViewCell *)tableViewCell {
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 
                                                    reuseIdentifier:[self reuseIdentifier]] autorelease];
    return cell;
}

- (void)applyStyleForCell:(UITableViewCell *)cell {
	[super applyStyleForCell:cell];
	
	[[cell textLabel] setFont:self.styleInfo.cellValue2TextFont];
	[[cell textLabel] setTextColor:self.styleInfo.cellValue2TextColor];
	[[cell textLabel] setHighlightedTextColor:self.styleInfo.cellValue2TextColorHighlighted];
	
	[[cell detailTextLabel] setFont:self.styleInfo.cellValue2DetailTextFont];
	[[cell detailTextLabel] setTextColor:self.styleInfo.cellValue2DetailTextColor];
	[[cell detailTextLabel] setHighlightedTextColor:self.styleInfo.cellValue2DetailTextColorHighlighted];
}

@end
