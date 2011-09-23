//
//  ModelTableViewFrameworkViewController.h
//  ModelTableViewFramework
//
//  Created by Vladislav Alekseev on 03.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXModelTableViewController.h"
#import "YXSwitchCellInfoDelegate.h"

@interface CellSamplesViewController : YXModelTableViewController <YXSwitchCellInfoDelegate> {
    BOOL myBoolValue;
    NSString *someStringValue;
}
@property (nonatomic, retain) NSString *someStringValue;

@end

