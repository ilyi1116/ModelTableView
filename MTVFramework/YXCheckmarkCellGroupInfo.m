//
//  YXCheckmarkCellGroup.m
//  YandexMaps
//
//  Created by Mikhail Kalugin on 6/30/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXCheckmarkCellGroupInfo.h"

@interface YXCheckmarkCellGroupInfo ()

- (void)_selectCell:(YXCheckmarkCellInfo *)cellInfo;

@end

@implementation YXCheckmarkCellGroupInfo

@dynamic cells;
@synthesize delegate = _delegate;
@synthesize changeHandler = _changeHandler;
@synthesize selectedCell = _selectedCell;

+ (id)checkmarkCellGroup {
    return [[[self alloc] init] autorelease];
}

- (void)dealloc {
	self.selectedCell = nil;

	self.delegate = nil;
	_changeHandler = NULL;

	[_cells release], _cells = nil;

	[super dealloc];
}

- (NSArray*)cells {
	return [NSArray arrayWithArray:_cells];
}

- (NSMutableArray *)mutableCells {
	if (_cells == nil) {
		_cells = [[NSMutableArray alloc] initWithCapacity:10];
	}
	return _cells;
}

- (void)addCheckmarkCellInfo:(YXCheckmarkCellInfo *)cellInfo setSelected:(BOOL)selected {
	NSAssert(cellInfo != nil, @"cellInfo can't be nil");
	
	[[self mutableCells] addObject:cellInfo];
	
	if (selected) {
		self.selectedCell = cellInfo;
	}
	
	cellInfo.delegate = self;
	cellInfo.initialValueGetter = @selector(initialValueForCell:);
	cellInfo.changeHandler = @selector(cell:changedValue:);
	cellInfo.shouldChangeHandler = @selector(cell:willChangeValue:);
}

- (void)removeCheckmarkCellInfo:(YXCheckmarkCellInfo *)cellInfo {
	NSAssert(cellInfo != nil, @"cellInfo can't be nil");
	
	if (cellInfo.delegate == self) {
		cellInfo.delegate = nil;
	}
	[[self mutableCells] removeObject:cellInfo];
	
	if (self.selectedCell == cellInfo) { // cell can be already disposed here
		[self selectCell:nil];
	}
}

- (NSNumber*)initialValueForCell:(YXCheckmarkCellInfo *)cellInfo {
	BOOL boolValue = (cellInfo == self.selectedCell);
	return [NSNumber numberWithBool:boolValue];
}

- (void)cell:(YXCheckmarkCellInfo *)cellInfo changedValue:(NSNumber *)selected {
	if ([selected boolValue]) {
		[self selectCell:cellInfo];
	}
}

- (NSNumber *)cell:(YXCheckmarkCellInfo *)cellInfo willChangeValue:(NSNumber *)selected {
	if (self.selectedCell == cellInfo) {
		return [NSNumber numberWithBool:NO];
	}
	return [NSNumber numberWithBool:YES];
}

- (void)_selectCell:(YXCheckmarkCellInfo *)cellInfo {
    YXCheckmarkCellInfo * previousCell = self.selectedCell;
    
    if (previousCell == cellInfo) {
        return;
    }
	
	self.selectedCell = cellInfo;
	
	if (previousCell != nil) {
		[previousCell updateCellAppearenceAnimated:NO];
	}
    
    [cellInfo updateCellAppearenceAnimated:NO];
}

- (void)selectCell:(YXCheckmarkCellInfo *)cellInfo {
    [self _selectCell:cellInfo];
	
	if ([self.delegate respondsToSelector:self.changeHandler]) {
        NSNumber *newIndex = [NSNumber numberWithUnsignedInteger:[[self cells] indexOfObject:cellInfo]];                    
        [self.delegate performSelector:self.changeHandler withObject:self withObject:newIndex];
	}
}

- (NSUInteger)selectedIndex {
    if (self.selectedCell == nil)
        return NSUIntegerMax;
    
    NSUInteger index = [[self cells] indexOfObject:self.selectedCell];
    return index;
}

- (void)setSelectedIndex:(NSUInteger)newIndex {
    if (newIndex == [self selectedIndex]) {
        return; // don't reselect
    }
    
    if (newIndex >= [[self cells] count]) {
        newIndex = [[self cells] count] - 1;
    }
    
    YXCheckmarkCellInfo *cellToSelect = [[self cells] objectAtIndex:newIndex];
    [self selectCell:cellToSelect];
}

@end
