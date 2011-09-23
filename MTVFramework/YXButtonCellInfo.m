//
//  YXButtonCell.m
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXButtonCellInfo.h"

NSString *const YXButtonCellInfoDefaultReuseIdentidier = @"YXButtonCellInfoDefaultReuseIdentidier";

@implementation YXButtonCellInfo

@synthesize title = _title;
@synthesize target = _target;
@synthesize action = _action;

+ (NSString *)defaultReuseIdentifier {
    return YXButtonCellInfoDefaultReuseIdentidier;
}

+ (id)cellWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    YXButtonCellInfo *cell = [[self alloc] initWithReuseIdentifier:[self defaultReuseIdentifier]];
    [cell setTitle:title];
    [cell setTarget:target];
    [cell setAction:action];
    return [cell autorelease];
}

+ (id)cellWithReuseIdentifier:(NSString*)reuseIdentifier 
                        title:(NSString*)title 
                       target:(id)target 
                       action:(SEL)action {
	YXButtonCellInfo *cell = [[self alloc] initWithReuseIdentifier:reuseIdentifier];
	cell.target = target;
	cell.action = action;
	cell.title = title;
	return [cell autorelease];
}

- (void)dealloc {
	_target = nil;
	_action = NULL;

	self.title = nil;

	[super dealloc];
}

- (UITableViewCell *)tableViewCell {
    return [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                   reuseIdentifier:self.reuseIdentifier] autorelease];
}

- (void)configureCell:(UITableViewCell *)reusableCell {
    [super configureCell:reusableCell];
	
	reusableCell.textLabel.text = self.title;
	reusableCell.textLabel.textAlignment = UITextAlignmentCenter;
}

- (void)applyStyleForCell:(UITableViewCell *)reusableCell {
	[super applyStyleForCell:reusableCell];
	

	reusableCell.textLabel.textColor = [UIColor colorWithRed:50.0f/255.0f
                                                       green:79.0f/255.0f
                                                        blue:133.0f/255.0f
                                                       alpha:1.0f]; 
}

- (void)setTitle:(NSString *)title {
    if (_title == title)
        return;
    
    [_title release];
    _title = [title copy];
    
    [self updateCellAppearenceAnimated:YES];
}

- (BOOL)shouldUpdateCell:(UITableViewCell *)tableViewCell usingRowAnimation:(UITableViewRowAnimation)animationStyle {
    [[tableViewCell textLabel] setText:self.title];
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if (_target != nil && _action != NULL) {
		[_target performSelector:_action withObject:self];
	}
}

@end
