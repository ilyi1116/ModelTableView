//
//  BFWiFiNetworksViewController.m
//  MTVFrameworkSamples
//
//  Created by Vladislav Alekseev on 11.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <dispatch/dispatch.h>

#import "BFWiFiNetworksViewController.h"
#import "BFNetworkInfoViewController.h"
#import "OtherSamplesViewController.h"

#import "BFWiFiSpinningHeaderView.h"

#import "BFNetworkCellInfo.h"

@implementation BFWiFiNetworksViewController

@synthesize wifiSwitchSectionHeader = _wifiSwitchSectionHeader;

- (void)dealloc {
    [_sectionWiFiSwitch release];
    [_sectionWiFiNetworks release];
    [_wifiSwitchSectionHeader release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [_wifiSwitchSectionHeader release], _wifiSwitchSectionHeader = nil;
}

- (NSArray *)networks {
    return [NSArray arrayWithObjects:@"connect2me", @"GreenZone", @"dlink", @"moiseev", @"mcdonalds", nil];
}

#pragma mark Lazy View Creation

- (BFWiFiSpinningHeaderView *)wifiSwitchSectionHeader {
    if (_wifiSwitchSectionHeader == nil) {
        _wifiSwitchSectionHeader = [[BFWiFiSpinningHeaderView alloc] initWithFrame:CGRectZero];
    }
    return _wifiSwitchSectionHeader;
}

#pragma mark 

- (void)afterTheeSecondsStartSearchingAgain {
    if (!_isWifiEnabled)
        return;
    
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if (!_isWifiEnabled)
            return;
        
        if ([[self wifiSwitchSectionHeader] isSpinning])
            return;
        
        [self displaySpinnerForThreeSecondsAndFindAnotherNetwork];
    });
}

- (void)displaySpinnerForThreeSecondsAndFindAnotherNetwork {
    if (!_isWifiEnabled) {
        return;
    }
    
    if ([[self wifiSwitchSectionHeader] isSpinning]) {
        return;
    }
    
    [[self wifiSwitchSectionHeader] startSpinning];
    
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if (!_isWifiEnabled)
            return;
        
        [[self wifiSwitchSectionHeader] stopSpinning];
        
        NSInteger numberOfFoundNetworks = [[_sectionWiFiNetworks cells] count] - 1;
        if (numberOfFoundNetworks < [[self networks] count]) {
            NSString *newDiscoveredNetwork = [[self networks] objectAtIndex:numberOfFoundNetworks];
            BFNetworkCellInfo *networkCell = [BFNetworkCellInfo cellWithReuseIdentifier:@"networkCell" 
                                                                                  title:newDiscoveredNetwork 
                                                                                 target:self 
                                                                                 action:@selector(didSelectNetworkCellInfo:) 
                                                                       disclosureAction:@selector(didTapDisclosureButtonForCell:)];
            float scale=RAND_MAX+1.;
            float randomNumber = rand() / scale;
            BOOL isSecure = (randomNumber > 0.5);
            [networkCell setSecure:isSecure];
            
            [_sectionWiFiNetworks insertCellInfo:networkCell 
                                         atIndex:numberOfFoundNetworks 
                                animateWithStyle:UITableViewRowAnimationBottom];
        }
        
        [self afterTheeSecondsStartSearchingAgain];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundView = nil;
    
    [self setTitle:@"Wi-Fi"];
    
    srand(time(NULL));
    
    _isWifiEnabled = YES;
	
	_themeSection = [[YXSectionInfo sectionInfo] retain];
	[_themeSection addCellInfo:[YXSegmentedCellInfo cellWithTarget:self
															setter:@selector(segmentedCellInfo:didSelectValue:)
															getter:@selector(valueForSegmentedCellInfo:)
													  segmentItems:[NSArray arrayWithObjects:@"Default", @"Night", nil]]];
    
    _sectionWiFiSwitch = [[YXSectionInfo sectionInfoWithHeader:@"Выберите сеть..." footer:nil] retain];
    [_sectionWiFiSwitch setHeaderView:[self wifiSwitchSectionHeader]];
    [_sectionWiFiSwitch addCellInfo:[YXSwitchCellInfo cellWithReuseIdentifier:@"switchCell" 
                                                                        title:@"WiFi" 
                                                                       target:self 
                                                           initialValueGetter:@selector(isWiFiEnabled:) 
                                                                       action:@selector(wifiSwitchCell:setWifiEnabled:)]];
    
    _sectionWiFiNetworks = [[YXSectionInfo sectionInfoWithHeader:@"Сети" 
													  footer:@"Подключение к известным сетям будет происходить автоматически. Если этого текста мало, можно добавить еще кое-какой текст, чтобы проверить, так сказать, на прочность наш новый объект."] retain];
    [_sectionWiFiNetworks addCellInfo:[YXDisclosureCellInfo cellWithReuseIdentifier:@"disclosureCellInfo" 
                                                                              title:@"Другие примеры"
                                                                             target:self 
                                                                             action:@selector(selectOtherWifiNetwork:)]];
    [self setSections:[NSArray arrayWithObjects:_themeSection, _sectionWiFiSwitch, _sectionWiFiNetworks, nil]];
    
    [self displaySpinnerForThreeSecondsAndFindAnotherNetwork];
}


