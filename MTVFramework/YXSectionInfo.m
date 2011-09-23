//
//  YXSection.m
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXModelTableViewController.h"

#import "YXModelTableHelperView.h"

#import "YXSectionInfo.h"
#import "YXCellInfo.h"
#import "YXStyleInfo.h"

@implementation YXSectionInfo

@synthesize modelTableViewController = _modelTableViewController;
@synthesize styleInfo = _styleInfo;
@synthesize footerView = _footerView;
@synthesize headerView = _headerView;
@synthesize header = _header;
@synthesize footer = _footer;
@synthesize cellsCollapsed = _cellsCollapsed;
@dynamic cells;

- (void)dealloc {
    
    for (YXCellInfo *cellInfo in _cells) {
        [cellInfo setSectionInfo:nil];
    }
    
	[_cells release], _cells = nil;
	self.header = nil;
	self.footer = nil;

	self.footerView = nil;
	self.headerView = nil;

	[super dealloc];
}

- (id)initWithHeader:(NSString *)header footer:(NSString *)footer {
    self = [super init];
	if (self) {
		_cells = [[NSMutableArray alloc] initWithCapacity:10];
		self.header = header;
		self.footer = footer;
        
        self.cellsCollapsed = NO;
	}
	return self;
}

+ (id)sectionInfo {
    YXSectionInfo * section = [[self alloc] initWithHeader:nil footer:nil];
	return [section autorelease];
}

+ (id)sectionInfoWithHeader:(NSString*)header footer:(NSString*)footer {
	YXSectionInfo * section = [[self alloc] initWithHeader:header footer:footer];
	return [section autorelease];
}

+ (Class)headerHelperViewClass {
	return [YXModelTableHelperView class];
}

+ (Class)footerHelperViewClass {
	return [YXModelTableHelperView class];
}

- (NSArray *)cells {
    if (self.cellsCollapsed) {
        return [NSArray array];
    }
	return _cells;
}

#pragma mark -
#pragma mark Header View

- (void)setHeaderView:(YXModelTableHelperView *)headerView {
    if (headerView == _headerView) 
        return;
    [_headerView release], _headerView = [headerView retain];
    [_headerView setStyleInfo:self.styleInfo];
	[_headerView setMission:YXModelTableViewHeaderViewMissionHeader];
    [_headerView setText:self.header];
    
    YXModelTableViewController *controller = [self modelTableViewController];
    [_headerView setTableViewStyle:[controller tableViewStyle]];
}

