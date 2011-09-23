//
//  BFNetworkTableViewCell.m
//  MTVFrameworkSamples
//
//  Created by Vladislav Alekseev on 11.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BFNetworkTableViewCell.h"


@implementation BFNetworkTableViewCell

@synthesize checked = _checked;
@synthesize secure = _secure;
@synthesize inProgress = _inProgress;

@synthesize networkNameLabel = _networkNameLabel;
@synthesize checkmarkImageView = _checkmarkImageView;
@synthesize networkTypeImageView = _networkTypeImageView;
@synthesize activityIndicator = _activityIndicator;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    [_networkNameLabel release];
    [_checkmarkImageView release];
    [_networkTypeImageView release];
    
    [super dealloc];
}

- (void)setSecure:(BOOL)secure {
    _secure = secure;
    
    UIImage *wifiImage = secure ? [UIImage imageNamed:@"secure_network.png"] : [UIImage imageNamed:@"unsecure_network.png"];
    [[self networkTypeImageView] setImage:wifiImage];
}

- (void)setActivityIndicatorHighlighted:(BOOL)highlighted {
	if (highlighted) {
        [[self activityIndicator] setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    }
    else {
        [[self activityIndicator] setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
	[self setActivityIndicatorHighlighted:selected];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    [self setActivityIndicatorHighlighted:highlighted];
}

- (void)setChecked:(BOOL)checked {
    _checked = checked;
    
    UIImage *checkmarkImage = checked ? [UIImage imageNamed:@"wifi_checkmark.png"] : [UIImage imageNamed:@"wifi_nocheckmark.png"];
    [[self checkmarkImageView] setImage:checkmarkImage];
}

- (void)setInProgress:(BOOL)inProgress {
    _inProgress = inProgress;
    if (inProgress) {
        [[self activityIndicator] startAnimating];
    }
    else {
        [[self activityIndicator] stopAnimating];
    }
}

@end
