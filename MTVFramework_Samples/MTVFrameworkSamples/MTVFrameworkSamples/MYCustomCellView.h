//
//  MYCustomCellView.h
//  ModelTableViewFramework
//
//  Created by Vladislav Alekseev on 10.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYCustomCellViewDelegate.h"

@interface MYCustomCellView : UITableViewCell {
    UILabel *_centerLabel;
    id <MYCustomCellViewDelegate> _delegate;
}
@property (nonatomic, retain) IBOutlet UILabel *centerLabel;
@property (nonatomic, assign) id <MYCustomCellViewDelegate> delegate;

- (IBAction)addNewCellToTop:(id)sender;
- (IBAction)addNewCellToBottom:(id)sender;
- (IBAction)deleteToLeft:(id)sender;
- (IBAction)deleteToRight:(id)sender;
- (IBAction)deleteFadeOut:(id)sender;

@end
