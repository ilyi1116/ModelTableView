//
//  BFNetworkInfoViewController.h
//  MTVFrameworkSamples
//
//  Created by Vladislav Alekseev on 12.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXModelTableViewFramework.h"

@interface BFNetworkInfoViewController : YXModelTableViewController {
    NSString *_networkName;
    YXKVOCheckmarkCellGroupInfo *group;
    BOOL _shouldAutoconnect;
    YXSectionInfo *section1;
    YXSectionInfo *section2;
}
@property (nonatomic, retain) NSString *networkName;

@end
