//
//  AnimationViewController.h
//  ModelTableViewFramework
//
//  Created by Vladislav Alekseev on 10.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXModelTableViewFramework.h"
#import "MYCustomCellViewDelegate.h"

@class MYCustomCellView;

@interface AnimationViewController : YXModelTableViewController <MYCustomCellViewDelegate, YXCustomCellInfoDelegate> {
    NSUInteger _cellCounter;
    YXSectionInfo *_customContentSection;
    MYCustomCellView *_customCellView;
}
@property (nonatomic, retain) IBOutlet MYCustomCellView *customCellView;

@end
