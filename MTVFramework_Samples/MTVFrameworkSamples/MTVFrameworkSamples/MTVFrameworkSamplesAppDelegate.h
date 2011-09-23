//
//  MTVFrameworkSamplesAppDelegate.h
//  MTVFrameworkSamples
//
//  Created by Vladislav Alekseev on 11.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFWiFiNetworksViewController;

@interface MTVFrameworkSamplesAppDelegate : NSObject <UIApplicationDelegate> {
    UINavigationController *_navigationController;
    BFWiFiNetworksViewController *_wifiNetworksViewController;
}

@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) BFWiFiNetworksViewController *wifiNetworksViewController;

@end
