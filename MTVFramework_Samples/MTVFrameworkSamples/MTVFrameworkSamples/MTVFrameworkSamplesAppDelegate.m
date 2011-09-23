//
//  MTVFrameworkSamplesAppDelegate.m
//  MTVFrameworkSamples
//
//  Created by Vladislav Alekseev on 11.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MTVFrameworkSamplesAppDelegate.h"
#import "BFWiFiNetworksViewController.h"

@implementation MTVFrameworkSamplesAppDelegate

@synthesize window=_window;
@synthesize navigationController = _navigationController;
@synthesize wifiNetworksViewController = _wifiNetworksViewController;

- (UINavigationController *)navigationController {
    if (_navigationController == nil) {
        _navigationController = [[UINavigationController alloc] initWithRootViewController:[self wifiNetworksViewController]];
    }
    return _navigationController;
}

- (BFWiFiNetworksViewController *)wifiNetworksViewController {
    if (_wifiNetworksViewController == nil) {
        _wifiNetworksViewController = [[BFWiFiNetworksViewController alloc] initWithStyle:UITableViewStyleGrouped];
    }
    return _wifiNetworksViewController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self.window makeKeyAndVisible];
    
	[[self window] addSubview:[[self navigationController] view]];
	
    //[[self window] setRootViewController:[self navigationController]];
    
    return YES;
}

- (void)dealloc {
    [_window release];
    [_navigationController release];
    [_wifiNetworksViewController release];
    [super dealloc];
}

@end
