//
//  YMSwitchCell.m
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

NSString *const YXSwitchCellInfoDefaultReuseIdentidier = @"YXSwitchCellInfoDefaultReuseIdentidier";

#import "YXSwitchCellInfo.h"
#import "YXSwitchCellInfoDelegate.h"

@implementation YXSwitchCellInfo

@synthesize delegate = _delegate;
@synthesize title = _title;
@synthesize target = _target;
@synthesize initialValueGetter = _initialValueGetter;
@synthesize action = _action;

+ (NSString *)defaultReuseIdentifier {
    return YXSwitchCellInfoDefaultReuseIdentidier;
}

- (void)dealloc {
	self.title = nil;
	
	[super dealloc];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                        title:(NSString *)title 
                     delegate:(id <YXSwitchCellInfoDelegate>)delegate {
    if ([delegate conformsToProtocol:@protocol(YXSwitchCellInfoDelegate)] == NO) {
        return nil;
    }
    
    YXSwitchCellInfo *cell = [[YXSwitchCellInfo alloc] initWithReuseIdentifier:reuseIdentifier];
    [cell setTitle:title];
    [cell setDelegate:delegate];
    cell.selectionStyle = YXCellInfoSelectionStyleNone;
    return [cell autorelease];
}

+ (id)cellWithTitle:(NSString *)title 
             target:(id)target 
 initialValueGetter:(SEL)initialValueGetter 
             action:(SEL)action {
    return [self cellWithReuseIdentifier:[self defaultReuseIdentifier]
                                   title:title
                                  target:target
                      initialValueGetter:initialValueGetter
                                  action:action];
}

+ (id)cellWithReuseIdentifier:(NSString*)reuseIdentifier 
                        title:(NSString*)title 
                       target:(id)target 
           initialValueGetter:(SEL)initialValueGetter 
                       action:(SEL)changeHandler {
	YXSwitchCellInfo * cell = [[YXSwitchCellInfo alloc] initWithReuseIdentifier:reuseIdentifier];
	cell.target = target;
	cell.title = title;
	cell.initialValueGetter = initialValueGetter;
	cell.action = changeHandler;
    cell.selectionStyle = YXCellInfoSelectionStyleNone;
	return [cell autorelease];
}

- (UITableViewCell *)tableViewCell {
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                                    reuseIdentifier:self.reuseIdentifier] autorelease];
    UISwitch *switchControl = [[UISwitch alloc] initWithFrame:CGRectZero];
    [cell setAccessoryView:switchControl];
    [switchControl release];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)reusableCell {
    [super configureCell:reusableCell];
    
    UISwitch *switchControl = (UISwitch *)[reusableCell accessoryView];
    [switchControl removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [switchControl addTarget:self 
					  action:@selector(switchControlChanged:) 
			forControlEvents:UIControlEventValueChanged];
    
    [[reusableCell textLabel] setText:self.title];
    
    if (_delegate != nil && [_delegate conformsToProtocol:@protocol(YXSwitchCellInfoDelegate)]) {
        switchControl.on = [_delegate booleanStateForSwitchCellInfo:self];
    }
    else if (_target != nil && _initialValueGetter != NULL) { 
		switchControl.on = [[_target performSelector:_initialValueGetter withObject:self] boolValue];
	}
}

- (void)switchControlChanged:(UISwitch *)switchControl {
    BOOL newValue = [switchControl isOn];
    BOOL currentValue;
    
    if ([_delegate conformsToProtocol:@protocol(YXSwitchCellInfoDelegate)]) {
        currentValue = [_delegate booleanStateForSwitchCellInfo:self];
    }
    else if (_target != nil && _initialValueGetter != nil) {
        currentValue = [[_target performSelector:_initialValueGetter withObject:self] boolValue];
    }
    else {
        // can't get value because non of getters are implemented
        currentValue = !newValue;
    }
    
    // если быстро нажать на свитч дважды, этот метод сработает для старого значения
    if (currentValue == newValue) 
        return;
    
    if (_delegate != nil && [_delegate conformsToProtocol:@protocol(YXSwitchCellInfoDelegate)]) {
        if ([_delegate respondsToSelector:@selector(switchCellInfo:didChangeValue:)]) {
            [_delegate switchCellInfo:self didChangeValue:newValue];
        }
    }
    else if (_target != nil && _action != NULL) {
		[_target performSelector:_action withObject:self withObject:[NSNumber numberWithBool:newValue]];
	}
}

@end