- (void)viewDidUnload {
    [super viewDidUnload];
    
    [_sectionWiFiSwitch release], _sectionWiFiSwitch = nil;
    [_sectionWiFiNetworks release], _sectionWiFiNetworks = nil;
    [_wifiSwitchSectionHeader release], _wifiSwitchSectionHeader = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;//(interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Network Cells Actions

- (void)didSelectNetworkCellInfo:(BFNetworkCellInfo *)cellInfo {
    if (_connecting) 
        return;

    // убираем выделение с других ячеек
    for (BFNetworkCellInfo *_info in _sectionWiFiNetworks.cells) {
        if (_info != [_sectionWiFiNetworks.cells lastObject]) {
            [_info setConnected:NO];   
        }
    }
    
    _connecting = YES;
    
    [cellInfo setConnecting:YES];
    
    double delayInSeconds = 6.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // убираем выделение с других ячеек
        for (BFNetworkCellInfo *_info in _sectionWiFiNetworks.cells) {
            if (_info != [_sectionWiFiNetworks.cells lastObject]) {
                if (_info == cellInfo) {
                    [_info setConnected:YES];
                }
                else {
                    [_info setConnected:NO];   
                }
            }
        }
        
        _connecting = NO;
    });
}

- (void)didTapDisclosureButtonForCell:(BFNetworkCellInfo *)cellInfo {
    BFNetworkInfoViewController *networkInfoViewController = [[BFNetworkInfoViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [networkInfoViewController setNetworkName:[cellInfo title]];
    [networkInfoViewController setStyleInfo:self.styleInfo];
    [[self navigationController] pushViewController:networkInfoViewController animated:YES];
    [networkInfoViewController release];
}

- (void)selectOtherWifiNetwork:(YXDisclosureCellInfo *)cellInfo {
    OtherSamplesViewController *other = [[OtherSamplesViewController alloc] initWithStyle:UITableViewStyleGrouped];
	[other setStyleInfo:self.styleInfo];
    [[self navigationController] pushViewController:other animated:YES];
    [other release];
}

#pragma mark WiFi switch selectors

- (NSNumber *)valueForSegmentedCellInfo:(YXSegmentedCellInfo *)cellInfo {
	return [NSNumber numberWithBool:_isNightMode];
}

- (void)segmentedCellInfo:(YXSegmentedCellInfo *)cellInfo didSelectValue:(NSNumber *)value {
	BOOL newTheme = [value boolValue];
	
	if (_isNightMode != newTheme) {
		_isNightMode = newTheme;
		if (_isNightMode) {
			[self setStyleInfo:[YXStyleInfo defaultInvertedStyleInfo]];
		}
		else {
			[self setStyleInfo:[YXStyleInfo defaultStyleInfo]];
		}
		
		CATransition *transition = [CATransition animation];
		[transition setType:kCATransitionFade];
		[[[self view] layer] addAnimation:transition forKey:kCATransition];
		
		[[self tableView] reloadData];
	}
}

- (NSNumber *)isWiFiEnabled:(YXSwitchCellInfo *)cellInfo {
    return [NSNumber numberWithBool:_isWifiEnabled];
}

- (void)wifiSwitchCell:(YXSwitchCellInfo *)cellInfo setWifiEnabled:(NSNumber *)enabledNumber {
    _isWifiEnabled = [enabledNumber boolValue];
    
    if (!_isWifiEnabled) {        
        [[self wifiSwitchSectionHeader] stopSpinning];
        [self deleteSection:_sectionWiFiNetworks withAnimation:UITableViewRowAnimationFade];
        
        // удаляем все ячейки-сети, если они есть
        
        NSInteger numberOfWiFiNetworksFound = [[_sectionWiFiNetworks cells] count] - 1;
        if (numberOfWiFiNetworksFound > 0) {
            NSRange cellsRange = NSMakeRange(0, numberOfWiFiNetworksFound);
            NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:cellsRange];
            [_sectionWiFiNetworks deleteCellInfoWithIndexes:indexes animateWithStyle:UITableViewRowAnimationNone];
        }
    }
    else {
        [self insertSection:_sectionWiFiNetworks atPosition:YXSectionInsertionPositionBottom withAnimation:UITableViewRowAnimationFade];
		[self displaySpinnerForThreeSecondsAndFindAnotherNetwork];
    }
    
    return;
}

@end
