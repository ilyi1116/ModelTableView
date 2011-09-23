//
//  RootViewController.h
//  ModelTableViewFramework
//
//  Created by Vladislav Alekseev on 10.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXModelTableViewFramework.h"

@interface OtherSamplesViewController : YXModelTableViewController {
    YXSectionInfo *section;
}

- (void)fillSections; // будет вызван через 0.3 сек после старта

@end
