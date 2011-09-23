//
//  YXDetailDisclosureCell.m
//  ModelTableViewFramework
//
//  Created by Vladislav Alekseev on 04.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

NSString *const YXDetailDisclosureCellInfoDefaultReuseIdentidier = @"YXDetailDisclosureCellInfoDefaultReuseIdentidier";

#import "YXDetailDisclosureCellInfo.h"

@implementation YXDetailDisclosureCellInfo

@synthesize detailText = _detailText;

+ (NSString *)defaultReuseIdentifier {
    return YXDetailDisclosureCellInfoDefaultReuseIdentidier;
}

+ (id)cellWithReuseTitle:(NSString *)title 
              detailText:(NSString *)detailText
                  target:(id)target 
                  action:(SEL)action {
    return [self cellWithReuseIdentifier:[self defaultReuseIdentifier]
                                   title:title 
                              detailText:detailText
                                  target:target
                                  action:action];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                        title:(NSString *)title 
                   detailText:(NSString *)detailText
                       target:(id)target 
                       action:(SEL)action {
	YXDetailDisclosureCellInfo * cell = [[self alloc] initWithReuseIdentifier:reuseIdentifier];
    
	cell.target = target;
	cell.action = action;
	
    cell.title = title;
	cell.detailText = detailText;
    
    return [cell autorelease];
}

- (void)dealloc {
    [_detailText release];
    
	[super dealloc];
}

- (UITableViewCell *)tableViewCell {
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
													reuseIdentifier:self.reuseIdentifier] autorelease];
	UIImageView *disclosureImageView = [[[UIImageView alloc] init] autorelease];
	[disclosureImageView setContentMode:UIViewContentModeCenter];
	cell.accessoryView = disclosureImageView;
	
	return cell;
}

- (void)configureCell:(UITableViewCell *)reusableCell {
    [super configureCell:reusableCell];
    reusableCell.detailTextLabel.text = self.detailText;
}

- (void)setDetailText:(NSString *)detailText {
    if (detailText == _detailText)
        return;
    
    [_detailText release];
    _detailText = [detailText copy];
    
    [self updateCellAppearenceAnimated:NO];
}

@end
