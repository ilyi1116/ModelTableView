//
//  BFNetworkCellInfo.h
//  MTVFrameworkSamples
//
//  Created by Vladislav Alekseev on 11.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXModelTableViewFramework.h"

@class BFNetworkTableViewCell;

@interface BFNetworkCellInfo : YXDisclosureButtonCellInfo {
    BOOL _connecting;
    BOOL _connected;
    BOOL _secure;
    BFNetworkTableViewCell *_networkTableViewCell;
}
@property (nonatomic, assign) BOOL connecting;
@property (nonatomic, assign) BOOL connected;
@property (nonatomic, assign) BOOL secure;
@property (nonatomic, retain) IBOutlet BFNetworkTableViewCell *networkTableViewCell;

@end
