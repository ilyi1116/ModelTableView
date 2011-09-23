//
//  AnimationViewController.m
//  ModelTableViewFramework
//
//  Created by Vladislav Alekseev on 10.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

#import "AnimationViewController.h"

#import "MYCustomCellInfo.h"
#import "MYCustomCellView.h"

@implementation AnimationViewController

@synthesize customCellView = _customCellView;

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (MYCustomCellInfo *)cellInfo {
    _cellCounter++;
    MYCustomCellInfo *cellInfo = [MYCustomCellInfo cellWithReuseIdentifier:@"myCustomCellID" 
                                                       constructorDelegate:self 
                                                                    target:nil 
                                                                    action:NULL];
    [cellInfo setRowHeight:80];
    [cellInfo setSomeNumberToDisplay:_cellCounter];
    [cellInfo setSupportsSwipeToDelete:YES];
    return cellInfo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundView = nil;

    _customContentSection = [[YXSectionInfo sectionInfoWithHeader:@"Свой контент" 
                                                       footer:@"Добавляйте и удаляйте любые ячейки"] retain];
    MYCustomCellInfo *cellInfo = [self cellInfo];
    [cellInfo setRowHeight:100.0f];
    
    [_customContentSection addCellInfo:cellInfo];
    
    [self setSections:[NSArray arrayWithObject:_customContentSection]];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    [_customContentSection release], _customContentSection = nil;
}

- (void)dealloc {
    [_customCellView release];
    
    [_customContentSection release];
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSUInteger)rowNumberForCellInfo:(YXCellInfo *)cellInfo {
    NSUInteger sectionNumber = [[self sections] indexOfObject:[cellInfo valueForKey:@"_section"]];
    YXSectionInfo *section = [[self sections] objectAtIndex:sectionNumber];
    NSUInteger rowNumber = [[section cells] indexOfObject:cellInfo];
    return rowNumber;
}

#pragma mark Custom Cell Delegate

- (UITableViewCell *)constructTableViewCellForCellInfo:(MYCustomCellInfo *)cellInfo {
    [[NSBundle mainBundle] loadNibNamed:@"MYCustomCellView" owner:self options:nil];
    [_customCellView setDelegate:self];
    return _customCellView;
}

- (void)prepareTableViewCellForReuse:(UITableViewCell *)cell usingCellInfo:(MYCustomCellInfo *)cellInfo {
    MYCustomCellView *customCell = (MYCustomCellView *)cell;
    NSString *centerText = [NSString stringWithFormat:@"Row %d", cellInfo.someNumberToDisplay];
    [[customCell centerLabel] setText:centerText];
}

#pragma mark MYCustomCellViewDelegate

- (void)customCellViewWantsToAddCellToTop:(MYCustomCellView *)cellView {
    NSIndexPath *indexPath = [[self tableView] indexPathForCell:cellView];
    NSUInteger rowNumber = [indexPath row];
    NSUInteger indexToInsert = rowNumber;
    
    [_customContentSection insertCellInfo:[self cellInfo] 
                                  atIndex:indexToInsert 
                         animateWithStyle:UITableViewRowAnimationFade];
    
    // необходимо обновить теперь строки, которые идут после строки cellView, включая саму cellView
    
    NSUInteger numberOfRowsInSection = [[self tableView] numberOfRowsInSection:0];
    NSInteger rangeLength = numberOfRowsInSection - (indexToInsert+1);
    
    NSIndexSet *rowSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexToInsert+1, rangeLength)];
    
    [_customContentSection updateRowsWithIndexes:rowSet animated:YES];
}

- (void)customCellViewWantsToAddCellToBottom:(MYCustomCellView *)cellView {
    NSIndexPath *indexPath = [[self tableView] indexPathForCell:cellView];
    NSUInteger numberOfRowsInSection = [[self tableView] numberOfRowsInSection:0];
    NSUInteger rowNumber = [indexPath row];
    NSUInteger indexToInsert = rowNumber + 1;
    
    [_customContentSection insertCellInfo:[self cellInfo] 
                                  atIndex:indexToInsert 
                         animateWithStyle:UITableViewRowAnimationFade];
    
    // теперь число строк в секции возрасло
    numberOfRowsInSection++;
    
    // необходимо обновить теперь строки, которые идут после строки cellView, кроме той, что мы вставляем
    NSInteger rangeLength = numberOfRowsInSection - (indexToInsert + 2);
    
    if (rangeLength <= 0) {
        return;
    }
    
    NSIndexSet *rowSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexToInsert, rangeLength)];
    [_customContentSection updateRowsWithIndexes:rowSet animated:YES];
}

- (void)customCellView:(MYCustomCellView *)cellView wantsToDeleteWithAnimation:(UITableViewRowAnimation)animationStyle {
    NSIndexPath *cellIndexPath = [[self tableView] indexPathForCell:cellView];
    YXCellInfo *cellInfo = [self cellInfoAtIndexPath:cellIndexPath];
    [_customContentSection removeCellInfo:cellInfo animateWithStyle:animationStyle];
}

@end
