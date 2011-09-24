//
//  BFTableTransitionsExample.m
//  MTVFrameworkSamples
//
//  Created by Алексеев Владислав on 23.09.11.
//  Copyright (c) 2011 Yandex. All rights reserved.
//

#import "BFTableTransitionsExample.h"


@implementation BFTableTransitionsExample

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YXSectionInfo *moveSection = [YXSectionInfo sectionInfoWithHeader:@"Move cells" footer:nil];
    [moveSection addCellInfo:[YXButtonCellInfo cellWithTitle:@"Go down 1" target:self action:@selector(goDown:)]];
    [moveSection addCellInfo:[YXButtonCellInfo cellWithTitle:@"Go down 2" target:self action:@selector(goDown:)]];
    [moveSection addCellInfo:[YXButtonCellInfo cellWithTitle:@"Go down 3" target:self action:@selector(goDown:)]];
    [moveSection addCellInfo:[YXButtonCellInfo cellWithTitle:@"Go down 4" target:self action:@selector(goDown:)]];
    
    YXSectionInfo *transitSection = [YXSectionInfo sectionInfoWithHeader:@"Transit cells" footer:nil];
    [transitSection addCellInfo:[YXButtonCellInfo cellWithTitle:@"Transit up to cell with switch"
                                                         target:self
                                                         action:@selector(goAndTransit:)]];
    [transitSection addCellInfo:[YXButtonCellInfo cellWithTitle:@"Transit up to cell with switch"
                                                         target:self
                                                         action:@selector(goAndTransit:)]];
    [transitSection addCellInfo:[YXButtonCellInfo cellWithTitle:@"Transit up to cell with switch"
                                                         target:self
                                                         action:@selector(goAndTransit:)]];
    
    YXSectionInfo *exchangeSection = [YXSectionInfo sectionInfoWithHeader:@"Exchange" footer:nil];
    [exchangeSection addCellInfo:[YXButtonCellInfo cellWithTitle:@"Exchnage With last 1" 
                                                          target:self 
                                                          action:@selector(exchangeWithLast:)]];
    [exchangeSection addCellInfo:[YXButtonCellInfo cellWithTitle:@"Exchnage With last 2" 
                                                          target:self 
                                                          action:@selector(exchangeWithLast:)]];
    [exchangeSection addCellInfo:[YXButtonCellInfo cellWithTitle:@"Exchnage With last 3" 
                                                          target:self 
                                                          action:@selector(exchangeWithLast:)]];
    
    for (YXButtonCellInfo *buttonCellInfo in exchangeSection.cells) {
        // disable selection to avoid user disorientation
        buttonCellInfo.selectionStyle = YXCellInfoSelectionStyleNone;
    }
    
    self.sections = [NSArray arrayWithObjects:moveSection, transitSection, exchangeSection, nil];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)goDown:(YXButtonCellInfo *)buttonCellInfo {
    [self moveCellInfo:buttonCellInfo 
         toSectionInfo:buttonCellInfo.sectionInfo
               atIndex:[buttonCellInfo.sectionInfo.cells count] - 1];
}

- (NSNumber *)initialValueForSwitch:(YXSwitchCellInfo *)s {
    return [NSNumber numberWithBool:NO];
}

- (void)goAndTransit:(YXButtonCellInfo *)buttonCellInfo {
    YXSwitchCellInfo *switchCellInfo = [YXSwitchCellInfo cellWithTitle:@"Turn me on to go back" 
                                                                target:self
                                                    initialValueGetter:@selector(initialValueForSwitch:) 
                                                                action:@selector(goBackToTransitsSectionWithSwitchEvent:newValueIDontCareAbout:)];
    [[self.sections objectAtIndex:0] insertTransitionCellInfo:switchCellInfo atIndex:0];
    [self transitCellInfo:buttonCellInfo toCellInfo:switchCellInfo];
}

- (void)goBackToTransitsSectionWithSwitchEvent:(YXSwitchCellInfo *)switchCellInfo newValueIDontCareAbout:(NSNumber *)v {
    YXButtonCellInfo *targetButtonCell = [YXButtonCellInfo cellWithTitle:@"Transit up to cell with switch"
                                                                  target:self
                                                                  action:@selector(goAndTransit:)];
    [[self.sections objectAtIndex:1] insertTransitionCellInfo:targetButtonCell atIndex:0];
    [self transitCellInfo:switchCellInfo toCellInfo:targetButtonCell];
}

- (void)exchangeWithLast:(YXButtonCellInfo *)buttonCellInfo {
    YXButtonCellInfo *targetCellInfo = [[[self.sections objectAtIndex:2] cells] lastObject];
    [self exchangeCellInfo:buttonCellInfo withCellInfo:targetCellInfo];
}

@end
