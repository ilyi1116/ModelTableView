//
//  BFWiFiNetworksViewController.h
//  MTVFrameworkSamples
//
//  Created by Vladislav Alekseev on 11.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXModelTableViewFramework.h"
@class BFWiFiSpinningHeaderView;

@interface BFWiFiNetworksViewController : YXModelTableViewController {
	YXSectionInfo *_themeSection;
    YXSectionInfo *_sectionWiFiSwitch;
    YXSectionInfo *_sectionWiFiNetworks;
    
	BOOL _isNightMode;
    BOOL _isWifiEnabled;
    BOOL _connecting;
    
    BFWiFiSpinningHeaderView *_wifiSwitchSectionHeader;
}
@property (nonatomic, retain) BFWiFiSpinningHeaderView *wifiSwitchSectionHeader;
- (void)afterTheeSecondsStartSearchingAgain;
- (void)displaySpinnerForThreeSecondsAndFindAnotherNetwork;

@end
