//
//  YXStaticValueCell.m
//  YandexMaps
//
//  Created by Mikhail Kalugin on 6/29/10.
//  Copyright 2010 Yandex. All rights reserved.
//

NSString *const YXTitleValueCellInfoDefaultReuseIdentidier = @"YXTitleValueCellInfoDefaultReuseIdentidier";

#import <QuartzCore/QuartzCore.h>

#import "YXTitleValueCellInfo.h"
#import "YXStyleInfo.h"

@implementation YXTitleValueCellInfo

@synthesize title = _title;
@synthesize value = _value;
@synthesize target = _target;
@synthesize action = _action;

+ (NSString *)defaultReuseIdentifier {
    return YXTitleValueCellInfoDefaultReuseIdentidier;
}

- (void)dealloc {
	[_title release];
	[_value release];

	[super dealloc];
}

+ (id)cellWithTitle:(NSString *)title 
              value:(NSString *)value
             target:(id)target
             action:(SEL)action {
    return [self cellWithReuseIdentifier:[self defaultReuseIdentifier]
                                   title:title
                                   value:value
                                  target:target
                                  action:action];
}

+ (id)cellWithTitle:(NSString *)title 
              value:(NSString *)value {
    return [self cellWithReuseIdentifier:[self defaultReuseIdentifier]
                                   title:title
                                   value:value
                                  target:nil
                                  action:NULL];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                        title:(NSString *)title 
                        value:(NSString *)value 
                       target:(id)target
                       action:(SEL)action{
	YXTitleValueCellInfo * cell = [[self alloc] initWithReuseIdentifier:reuseIdentifier];
	cell.title = title;
	cell.value = value;
    cell.target = target;
    cell.action = action;
    
    if (target && action) {
        [cell setAllowsSelection:YES];
        [cell setDeselectsAutomatically:YES];
    }
    else {
        [cell setSelectionStyle:YXCellInfoSelectionStyleNone];
    }
	
	return [cell autorelease];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                        title:(NSString *)title 
                        value:(NSString *)value {
    return [self cellWithReuseIdentifier:reuseIdentifier
                                   title:title
                                   value:value
                                  target:nil
                                  action:NULL];
}

- (UITableViewCell *)tableViewCell {
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 
                                                    reuseIdentifier:[self reuseIdentifier]] autorelease];
    return cell;
}

- (void)configureCell:(UITableViewCell *)reusableCell {
    [super configureCell:reusableCell];
    
    [[reusableCell textLabel] setText:[self title]];
    [[reusableCell detailTextLabel] setText:[self value]];
}

- (BOOL)shouldUpdateCellUsingRegularAnimation:(UITableViewCell *)tableViewCell {
    // instead of animating cell, we animate only cell labels
    CATransition *fadeTransition = [CATransition animation];
    [fadeTransition setType:kCATransitionFade];
    
    [[[tableViewCell textLabel] layer] addAnimation:fadeTransition forKey:kCATransition];
    [[[tableViewCell detailTextLabel] layer] addAnimation:fadeTransition forKey:kCATransition];
    
    [[tableViewCell textLabel] setText:[self title]];
    [[tableViewCell detailTextLabel] setText:[self value]];
    
    return NO;
}

- (void)setTitle:(NSString *)newTitle {
    if (newTitle == _title) {
        return;
    }
    
    [_title release];
    _title = [newTitle copy];
    
    [self updateCellAppearenceAnimated:YES];
}

- (void)setValue:(NSString *)newValue {
    if (newValue == _value) {
        return;
    }
    
    [_value release];
    _value = [newValue copy];
    
    [self updateCellAppearenceAnimated:YES];
}

- (void)applyStyleForCell:(UITableViewCell *)cell {
	[super applyStyleForCell:cell];
	
	[[cell textLabel] setFont:self.styleInfo.cellValue1TextFont];
	[[cell textLabel] setTextColor:self.styleInfo.cellValue1TextColor];
	[[cell textLabel] setHighlightedTextColor:self.styleInfo.cellValue1TextColorHighlighted];
	
	[[cell detailTextLabel] setFont:self.styleInfo.cellValue1DetailTextFont];
	[[cell detailTextLabel] setTextColor:self.styleInfo.cellValue1DetailTextColor];
	[[cell detailTextLabel] setHighlightedTextColor:self.styleInfo.cellValue1DetailTextColorHighlighted];
}

- (void)tableView:(UITableView *)tableView didSelectCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectCell:cell atIndexPath:indexPath];
    
    if (self.target && self.action) {
        [[self target] performSelector:[self action] withObject:self];
    }
}

@end
