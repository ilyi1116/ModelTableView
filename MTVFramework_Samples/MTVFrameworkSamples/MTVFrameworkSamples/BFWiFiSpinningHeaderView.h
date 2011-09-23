//
//  BFWiFiSpinningHeaderView.h
//  MTVFrameworkSamples
//
//  Created by Vladislav Alekseev on 11.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXModelTableViewFramework.h"

@interface BFWiFiSpinningHeaderView : YXModelTableHelperView {
    UIActivityIndicatorView *_activityIndicator;
}
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

- (BOOL)isSpinning;
- (void)startSpinning; 
- (void)stopSpinning;

@end
