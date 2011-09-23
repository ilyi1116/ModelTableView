//
//  YXKVOSegmentedCellInfo.m
//  ModelTableViewFramework
//
//  Created by Vladislav Alekseev on 10.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

#import "YXKVOSegmentedCellInfo.h"

@implementation YXKVOSegmentedCellInfo

@synthesize object = _object;
@synthesize key = _key;

+ (id)cellObservingObject:(id)object
                   forKey:(NSString *)key
             segmentItems:(NSArray *)items {
    return [self cellWithReuseIdentifier:[self defaultReuseIdentifier]
                           observeObject:object
                                  forKey:key
                            segmentItems:items];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                observeObject:(id)object
                       forKey:(NSString *)key
                segmentItems:(NSArray *)items {    
    
    YXKVOSegmentedCellInfo *cellInfo = [[self alloc] initWithReuseIdentifier:reuseIdentifier];
    [cellInfo setTarget:cellInfo];
    [cellInfo setValueGetterSelector:@selector(valueForSegmentedCell:)];
    [cellInfo setValueSetterSelector:@selector(segmentedCell:didSelectNewValue:)];
    [cellInfo setSegmentTitles:items];
	[cellInfo setSelectionStyle:YXCellInfoSelectionStyleNone];
	[cellInfo setAnimatesSwitching:YES];
    
    [cellInfo setObject:object];
    [cellInfo setKey:key];
    
    [object addObserver:cellInfo
             forKeyPath:key 
                options:NSKeyValueObservingOptionNew
                context:nil];
    return [cellInfo autorelease];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                       target:(id)target 
                       setter:(SEL)setter 
                       getter:(SEL)getter 
                 segmentItems:(NSArray *)items {
    @throw @"You shoudn't use cellWithReuseIdentifier:target:setter:getter:segmentItems: method with YXKVOSegmentedCellInfo.";
}

+ (id)cellWithTarget:(id)target setter:(SEL)setter getter:(SEL)getter segmentItems:(NSArray *)items {
    @throw @"You shoudn't use cellWithTarget:target:setter:getter:segmentItems: method with YXKVOSegmentedCellInfo.";
}

- (void)dealloc {
    [_object removeObserver:self forKeyPath:_key];
    
    [_key release];
    [super dealloc];
}

- (void)segmentedCell:(YXKVOSegmentedCellInfo *)cellInfo didSelectNewValue:(NSNumber *)newValue {
    [_object setValue:newValue forKey:_key];
}

- (NSNumber *)valueForSegmentedCell:(YXKVOSegmentedCellInfo *)cellInfo {
    return [_object valueForKey:_key];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == [self object] && [keyPath isEqualToString:[self key]]) {
        [self updateCellAppearenceAnimated:YES];
    }
}

@end
