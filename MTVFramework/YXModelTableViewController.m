//
//  YXModelTableViewController.m
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXModelTableViewController.h"
#import "YXModelTableHelperView.h"

#import "YXStyleInfo.h"

@interface YXModelTableViewController (StyleMethods)
- (void)applyStyle;
@end

@implementation YXModelTableViewController

@synthesize sections = _sections;
@synthesize styleInfo = _styleInfo;
@synthesize tableView = _tableView;
@synthesize tableViewStyle = _tableViewStyle;

#pragma mark -
#pragma mark Initialization


- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithNibName:nil bundle:nil])) {
		_sections = [[NSArray alloc] init];
		_tableViewStyle = style;
    }
    return self;
}

- (void)loadView {
	[super loadView];
	
    if (!self.tableView) {
		if ([self.view isKindOfClass:[UITableView class]]) {
			self.tableView = (UITableView *)self.view;
		} else {
			self.tableView = [[[UITableView alloc] initWithFrame:CGRectZero style:_tableViewStyle] autorelease];
			self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		}
	}
	
	if (self.view != self.tableView) {
		self.tableView.frame = self.view.bounds;
		[self.view addSubview:self.tableView];
	}
    
    [self applyStyle];
}

- (void)applyStyle {
    if (self.tableViewStyle == UITableViewStylePlain) {
        self.view.backgroundColor = self.styleInfo.controllerBackgroundColor;
        self.tableView.backgroundColor = self.styleInfo.tableViewBackgroundColor;
    }
    else {
        self.view.backgroundColor = self.styleInfo.controllerGroupedBackgroundColor;
        self.tableView.backgroundColor = self.styleInfo.tableViewGroupedBackgroundColor;
    }
    
    self.tableView.separatorStyle = self.styleInfo.tableViewCellSeparatorStyle;
    self.tableView.separatorColor = self.styleInfo.tableViewCellSeparatorColor;
}

#pragma mark -

- (void)setTableView:(UITableView *)tableView {
    if (_tableView != tableView) {
		[_tableView release];
		_tableView = [tableView retain];
		
		if (!_tableView.delegate)
			_tableView.delegate = self;
		if (!_tableView.dataSource)
			_tableView.dataSource = self;
		
		if (_tableViewStyle == UITableViewStylePlain) {
			UIEdgeInsets inset = self.tableView.contentInset;
			inset.top = 0;
			self.tableView.contentInset = inset;
		}
		else {
			UIEdgeInsets inset = self.tableView.contentInset;
			inset.top = 10;
			self.tableView.contentInset = inset;
		}

	}
}

