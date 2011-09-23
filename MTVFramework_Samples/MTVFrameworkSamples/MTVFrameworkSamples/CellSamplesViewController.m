//
//  ModelTableViewFrameworkViewController.m
//  ModelTableViewFramework
//
//  Created by Vladislav Alekseev on 03.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CellSamplesViewController.h"
#import "YXModelTableViewFramework.h"

@implementation CellSamplesViewController

@synthesize someStringValue;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundView = nil;
    
    [self setSomeStringValue:@"initial value"];
	
	YXSectionInfo *section = [YXSectionInfo sectionInfoWithHeader:nil footer:nil];
    [section addCellInfo:[YXButtonCellInfo cellWithReuseIdentifier:@"cellButton" 
                                                         title:@"YXButtonCellInfo"
                                                        target:self 
                                                        action:@selector(myButtonCellWasClicked:)]];
    
    YXTextFieldCellInfo *editableCell = [YXTextFieldCellInfo cellWithReuseIdentifier:@"textFieldCell" 
                                                                                   title:@"YXTextFieldCell"
                                                                                   value:[self someStringValue]
                                                                             placeholder:@"Placeholder" 
                                                                                  target:self 
                                                                                  action:@selector(myEditableCell:didUpdateValue:) 
                                                                    initialValueSelector:@selector(initialValueForMyEditableCell:)];
    [editableCell setClearButtonMode:UITextFieldViewModeWhileEditing];
    [section addCellInfo:editableCell];
    [section addCellInfo:[YXKVOTitleValueCellInfo cellWithReuseIdentifier:@"kvoTitleValueCell" 
                                            observeObjectForTitle:self 
                                                           forKey:@"someStringValue" 
                                            observeObjectForValue:self 
                                                           forKey:@"someStringValue"]];
	[section addCellInfo:[YXTitleValue2CellInfo cellWithTitle:@"mobile" value:@"4r2"]];
	[section addCellInfo:[YXTitleSubtitleCellInfo cellWithTitle:@"Title" value:@"Subtitle"]];
    
    YXCheckmarkCellGroupInfo *group = [[YXCheckmarkCellGroupInfo alloc] init];
    [group setDelegate:self];
    [group setChangeHandler:@selector(checkmarkGroup:didChangeValue:)];
    YXCheckmarkCellInfo *cell1 = [YXCheckmarkCellInfo cellWithReuseIdentifier:@"checkMarkCell" 
                                                               title:@"YXCheckmarkCell OFF" 
                                                               image:nil 
                                                               group:group
                                                            selected:NO];
    YXCheckmarkCellInfo *cell2 = [YXCheckmarkCellInfo cellWithReuseIdentifier:@"checkMarkCell" 
                                                               title:@"YXCheckmarkCell ON" 
                                                               image:nil 
                                                               group:group
                                                            selected:NO];
    
    YXSectionInfo *section2 = [YXSectionInfo sectionInfoWithHeader:@"YXCheckmarkCellGroup" 
														footer:@"YXCheckmarkCellGroup Footer"];
    [section2 addCellInfo:cell1];
    [section2 addCellInfo:cell2];
    
    YXSectionInfo *section3 = [YXSectionInfo sectionInfoWithHeader:@"Switches, KVO checkmark" footer:nil];
    [section3 addCellInfo:[YXSwitchCellInfo cellWithReuseIdentifier:@"switchCell" 
                                                      title:@"YXSwitchCell" 
                                                   delegate:self]];
    [section3 addCellInfo:[YXKVOSwitchCellInfo cellWithReuseIdentifier:@"kvoSwitchCell" 
                                                         title:@"KVO Switch Cell" 
                                                 observeObject:self 
                                                        forKey:@"myBoolValue"]];
    [section3 addCellInfo:[YXKVOCheckmarkCellInfo cellWithReuseIdentifier:@"kvoCheckmarkCell" 
                                                            title:@"YXKVOCheckmarkCell" 
                                                            image:nil 
                                                    observeObject:self 
                                                           forKey:@"myBoolValue"]];
    [section3 addCellInfo:[YXSegmentedCellInfo cellWithReuseIdentifier:@"segmentedCellInfo" 
                                                                target:self 
                                                                setter:@selector(segmentedCell:didSelectNewValue:) 
                                                                getter:@selector(valueForSegmentedCell:) 
                                                         segmentItems:[NSArray arrayWithObjects:@"OFF", @"ON", nil]]];
    [section3 addCellInfo:[YXKVOSegmentedCellInfo cellWithReuseIdentifier:@"kvoSegmentedCellInfo"
                                                            observeObject:self 
                                                                   forKey:@"myBoolValue" 
                                                             segmentItems:[NSArray arrayWithObjects:@"OFF", @"ON", nil]]];
    
    YXKVOCheckmarkCellGroupInfo *kvoGroup = [[YXKVOCheckmarkCellGroupInfo checkmarkCellGroupObservingObject:self 
                                                                                            forKey:@"myBoolValue"] retain];
    YXCheckmarkCellInfo *kvoCell1 = [YXCheckmarkCellInfo cellWithReuseIdentifier:@"kvoGroupCell" 
                                                                   title:@"YXKVOCheckmarkCellGroup OFF"
                                                                   image:nil
                                                                   group:kvoGroup 
                                                                selected:NO]; 
    YXCheckmarkCellInfo *kvoCell2 = [YXCheckmarkCellInfo cellWithReuseIdentifier:@"kvoGroupCell" 
                                                                   title:@"YXKVOCheckmarkCellGroup ON"
                                                                   image:nil
                                                                   group:kvoGroup 
                                                                selected:NO];
    [section3 addCellInfo:kvoCell1];
    [section3 addCellInfo:kvoCell2];
    
	[self setSections:[NSArray arrayWithObjects:section, section2, section3, nil]];
}
     
- (void)myButtonCellWasClicked:(YXButtonCellInfo *)cellInfo {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                    message:@"Hello" 
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
    [cellInfo setTitle:@"New title"];
}

- (void)checkmarkGroup:(YXCheckmarkCellGroupInfo *)group didChangeValue:(NSNumber *)newValue {
    [self willChangeValueForKey:@"myBoolValue"];
    myBoolValue = [newValue boolValue];
    [self didChangeValueForKey:@"myBoolValue"];
}

- (BOOL)booleanStateForSwitchCellInfo:(YXSwitchCellInfo *)cellInfo {
    return myBoolValue;
}

- (void)switchCellInfo:(YXSwitchCellInfo *)cellInfo didChangeValue:(BOOL)newValue {
    [self willChangeValueForKey:@"myBoolValue"];
    myBoolValue = newValue;
    [self didChangeValueForKey:@"myBoolValue"];
}

- (NSString *)initialValueForMyEditableCell:(YXTextFieldCellInfo *)cellInfo {
    return [self someStringValue];
}

- (void)myEditableCell:(YXTextFieldCellInfo *)cell didUpdateValue:(NSString *)newValue {
    [self setSomeStringValue:newValue];
}

- (NSNumber *)valueForSegmentedCell:(YXSegmentedCellInfo *)cellInfo {
    return [NSNumber numberWithBool:myBoolValue];
}
                           
- (void)segmentedCell:(YXSegmentedCellInfo *)cellInfo didSelectNewValue:(NSNumber *)newValue {
    NSUInteger value = [newValue unsignedIntegerValue];
    [self willChangeValueForKey:@"myBoolValue"];
    myBoolValue = value;
    [self didChangeValueForKey:@"myBoolValue"];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
