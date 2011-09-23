//
//  YXKVOTitleValueCell.m
//  ModelTableViewFramework
//
//  Created by Vladislav Alekseev on 06.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "YXKVOTitleValueCellInfo.h"
#import "YXTitleValueCellInfo.h"

@implementation YXKVOTitleValueCellInfo

@synthesize titleObject = _titleObject;
@synthesize titleKey = _titleKey;
@synthesize valueObject = _valueObject;
@synthesize valueKey = _valueKey;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
        observeObjectForTitle:(id)titleObject
                       forKey:(NSString *)titleKey
        observeObjectForValue:(id)valueObject
                       forKey:(NSString *)valueKey {
    if (titleObject == nil || titleKey == nil || valueObject == nil || valueKey == nil) {
        return nil;
    }
    
    YXKVOTitleValueCellInfo *cellInfo = [[YXKVOTitleValueCellInfo alloc] initWithReuseIdentifier:reuseIdentifier];
    
    [cellInfo setTitleObject:titleObject];
    [cellInfo setTitleKey:titleKey];
    [cellInfo setValueObject:valueObject];
    [cellInfo setValueKey:valueKey];
    
    [titleObject addObserver:cellInfo forKeyPath:titleKey options:NSKeyValueObservingOptionNew context:nil];
    [valueKey addObserver:cellInfo forKeyPath:valueKey options:NSKeyValueObservingOptionNew context:nil];
     
    return [cellInfo autorelease];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
        observeObjectForTitle:(id)titleObject
                       forKey:(NSString *)titleKey
                  staticValue:(NSString *)value {
    if (titleObject == nil || titleKey == nil) {
        return nil;
    }
    
    YXKVOTitleValueCellInfo *cellInfo = [[YXKVOTitleValueCellInfo alloc] initWithReuseIdentifier:reuseIdentifier];
    
    [cellInfo setTitleObject:titleObject];
    [cellInfo setTitleKey:titleKey];
    [cellInfo setValue:value];
    
    [titleObject addObserver:cellInfo forKeyPath:titleKey options:NSKeyValueObservingOptionNew context:nil];
    
    return [cellInfo autorelease];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                  staticValye:(NSString *)title
        observeObjectForValue:(id)valueObject
                       forKey:(NSString *)valueKey {
    if (valueObject == nil || valueKey == nil) {
        return nil;
    }
    
    YXKVOTitleValueCellInfo *cellInfo = [[YXKVOTitleValueCellInfo alloc] initWithReuseIdentifier:reuseIdentifier];
    
    [cellInfo setTitle:title];
    [cellInfo setValueObject:valueObject];
    [cellInfo setValueKey:valueKey];
    
    [valueObject addObserver:cellInfo forKeyPath:valueKey options:NSKeyValueObservingOptionNew context:nil];
    [valueKey addObserver:cellInfo forKeyPath:valueKey options:NSKeyValueObservingOptionNew context:nil];
    
    return [cellInfo autorelease];
}

- (void)dealloc {
    [_titleObject removeObserver:self forKeyPath:_titleKey];
    [_valueObject removeObserver:self forKeyPath:_valueKey];
    
    [_titleObject release];
    [_titleKey release];
    [_valueObject release];
    [_valueKey release];
    
    [super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath 
                      ofObject:(id)object 
                        change:(NSDictionary *)change 
                       context:(void *)context {
    if (object == [self titleObject] && [keyPath isEqualToString:_titleKey]) {
        // title update
        NSString *newTitle = [change valueForKey:NSKeyValueChangeNewKey];
        [self setTitle:newTitle];
    }
    if (object == [self valueObject] && [keyPath isEqualToString:_valueKey]) {
        // value update
        NSString *newValue = [change valueForKey:NSKeyValueChangeNewKey];
        [self setValue:newValue];
    }
    // animation will occur automatically
}

- (void)configureCell:(UITableViewCell *)reusableCell {
    [super configureCell:reusableCell];
    
    NSString *titleValue = (_titleObject == nil) ? [self title] : [_titleObject valueForKey:_titleKey];
    NSString *detailValue = (_valueObject == nil) ? [self value] : [_valueObject valueForKey:_titleKey];
    
    [[reusableCell textLabel] setText:titleValue];
    [[reusableCell detailTextLabel] setText:detailValue];
}

- (BOOL)shouldUpdateCell:(UITableViewCell *)tableViewCell usingRowAnimation:(UITableViewRowAnimation)animationStyle {
    [self configureCell:tableViewCell];
    return NO;
}

@end
