//
//  YXKVOCheckmarkCellGroup.m
//  ModelTableViewFramework
//
//  Created by Vladislav Alekseev on 06.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

#import "YXKVOCheckmarkCellGroupInfo.h"

@interface YXCheckmarkCellGroupInfo ()

- (void)_selectCell:(YXCheckmarkCellInfo *)cellInfo;

@end

@implementation YXKVOCheckmarkCellGroupInfo

@synthesize object = _object;
@synthesize key = _key;

+ (id)checkmarkCellGroupObservingObject:(id)object forKey:(NSString *)key {
    YXKVOCheckmarkCellGroupInfo *cellInfo = [[self alloc] init];
    [cellInfo setObject:object];
    [cellInfo setKey:key];
    [cellInfo setDelegate:cellInfo];
    [cellInfo setChangeHandler:@selector(checkmarkCellGroupInfo:didSelectCell:)];
    
    [object addObserver:cellInfo forKeyPath:key options:NSKeyValueObservingOptionNew context:nil];
    
    return [cellInfo autorelease];
}

+ (id)checkMarkCellGroup {
    @throw @"YXKVOCheckmarkCellGroupInfo does not support +checkMarkCellGroup method";
}

- (void)dealloc {
    [self.object removeObserver:self forKeyPath:self.key];
    
    [_object release];
    [_key release];
    
    [super dealloc];
}

- (void)addCheckmarkCellInfo:(YXCheckmarkCellInfo *)cell {
    [super addCheckmarkCellInfo:cell setSelected:NO];
}

- (void)addCheckmarkCellInfo:(YXCheckmarkCellInfo *)cell setSelected:(BOOL)selected {
    [self addCheckmarkCellInfo:cell];
}

- (void)observeValueForKeyPath:(NSString *)keyPath 
                      ofObject:(id)object 
                        change:(NSDictionary *)change 
                       context:(void *)context {
    if (object == self.object) {
        if ([keyPath isEqualToString:self.key]) {
            NSUInteger newValue = [[change valueForKey:NSKeyValueChangeNewKey] unsignedIntegerValue];
            if (newValue > [[self cells] count] - 1) {
                newValue = [[self cells] count] - 1;
            }
            YXCheckmarkCellInfo *cellToSelect = [[self cells] objectAtIndex:newValue];
            [self _selectCell:cellToSelect]; // mark cell as selected but don't bother delegate
        }
    }
}

- (void)checkmarkCellGroupInfo:(YXCheckmarkCellGroupInfo *)group didSelectCell:(NSNumber *)selectedIndexNumber {
    NSUInteger selectedIndex = [selectedIndexNumber unsignedIntegerValue];
    
    if (selectedIndex != NSUIntegerMax) {
        [self.object setValue:[NSNumber numberWithUnsignedInteger:selectedIndex] forKey:self.key];   
    }
}

- (NSNumber *)initialValueForCell:(YXCheckmarkCellInfo *)cell {
	NSUInteger objectValue = [[self.object valueForKey:self.key] unsignedIntegerValue];
    NSUInteger cellIndex = [[self cells] indexOfObject:cell];
    
    if (cellIndex == objectValue) {
        [self setSelectedCell:cell];
        return [NSNumber numberWithBool:YES];
    }
    
    return [NSNumber numberWithBool:NO];
}

@end