- (void)setTableViewStyle:(UITableViewStyle)newStyle {
    _tableViewStyle = newStyle;
    if (_tableView != nil) {
        if ([_tableView style] != newStyle) {
            self.tableView = [[[UITableView alloc] initWithFrame:CGRectZero style:_tableViewStyle] autorelease];
			self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
			self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
    }
}

- (void)setStyleInfo:(YXStyleInfo *)styleInfo {
    if (styleInfo == _styleInfo)
        return;
    
    [_styleInfo release], _styleInfo = [styleInfo retain];
    
    if (![self isViewLoaded]) {
        return;
    }
	
	[self applyStyle];
    [[self sections] makeObjectsPerformSelector:@selector(setStyleInfo:) withObject:styleInfo];
}

- (YXStyleInfo *)styleInfo {
    if (_styleInfo == nil) {
        _styleInfo = [[YXStyleInfo defaultStyleInfo] retain];
    }
    return _styleInfo;
}

#pragma mark -


- (void)beginUpdates {
    if ([self isViewLoaded]) {
        [[self tableView] beginUpdates];
    }
}

- (void)endUpdates {
    [[self tableView] endUpdates];
}

#pragma mark -
#pragma mark Setting new sections

- (void)setSections:(NSArray *)newSections animated:(BOOL)animated {
    if (!animated) {
        [self setSections:newSections];
        return;
    }
    
    UITableViewRowAnimation animationStyle = (animated) ? UITableViewRowAnimationFade : UITableViewRowAnimationNone;
    NSArray *currentSections = [NSArray arrayWithArray:[self sections]];
    
    [self beginUpdates];
    
    NSUInteger numberOfCurrentSections = [currentSections count];
    NSUInteger numberOfNewSections = [newSections count];
    NSUInteger numberOfSectionsToReload = MIN(numberOfCurrentSections, numberOfNewSections);
    
    // перезагружаем секции, которые можно перезагрузить
    for (NSUInteger sectionToReload = 0; sectionToReload < numberOfSectionsToReload; sectionToReload++) {
        [self reloadSectionAtIndex:sectionToReload withAnimationStyle:animationStyle];
    }
    
    if (numberOfNewSections < numberOfCurrentSections) {
        // удаляем текущие секции, которые лишние
        for (NSUInteger sectionIndexToRemove = numberOfNewSections; sectionIndexToRemove < numberOfCurrentSections; sectionIndexToRemove++) {
            YXSectionInfo *sectionToRemove = [currentSections objectAtIndex:sectionIndexToRemove];
            [self deleteSection:sectionToRemove withAnimation:animationStyle];
        }
    }
    else if (numberOfNewSections > numberOfCurrentSections) {
        // добавляем недостающие секции
        for (NSUInteger sectionIndexToInsert = numberOfCurrentSections; sectionIndexToInsert < numberOfNewSections; sectionIndexToInsert++) {
            YXSectionInfo *sectionToInsert = [newSections objectAtIndex:sectionIndexToInsert];
            [self insertSection:sectionToInsert atPosition:YXSectionInsertionPositionBottom withAnimation:animationStyle];
        }
    }
    
    [_sections release], _sections = [newSections copy]; 
    [_sections makeObjectsPerformSelector:@selector(setStyleInfo:) withObject:self.styleInfo];
    
    [self endUpdates];
}

- (void)setSections:(NSArray *)sections {
    if (_sections != sections) {        
        
        [_sections makeObjectsPerformSelector:@selector(setModelTableViewController:) withObject:nil];
        [_sections makeObjectsPerformSelector:@selector(setStyleInfo:) withObject:nil];
        
        [_sections release], _sections = [sections copy];
        
        [_sections makeObjectsPerformSelector:@selector(setModelTableViewController:) withObject:self];
        [_sections makeObjectsPerformSelector:@selector(setStyleInfo:) withObject:self.styleInfo];
        
        [_tableView reloadData];
    }
}

- (NSIndexPath *)indexPathForSection:(YXSectionInfo *)section cellInfo:(YXCellInfo *)cellInfo {
    NSUInteger sectionNumber = [[self sections] indexOfObject:section];
    if (sectionNumber == NSNotFound)
        return nil;
    
    NSUInteger rowNumber = [[section cells] indexOfObject:cellInfo];
    if (rowNumber == NSNotFound) { // да как такое может быть вообще?!
        return nil;
        //NSString *throwExpression = [NSString stringWithFormat:@"section %@ told it did insert cellInfo %@ but it's cells doesn't contain that cellInfo."];
        //@throw throwExpression;
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowNumber inSection:sectionNumber];
    
    return indexPath;
}

- (YXCellInfo *)cellInfoAtIndexPath:(NSIndexPath*)indexPath {
    if ([self.sections count] <= indexPath.section) {
        return nil;
    }
    
	YXSectionInfo * section = [[self sections] objectAtIndex:indexPath.section];
    if ([section.cells count] <= indexPath.row) {
        return nil;
    }
	YXCellInfo * cell = [section.cells objectAtIndex:indexPath.row];
	return cell;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [_sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionNum {
	YXSectionInfo * section = [_sections objectAtIndex:sectionNum];
	return [section.cells count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionNum {
    YXSectionInfo *section = [_sections objectAtIndex:sectionNum];
	YXModelTableHelperView *sectionHeader = [section headerView];
	CGFloat viewWidth = [[self view] frame].size.width;
	CGFloat height =  [sectionHeader optimalSizeForWidth:viewWidth].height;
	return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionNum {
	YXSectionInfo * section = [_sections objectAtIndex:sectionNum];
    YXModelTableHelperView *helperView = [section headerView];
    return helperView.hidden ? nil : helperView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)sectionNum {
    YXSectionInfo *section = [_sections objectAtIndex:sectionNum];
	YXModelTableHelperView *sectionFooter = [section footerView];
	CGFloat viewWidth = [[self view] frame].size.width;
	return [sectionFooter optimalSizeForWidth:viewWidth].height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)sectionNum {
	YXSectionInfo * section = [_sections objectAtIndex:sectionNum];
	return [section footerView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	YXCellInfo *cellInfo = [self cellInfoAtIndexPath:indexPath];
	UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:cellInfo.reuseIdentifier];
    
    if (tableViewCell == nil) {
        // can't reuse cell - need another one
        tableViewCell = [cellInfo tableViewCell];
    }
    
    NSAssert(tableViewCell != nil, @"YXModelTableViewController cellForRowAtIndexPath: cell can't be nil");
    
	[cellInfo configureCell:tableViewCell];

	tableViewCell.textLabel.numberOfLines = 0;
	return tableViewCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YXCellInfo *cellInfo = [self cellInfoAtIndexPath:indexPath];
    
    if ([cellInfo rowHeight] < 0.0f) {
        return 45.0f;
    }
    
    return [cellInfo rowHeight];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    YXCellInfo *cellInfo = [self cellInfoAtIndexPath:indexPath];
    [cellInfo tableView:tableView willDisplayCell:cell atIndexPath:indexPath];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YXCellInfo *cellInfo = [self cellInfoAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	BOOL shouldSelectThisCell = [cellInfo tableView:tableView willSelectCell:cell atIndexPath:indexPath];
    if (shouldSelectThisCell) {
        return indexPath;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	YXCellInfo *cellInfo = [self cellInfoAtIndexPath:indexPath];
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
	[cellInfo tableView:tableView didSelectCell:selectedCell atIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
	YXCellInfo *cellInfo = [self cellInfoAtIndexPath:indexPath];
    if (cellInfo == nil) {
        return;
    }
    UITableViewCell *deselectedCell = [tableView cellForRowAtIndexPath:indexPath];
	[cellInfo tableView:tableView didDeselectCell:deselectedCell atIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	YXCellInfo *cellInfo = [self cellInfoAtIndexPath:indexPath];
    UITableViewCell *affectedCell = [tableView cellForRowAtIndexPath:indexPath];
	[cellInfo tableView:tableView cellAccessoryButtonTapped:affectedCell aIndexPath:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    YXCellInfo * cell = [self cellInfoAtIndexPath:indexPath];
    return [cell supportsSwipeToDelete];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    YXSectionInfo *section = [[self sections] objectAtIndex:indexPath.section];
    YXCellInfo *cellInfo = [self cellInfoAtIndexPath:indexPath];
    [section removeCellInfo:cellInfo animateWithStyle:UITableViewRowAnimationLeft];
}

#pragma mark -
#pragma mark UITableViewExtendedDelegate

- (void)tableView:(UITableView *)tableView 
	 exchangeCell:(UITableViewCell *)cell1 atIndexPath:(NSIndexPath *)indexPath1 
		 withCell:(UITableViewCell *)cell2 atIndexPath:(NSIndexPath *)indexPath2 {
    YXCellInfo *cellInfo1 = [[[self cellInfoAtIndexPath:indexPath1] retain] autorelease];
    YXCellInfo *cellInfo2 = [[[self cellInfoAtIndexPath:indexPath2] retain] autorelease];
    
    YXSectionInfo *sectionInfo1 = cellInfo1.sectionInfo;
    YXSectionInfo *sectionInfo2 = cellInfo2.sectionInfo;
    
    NSUInteger cellInfo1Index = [sectionInfo1.cells indexOfObject:cellInfo1];
    NSUInteger cellInfo2Index = [sectionInfo2.cells indexOfObject:cellInfo2];
    
    [sectionInfo1 transitionWantsToRemoveCellInfo:cellInfo1];
    [sectionInfo2 transitionWantsToRemoveCellInfo:cellInfo2];
    
    [sectionInfo2 insertTransitionCellInfo:cellInfo2 atIndex:cellInfo1Index];
    [sectionInfo1 insertTransitionCellInfo:cellInfo1 atIndex:cellInfo2Index];
    
    [cellInfo1 configureCell:cell2];
    [cellInfo2 configureCell:cell1];
}

- (void)tableView:(UITableView *)tableView 
		 moveCell:(UITableViewCell *)cell 
	fromIndexPath:(NSIndexPath *)fromIndexPath 
	  toIndexPath:(NSIndexPath *)toIndexPath {
	YXCellInfo *movedCellInfo = [[[self cellInfoAtIndexPath:fromIndexPath] retain] autorelease];
    
    YXSectionInfo *fromSectionInfo = [self.sections objectAtIndex:fromIndexPath.section];
    YXSectionInfo *toSectionInfo = [self.sections objectAtIndex:toIndexPath.section];
    
    [fromSectionInfo transitionWantsToRemoveCellInfo:movedCellInfo];
    [toSectionInfo insertTransitionCellInfo:movedCellInfo atIndex:toIndexPath.row];
}

- (void)tableView:(UITableView *)tableView transitionDeletedCellForRowAtIndexPath:(NSIndexPath *)indexPath {
	YXCellInfo *cellInfoToRemove = [self cellInfoAtIndexPath:indexPath];
	[cellInfoToRemove.sectionInfo transitionWantsToRemoveCellInfo:cellInfoToRemove];
}

- (void)tableView:(UITableView *)tableView transitionInsertedCellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
}

#pragma mark -
#pragma mark CellInfo - UITableViewCell communication

- (void)insertSection:(YXSectionInfo *)section atIndex:(NSUInteger)index withAnimation:(UITableViewRowAnimation)animationStyle {
    NSMutableArray *currentSections = [NSMutableArray arrayWithArray:_sections];
    
    NSUInteger insertedSectionIndex = index;
    
    if (index >= [currentSections count]) {
        insertedSectionIndex = [currentSections count];
        [currentSections addObject:section];
    }
    else {
        [currentSections insertObject:section atIndex:index];
    }
    [section setModelTableViewController:self];
    
    [_sections release], _sections = [currentSections copy];
    [section setStyleInfo:self.styleInfo];
    
    if ([self isViewLoaded]) {
        [[self tableView] insertSections:[NSIndexSet indexSetWithIndex:insertedSectionIndex] 
                        withRowAnimation:animationStyle];
    }
}

- (void)insertSection:(YXSectionInfo *)section atPosition:(YXSectionInsertionPosition)position withAnimation:(UITableViewRowAnimation)animationStyle {
    NSMutableArray *currentSections = [NSMutableArray arrayWithArray:_sections];
    NSUInteger insertedSectionIndex = 0;
    
    if (position == YXSectionInsertionPositionTop) {
        [currentSections insertObject:section atIndex:0];
    }
    else {
        [currentSections addObject:section];
        insertedSectionIndex = [currentSections count] - 1;
    }
    [section setModelTableViewController:self];
    
    [_sections release], _sections = [currentSections copy];
    [section setStyleInfo:self.styleInfo];
    
    if ([self isViewLoaded]) {
        [[self tableView] insertSections:[NSIndexSet indexSetWithIndex:insertedSectionIndex] 
                        withRowAnimation:animationStyle];
    }
}

- (void)deleteSection:(YXSectionInfo *)section withAnimation:(UITableViewRowAnimation)animationStyle {
    NSMutableArray *currentSections = [NSMutableArray arrayWithArray:_sections];
    
    NSUInteger removedSectionIndex = [currentSections indexOfObject:section];
    
    if (removedSectionIndex == NSNotFound) {
        return;
    }
    
    [currentSections removeObjectAtIndex:removedSectionIndex];
    
    [section setModelTableViewController:nil];
    
    [_sections release];
    _sections = [currentSections copy];
    
    if ([self isViewLoaded]) {
        [[self tableView] deleteSections:[NSIndexSet indexSetWithIndex:removedSectionIndex] 
                        withRowAnimation:animationStyle];
    }
}

- (void)deleteSectionAtIndex:(NSUInteger)sectionNumber withAnimationStyle:(UITableViewRowAnimation)animationStyle {
    YXSectionInfo *sectionInfoToDelete = [[self sections] objectAtIndex:sectionNumber];
    [self deleteSection:sectionInfoToDelete withAnimation:animationStyle];
}

#pragma mark YXSectionDelegate
- (void)section:(YXSectionInfo *)section didInsertCellInfo:(YXCellInfo *)cellInfo wantsAnimate:(UITableViewRowAnimation)animationStyle {
    if (![self isViewLoaded])
        return;
    
    NSIndexPath *ip = [self indexPathForSection:section cellInfo:cellInfo];
    
    [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:ip] withRowAnimation:animationStyle];
}

- (void)section:(YXSectionInfo *)section 
didRemoveCellInfo:(YXCellInfo *)cellInfo 
        atIndex:(NSUInteger)index
   wantsAnimate:(UITableViewRowAnimation)animationStyle {
    if (![self isViewLoaded])
        return;
    
    NSUInteger sectionNumber = [[self sections] indexOfObject:section];
    if (sectionNumber == NSUIntegerMax)
        return;
    NSIndexPath *ip = [NSIndexPath indexPathForRow:index inSection:sectionNumber];
    
    [[self tableView] deleteRowsAtIndexPaths:[NSArray arrayWithObject:ip] withRowAnimation:animationStyle];
}

- (void)section:(YXSectionInfo *)section didRemoveCellsWithIndexes:(NSIndexSet *)indexes wantsAnimate:(UITableViewRowAnimation)animationStyle {
    NSUInteger sectionNumber = [[self sections] indexOfObject:section];
    NSUInteger numberOfIndexes = [indexes count];
    
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:numberOfIndexes];
    
    NSUInteger indexValue = [indexes firstIndex];
    while (indexValue != NSNotFound) {        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indexValue inSection:sectionNumber];
        [indexPaths addObject:indexPath];
        indexValue = [indexes indexGreaterThanIndex:indexValue];
    }
    
    if ([indexPaths count] > 0) {
        [[self tableView] deleteRowsAtIndexPaths:indexPaths withRowAnimation:animationStyle];   
    }
}

- (void)section:(YXSectionInfo *)section reloadRowsWithIndexes:(NSIndexSet *)indexes wantsAnimate:(UITableViewRowAnimation)animationStyle {
    
    NSUInteger sectionNumber = [[self sections] indexOfObject:section];
    NSUInteger numberOfIndexes = [indexes count];
    
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:numberOfIndexes];
    
    NSUInteger indexValue = [indexes firstIndex];
    while (indexValue != NSNotFound) {        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indexValue inSection:sectionNumber];
        
        YXCellInfo *cellInfo = [self cellInfoAtIndexPath:indexPath];
        UITableViewCell *cellToReload = [[self tableView] cellForRowAtIndexPath:indexPath];
        
        if ([cellInfo shouldUpdateCell:cellToReload usingRowAnimation:animationStyle]) {
            [indexPaths addObject:indexPath];
        }   
        
        indexValue = [indexes indexGreaterThanIndex:indexValue];
    }
    
    if ([indexPaths count] > 0) {
        [[self tableView] reloadRowsAtIndexPaths:indexPaths withRowAnimation:animationStyle];
    }
}

#pragma mark Reloading Section

- (void)reloadSectionAtIndex:(NSUInteger)sectionNumber withAnimationStyle:(UITableViewRowAnimation)animationStyle {
    if (![self isViewLoaded])
        return;
    
    [[self tableView] reloadSections:[NSIndexSet indexSetWithIndex:sectionNumber] 
                    withRowAnimation:animationStyle];
}

- (void)reloadSection:(YXSectionInfo *)section withAnimationStyle:(UITableViewRowAnimation)animationStyle {
    if (![self isViewLoaded]) 
        return;
    
    NSUInteger sectionNumber = [[self sections] indexOfObject:section];
    if (sectionNumber != NSNotFound) {
        [self reloadSectionAtIndex:sectionNumber withAnimationStyle:animationStyle];
    }
}

- (void)reloadSection:(YXSectionInfo *)section animated:(BOOL)animated {
    if (![self isViewLoaded]) 
        return;
    
    NSUInteger sectionNumber = [[self sections] indexOfObject:section];
    if (sectionNumber != NSNotFound) {
        UITableViewRowAnimation animationStyle = (animated) ? UITableViewRowAnimationFade : UITableViewRowAnimationNone;
        [self reloadSectionAtIndex:sectionNumber withAnimationStyle:animationStyle];
    }
}

- (void)reloadSection:(YXSectionInfo *)section {
    [self reloadSection:section withAnimationStyle:UITableViewRowAnimationNone];
}

#pragma mark Transitions

- (void)transitCellInfo:(YXCellInfo *)fromCellInfo toCellInfo:(YXCellInfo *)toCellInfo {
	NSIndexPath *fromIndexPath = [self indexPathForSection:fromCellInfo.sectionInfo cellInfo:fromCellInfo];
	NSIndexPath *toIndexPath = [self indexPathForSection:toCellInfo.sectionInfo cellInfo:toCellInfo];
	
	CGRect targetSectionRect = [self.tableView rectForSection:toIndexPath.section];
	targetSectionRect.size.height = 1;
	
	[self.tableView scrollRectToVisible:targetSectionRect animated:YES];
	[self.tableView transitRowAtIndexPath:fromIndexPath toRowIndexPath:toIndexPath];
}

- (void)moveCellInfo:(YXCellInfo *)cellInfo toSectionInfo:(YXSectionInfo *)sectionInfo atIndex:(NSUInteger)index {
    NSIndexPath *cellIndexPath = [self indexPathForSection:cellInfo.sectionInfo cellInfo:cellInfo];
    
    NSIndexPath *targetIndexPath = [NSIndexPath indexPathForRow:index inSection:[self.sections indexOfObject:sectionInfo]];
    
    [self.tableView moveRowAtIndexPath:cellIndexPath toIndexPath:targetIndexPath];
}

- (void)exchangeCellInfo:(YXCellInfo *)cellInfo1 withCellInfo:(YXCellInfo *)cellInfo2 {
    [self.tableView exchangeRowAtIndexPath:[self indexPathForSection:cellInfo1.sectionInfo cellInfo:cellInfo1]
                        withRowAtIndexPath:[self indexPathForSection:cellInfo2.sectionInfo cellInfo:cellInfo2]];
}

#pragma mark Reloading Rows

- (void)updateCellForCellInfo:(YXCellInfo *)cellInfo withRowAnimation:(UITableViewRowAnimation)animationType {
    if (![self isViewLoaded])
        return;
    
    // get cellInfo's index path
    NSUInteger sectionNumber = [[self sections] indexOfObject:[cellInfo sectionInfo]];
    
    if ([[self sections] count] <= sectionNumber || sectionNumber == NSNotFound) {
        // attempt to update cell that does not exists
        return;
    }
    
    YXSectionInfo *section = [[self sections] objectAtIndex:sectionNumber];
    NSUInteger rowNumber = [[section cells] indexOfObject:cellInfo];
    
    if (rowNumber == NSNotFound) {
        // row not found
        return;
    }
    
    NSIndexPath *cellInfoIndexPath = [NSIndexPath indexPathForRow:rowNumber inSection:sectionNumber];
    
    UITableViewCell *cellToReload = [[self tableView] cellForRowAtIndexPath:cellInfoIndexPath];
    BOOL shouldPerformDefaulReload = [cellInfo shouldUpdateCell:cellToReload usingRowAnimation:animationType];
    if (shouldPerformDefaulReload == NO) {
        return;
    }
    
    [[self tableView] reloadRowsAtIndexPaths:[NSArray arrayWithObject:cellInfoIndexPath]
                            withRowAnimation:animationType];
}

- (void)updateCellForCellInfo:(YXCellInfo *)cellInfo animated:(BOOL)animated {
    UITableViewRowAnimation animationType = animated ? UITableViewRowAnimationFade : UITableViewRowAnimationNone;
    [self updateCellForCellInfo:cellInfo withRowAnimation:animationType];
}

- (void)updateCellForCellInfo:(YXCellInfo *)cellInfo {
    [self updateCellForCellInfo:cellInfo withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)dealloc {
	self.sections = nil;
	self.tableView = nil;
    self.styleInfo = nil;

    [super dealloc];
}


@end

