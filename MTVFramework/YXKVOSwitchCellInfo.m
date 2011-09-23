//
//  YXKVOSwitchCell.m
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXKVOSwitchCellInfo.h"


@implementation YXKVOSwitchCellInfo

@synthesize object = _object;
@synthesize key = _key;

- (void)dealloc {
    [_object removeObserver:self forKeyPath:_key];
    
	self.object = nil;
	self.key = nil;

	[super dealloc];
}

+ (id)cellWithTitle:(NSString *)title 
      observeObject:(id)object 
             forKey:(NSString *)key {
    return [self cellWithReuseIdentifier:[self defaultReuseIdentifier]
                                   title:title
                           observeObject:object
                                  forKey:key];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                        title:(NSString *)title 
                observeObject:(id)object 
                       forKey:(NSString *)key {
    if (object == nil || key == nil) {
        return nil;
    }
    
    YXKVOSwitchCellInfo *cell = [[YXKVOSwitchCellInfo alloc] initWithReuseIdentifier:reuseIdentifier];
	cell.title = title;
	cell.target = cell;
	cell.initialValueGetter = @selector(initialValue:);
	cell.action = @selector(cellInfo:didChangeValue:);
	cell.selectionStyle = YXCellInfoSelectionStyleNone;
	
	cell.object = object;
	cell.key = key;
    
    [object addObserver:cell forKeyPath:key options:NSKeyValueObservingOptionNew context:nil];
    
    return [cell autorelease];
}

+ (id)cellWithTitle:(NSString *)title target:(id)target initialValueGetter:(SEL)initialValueGetter action:(SEL)action {
    @throw @"YXKVOSwitchCellInfo does not support cellWithTitle:target:initialValueGetter:action: method";
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title delegate:(id<YXSwitchCellInfoDelegate>)delegate {
    @throw @"YXKVOSwitchCellInfo does not support cellWithReuseIdentifier:title:delegate: method";
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                        title:(NSString *)title
                       target:(id)delegate
           initialValueGetter:(SEL)initialValueGetter
                       action:(SEL)action {
    @throw @"YXKVOSwitchCellInfo does not support cellWithReuseIdentifier:title:target:initialValueGetter:action: method";
}

- (NSNumber *)initialValue:(YXKVOSwitchCellInfo *)cell {
	return [_object valueForKey:_key];
}

- (void)cellInfo:(YXKVOSwitchCellInfo *)cell didChangeValue:(NSNumber *)newValue {
    _didChangeValue = YES;
	[_object setValue:newValue forKey:_key];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == [self object]) {
        if (_didChangeValue) {
            _didChangeValue = NO;
            return;
            // a brief explanation:
            // user tap switch, animation begins; then new value sets using KVC
            // then notification comes to this cellInfo that value changes (while animation still in progress)
            // then cellInfo updates it's cell, animation drops, flick occurs
            // to avoid this we ignore first update of value to allow animation to complete
        }
        [self updateCellAppearenceAnimated:YES];
    }
}

- (BOOL)shouldUpdateCell:(UITableViewCell *)tableViewCell usingRowAnimation:(UITableViewRowAnimation)animationStyle {
    UISwitch *switchControl = (UISwitch *)[tableViewCell accessoryView];
    
    BOOL updatedValue = [[_object valueForKey:_key] boolValue];
    [switchControl setOn:updatedValue animated:YES];
    
    return NO;
}

@end
