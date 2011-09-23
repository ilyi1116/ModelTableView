//
//  BFNetworkTableViewCell.h
//  MTVFrameworkSamples
//
//  Created by Vladislav Alekseev on 11.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BFNetworkTableViewCell : UITableViewCell {
    BOOL _checked;
    BOOL _inProgress;
    BOOL _secure;
    UILabel *_networkNameLabel;
    UIImageView *_checkmarkImageView;
    UIImageView *_networkTypeImageView;
    UIActivityIndicatorView *_activityIndicator;
}
@property (nonatomic, assign) BOOL checked;
@property (nonatomic, assign) BOOL secure;
@property (nonatomic, assign) BOOL inProgress;
@property (nonatomic, retain) IBOutlet UILabel *networkNameLabel;
@property (nonatomic, retain) IBOutlet UIImageView *checkmarkImageView;
@property (nonatomic, retain) IBOutlet UIImageView *networkTypeImageView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
