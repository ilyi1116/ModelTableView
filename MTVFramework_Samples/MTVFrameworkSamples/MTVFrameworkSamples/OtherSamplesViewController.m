//
//  RootViewController.m
//  ModelTableViewFramework
//
//  Created by Vladislav Alekseev on 10.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

#import <dispatch/dispatch.h>

#import "OtherSamplesViewController.h"
#import "AnimationViewController.h"
#import "CellSamplesViewController.h"

@implementation OtherSamplesViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundView = nil;
    
    [self setTitle:@"MTV Framework"];
    
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self fillSections];
    });
}

- (void)viewDidUnload {
    [super viewDidUnload];
    [section release], section = nil;
}

- (void)dealloc {
    [section release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)fillSections {
    section = [[YXSectionInfo sectionInfoWithHeader:@"Выберите пример" footer:nil] retain];
    [section addCellInfo:[YXDisclosureCellInfo cellWithReuseIdentifier:@"disclosureCellID" 
                                                                 title:@"Анимации" 
                                                                target:self 
                                                                action:@selector(pushAnimationSamples:)]];
    [section addCellInfo:[YXDetailDisclosureCellInfo cellWithReuseIdentifier:@"detailDisclosureCell" 
                                                                       title:@"Разное" 
                                                                  detailText:@"Спагетти из ячеек" 
                                                                      target:self 
                                                                      action:@selector(pushCellSamples:)]];
    [self insertSection:section 
             atPosition:YXSectionInsertionPositionTop 
          withAnimation:UITableViewRowAnimationTop];
}

- (void)pushAnimationSamples:(YXCellInfo *)cellInfo {
    AnimationViewController *animationViewController = [[AnimationViewController alloc] initWithStyle:UITableViewStyleGrouped];
	[animationViewController setStyleInfo:[self styleInfo]];
    [[self navigationController] pushViewController:animationViewController animated:YES];
    [animationViewController release];
}

- (void)pushCellSamples:(YXCellInfo *)cellInfo {
    CellSamplesViewController *cellSamplesViewController = [[CellSamplesViewController alloc] initWithStyle:UITableViewStylePlain];
	[cellSamplesViewController setStyleInfo:self.styleInfo];
    [[self navigationController] pushViewController:cellSamplesViewController animated:YES];
    [cellSamplesViewController release];
}

@end
