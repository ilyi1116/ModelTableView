//
//  YXDisclosureCell.m
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

NSString *const YXDisclosureCellInfoDefaultReuseIdentidier = @"YXDisclosureCellInfoDefaultReuseIdentidier";

#import "YXDisclosureCellInfo.h"
#import "YXStyleInfo.h"

@implementation YXDisclosureCellInfo

@synthesize title = _title;
@synthesize target = _target;
@synthesize action = _action;

+ (NSString *)defaultReuseIdentifier {
    return YXDisclosureCellInfoDefaultReuseIdentidier;
}

+ (id)cellWithTitle:(NSString *)title 
             target:(id)target 
             action:(SEL)action {
    return [self cellWithReuseIdentifier:[self defaultReuseIdentifier]
                                   title:title
                                  target:target
                                  action:action];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                        title:(NSString *)title 
                       target:(id)target 
                       action:(SEL)action {
	YXDisclosureCellInfo * cell = [[self alloc] initWithReuseIdentifier:reuseIdentifier];
    
	cell.target = target;
	cell.action = action;
    cell.title = title;
	
    return [cell autorelease];
}

- (void)dealloc {
	_target = nil;
	_action = NULL;
	
	[_title release];
    
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
    reusableCell.textLabel.text = self.title;
}

- (void)applyStyleForCell:(UITableViewCell *)cell {
	[super applyStyleForCell:cell];
	
	UIImageView *cellDisclosureImage = (UIImageView *)[cell accessoryView];
	[cellDisclosureImage setImage:self.styleInfo.disclosureIndicatorCellIndicatorImage];
	[cellDisclosureImage setHighlightedImage:self.styleInfo.disclosureIndicatorCellIndicatorImageHighlighted];
}

- (void)tableView:(UITableView *)tableView didSelectCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	[super tableView:tableView didSelectCell:cell atIndexPath:indexPath];
	
	if (_target != nil && _action != NULL) {
		[_target performSelector:_action withObject:self];
	}
}

- (void)setTitle:(NSString *)title {
    if (_title == title)
        return;
    
    [_title release];
    _title = [title copy];
    
    [self updateCellAppearenceAnimated:NO];
}

@end
