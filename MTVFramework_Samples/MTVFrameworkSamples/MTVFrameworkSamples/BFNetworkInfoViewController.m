//
//  BFNetworkInfoViewController.m
//  MTVFrameworkSamples
//
//  Created by Vladislav Alekseev on 12.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BFNetworkInfoViewController.h"


@implementation BFNetworkInfoViewController

@synthesize networkName = _networkName;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundView = nil;
    
    [self setTitle:[self networkName]];
    
    section1 = [[YXSectionInfo sectionInfoWithHeader:nil footer:nil] retain];
    group = [YXKVOCheckmarkCellGroupInfo checkmarkCellGroupObservingObject:self forKey:@"_shouldAutoconnect"];
    [group retain];
    
    YXCheckmarkCellInfo *dontConnect = [YXCheckmarkCellInfo cellWithReuseIdentifier:@"simpleCheck" 
                                                                              title:@"Не подкл. автоматич." 
                                                                              image:nil 
                                                                              group:group 
                                                                           selected:NO];
    YXCheckmarkCellInfo *doConnect = [YXCheckmarkCellInfo cellWithReuseIdentifier:@"simpleCheck" 
                                                                            title:@"Подключаться автоматич." 
                                                                            image:nil
                                                                            group:group 
                                                                         selected:NO];
    [section1 addCellInfo:dontConnect];
    [section1 addCellInfo:doConnect];

    section2 = [[YXSectionInfo sectionInfoWithHeader:nil footer:nil] retain];
    [section2 addCellInfo:[YXKVOSwitchCellInfo cellWithReuseIdentifier:@"kvoSwitch" 
                                                                 title:@"Автоподключение" 
                                                         observeObject:self 
                                                                forKey:@"_shouldAutoconnect"]];
    
    [self setSections:[NSArray arrayWithObjects:section1, section2, nil]];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    [group release], group = nil;
    [section1 release], section1 = nil;
    [section2 release], section2 = nil;
}

- (void)dealloc {
    [group release];
    [section1 release];
    [section2 release];
    
    [super dealloc];
}

@end
