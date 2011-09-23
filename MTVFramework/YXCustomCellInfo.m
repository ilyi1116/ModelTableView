//
//  YXCell.m
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXCustomCellInfo.h"
#import "YXCustomCellInfoDelegate.h"

@implementation YXCustomCellInfo

@synthesize delegate = _delegate;
@synthesize cellConstructorSelector = _cellConstructorSelector;
@synthesize prepareForReuseSelector = _prepareForReuseSelector;

@synthesize target = _target;
@synthesize action = _action;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                     delegate:(id)delegate
          constructorSelector:(SEL)constructorSelector
      prepareForReuseSelector:(SEL)prepareForReuseSelector
                       target:(id)target
                       action:(SEL)action {
    YXCustomCellInfo *cell = [[self alloc] initWithReuseIdentifier:reuseIdentifier];
    
    [cell setDelegate:delegate];
    [cell setCellConstructorSelector:constructorSelector];
    [cell setPrepareForReuseSelector:prepareForReuseSelector];
    
    [cell setTarget:target];
    [cell setAction:action];
    
    [cell setDeselectsAutomatically:YES];
    
    return [cell autorelease];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
          constructorDelegate:(id <YXCustomCellInfoDelegate>)constructorDelegate
                       target:(id)target
                       action:(SEL)action {
    YXCustomCellInfo *cell = [[self alloc] initWithReuseIdentifier:reuseIdentifier];
    
    [cell setDelegate:constructorDelegate];
    
    [cell setTarget:target];
    [cell setAction:action];
    
    [cell setDeselectsAutomatically:YES];
    
    return [cell autorelease];
}

- (void)dealloc {
	self.delegate = nil;

	[super dealloc];
}

- (id)constructorDelegate {
    return _delegate;
}

- (void)setConstructorDelegate:(id<YXCustomCellInfoDelegate>)constructorDelegate {
    _delegate = constructorDelegate;
}

- (void)configureCell:(UITableViewCell *)reusableCell {
    [super configureCell:reusableCell];
    
    if (_delegate != nil) {
        if ([_delegate conformsToProtocol:@protocol(YXCustomCellInfoDelegate)]) {
            [_delegate prepareTableViewCellForReuse:reusableCell usingCellInfo:self];
        }
        else if (_prepareForReuseSelector != NULL) {
            [_delegate performSelector:_prepareForReuseSelector withObject:reusableCell withObject:self];
        }
	}
}

- (UITableViewCell *)tableViewCell {
 	if (_delegate != nil) {
        if ([_delegate conformsToProtocol:@protocol(YXCustomCellInfoDelegate)]) {
            return [_delegate constructTableViewCellForCellInfo:self];
        }
        else if (_cellConstructorSelector != NULL) {
            return [_delegate performSelector:_cellConstructorSelector withObject:self];
        }
	}
	return nil;   
}

- (void)tableView:(UITableView *)tableView didSelectCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectCell:cell atIndexPath:indexPath];
    
	if (_target != nil && _action != NULL) {
        // TODO: performSelectorOnMainThread
		[_target performSelector:_action withObject:self];
	}
}

@end