- (YXModelTableHelperView *)headerView {
    if (_headerView == nil) {
        YXModelTableHelperView *aHeaderView = [[[self class] headerHelperViewClass] tableSectionView];
		
        [aHeaderView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [aHeaderView setText:self.header];
		
		YXModelTableViewController *controller = [self modelTableViewController];
        [aHeaderView setTableViewStyle:[controller tableViewStyle]];
        
        [self setHeaderView:aHeaderView];
    }
    return _headerView;
}

- (void)setHeader:(NSString *)header {
	if (_header == header) {
		return;
	}
	
	[_header release];
	_header = [header copy];
	
	if (_headerView) {
		self.headerView.text = _header;
	}
}

#pragma mark -
#pragma mark Footer View

- (void)setFooterView:(YXModelTableHelperView *)footerView {
    if (footerView == _footerView)
        return;
    [_footerView release], _footerView = [footerView retain];
    [_footerView setStyleInfo:self.styleInfo];
	[_footerView setMission:YXModelTableViewHeaderViewMissionFooter];
	YXModelTableViewController *controller = [self modelTableViewController];
    [_footerView setTableViewStyle:[controller tableViewStyle]];
}

- (YXModelTableHelperView *)footerView {
    if (_footerView == nil) {
        YXModelTableHelperView *aFooterView = [[[self class] footerHelperViewClass] tableSectionView];
		
        [aFooterView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [aFooterView setText:self.footer];
		
		YXModelTableViewController *controller = [self modelTableViewController];
        [aFooterView setTableViewStyle:[controller tableViewStyle]];
		
        [self setFooterView:aFooterView];
    }
    return _footerView;
}

- (void)setFooter:(NSString *)footer {
	if (_footer == footer) {
		return;
	}
	
	[_footer release];
	_footer = [footer copy];
	
	if (_footerView) {
		self.footerView.text = _footer;
	}
}

#pragma mark -
#pragma mark Styling

- (void)setStyleInfo:(YXStyleInfo *)styleInfo {
    if (styleInfo == _styleInfo) 
        return;
    
    [_styleInfo release], _styleInfo = [styleInfo retain];
    [[self cells] makeObjectsPerformSelector:@selector(setStyleInfo:) withObject:self.styleInfo];
    [[self headerView] setStyleInfo:styleInfo];
    [[self footerView] setStyleInfo:styleInfo];
	YXModelTableViewController *controller = [self modelTableViewController];
    [[self headerView] setTableViewStyle:[controller tableViewStyle]];
    [[self footerView] setTableViewStyle:[controller tableViewStyle]];
}

#pragma mark Adding Cell

- (void)addCellInfo:(YXCellInfo *)cellInfo {
    [self addCellInfo:cellInfo animateWithStyle:UITableViewRowAnimationNone];
}

- (void)addCellInfo:(YXCellInfo *)cellInfo animated:(BOOL)animated {
    UITableViewRowAnimation style = (animated) ? UITableViewRowAnimationTop : UITableViewRowAnimationNone;
    [self addCellInfo:cellInfo animateWithStyle:style];
}

- (void)addCellInfo:(YXCellInfo *)cellInfo animateWithStyle:(UITableViewRowAnimation)animationStyle {
    [_cells addObject:cellInfo];
    [cellInfo setSectionInfo:self];
    [cellInfo setStyleInfo:self.styleInfo];
    
    if (!self.cellsCollapsed) {
        [self.modelTableViewController section:self 
                             didInsertCellInfo:cellInfo 
                                  wantsAnimate:animationStyle];      
    }
}

- (void)insertCellInfo:(YXCellInfo *)cellInfo atIndex:(NSUInteger)index animateWithStyle:(UITableViewRowAnimation)animationStyle {
    if (index > [_cells count]) {
		index = [_cells count];
	}
    
    [_cells insertObject:cellInfo atIndex:index];
    [cellInfo setSectionInfo:self];
    [cellInfo setStyleInfo:self.styleInfo];
    
    if (!self.cellsCollapsed) {
        [self.modelTableViewController section:self 
                             didInsertCellInfo:cellInfo 
                                  wantsAnimate:animationStyle];      
    }
}

- (void)insertTransitionCellInfo:(YXCellInfo *)cellInfo atIndex:(NSUInteger)index {
	if (index > [_cells count]) {
		index = [_cells count];
	}
	[_cells insertObject:cellInfo atIndex:index];
	[cellInfo setSectionInfo:self];
	[cellInfo setStyleInfo:self.styleInfo];
}

- (void)deleteCellInfoWithIndexes:(NSIndexSet *)indexes animateWithStyle:(UITableViewRowAnimation)animationStyle {
    NSUInteger indexValue = [indexes firstIndex];
    while (indexValue != NSNotFound) {        
        YXCellInfo *cellInfo = [_cells objectAtIndex:indexValue];
        [cellInfo setSectionInfo:nil];
        indexValue = [indexes indexGreaterThanIndex:indexValue];
    }
    
    [_cells removeObjectsAtIndexes:indexes];
    
    if (!self.cellsCollapsed) {
        [self.modelTableViewController section:self 
                     didRemoveCellsWithIndexes:indexes 
                                  wantsAnimate:animationStyle];   
    }
}

#pragma mark Removing Cell

- (void)removeCellInfo:(YXCellInfo *)cellInfo {
    [self removeCellInfo:cellInfo animateWithStyle:UITableViewRowAnimationNone];
}

- (void)removeCellInfo:(YXCellInfo *)cellInfo animateWithStyle:(UITableViewRowAnimation)animationStyle {
    if (![_cells containsObject:cellInfo]) 
        return;
    
    NSUInteger cellIndex = [_cells indexOfObject:cellInfo];
    
    [cellInfo setSectionInfo:nil];
    [_cells removeObject:cellInfo];
    
    if (!self.cellsCollapsed) {
        [self.modelTableViewController section:self 
                             didRemoveCellInfo:cellInfo 
                                       atIndex:cellIndex
                                  wantsAnimate:animationStyle];      
    }
}

- (void)removeCellInfo:(YXCellInfo *)cellInfo animated:(BOOL)animated {
    UITableViewRowAnimation style = (animated) ? UITableViewRowAnimationTop : UITableViewRowAnimationNone;
    [self removeCellInfo:cellInfo animateWithStyle:style];
}

- (void)removeAllCellInfoAnimated:(BOOL)animated {
	if (animated) {
		[self removeAllCellInfoWithAnimationStyle:UITableViewRowAnimationFade];
	}
	else {
		[self removeAllCellInfoWithAnimationStyle:UITableViewRowAnimationNone];
	}
}

- (void)removeAllCellInfoWithAnimationStyle:(UITableViewRowAnimation)animationStyle {
	NSArray *currentCells = [self content];
	
	for (YXCellInfo *cellinfo in currentCells) {
		NSLog(@" removing cellinfo %d", [currentCells indexOfObject:cellinfo]);
		[self removeCellInfo:cellinfo animateWithStyle:animationStyle];
	}
}

- (void)transitionWantsToRemoveCellInfo:(YXCellInfo *)cellInfo {
	[cellInfo setSectionInfo:nil];
	[_cells removeObject:cellInfo];
}

#pragma mark Updating Section

- (void)updateRowsWithIndexes:(NSIndexSet *)indexSet animated:(BOOL)animated {
    if (self.cellsCollapsed)
        return;
    
    UITableViewRowAnimation style = (animated) ? UITableViewRowAnimationFade : UITableViewRowAnimationNone;
    [self.modelTableViewController section:self reloadRowsWithIndexes:indexSet wantsAnimate:style];
}

- (void)updateSectionAnimated:(BOOL)animated {
    if (self.cellsCollapsed)
        return;
    
    UITableViewRowAnimation style = (animated) ? UITableViewRowAnimationFade : UITableViewRowAnimationNone;
    [self.modelTableViewController reloadSection:self withAnimationStyle:style];
}

+ (BOOL)automaticallyNotifiesObserversOfCellsCollapsed {
	return NO;
}

- (void)setCellsCollapsed:(BOOL)cellsCollapsed {
    [self setCellsCollapsed:cellsCollapsed animated:NO];
}

- (void)setCellsCollapsed:(BOOL)collapsed animated:(BOOL)animated {
	if (_cellsCollapsed == collapsed) {
		return;
	}
	
    NSArray *currentCells = [NSArray arrayWithArray:_cells];
    
	[self willChangeValueForKey:@"cellsCollapsed"];
    _cellsCollapsed = collapsed;
	[self didChangeValueForKey:@"cellsCollapsed"];
	
	YXModelTableViewController *tvController = self.modelTableViewController;
    
    if (animated) {
        [tvController beginUpdates];
        if (collapsed) {
            for (YXCellInfo *cellInfo in currentCells) {
                NSUInteger cellIndex = [currentCells indexOfObject:cellInfo];
                [self.modelTableViewController section:self 
                                     didRemoveCellInfo:cellInfo 
                                               atIndex:cellIndex
                                          wantsAnimate:UITableViewRowAnimationTop];  
            }
        }
        else {
            for (YXCellInfo *cellInfo in currentCells) {
                [self.modelTableViewController section:self 
                                     didInsertCellInfo:cellInfo 
                                          wantsAnimate:UITableViewRowAnimationTop]; 
            }
        }
        [tvController endUpdates];
    }
    else {
        [tvController reloadSection:self];
    }
    
}

- (NSArray *)content {
	return [NSArray arrayWithArray:_cells];
}

@end
