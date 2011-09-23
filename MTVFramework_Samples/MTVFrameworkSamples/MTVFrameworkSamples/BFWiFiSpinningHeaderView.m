//
//  BFWiFiSpinningHeaderView.m
//  MTVFrameworkSamples
//
//  Created by Vladislav Alekseev on 11.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "BFWiFiSpinningHeaderView.h"

@implementation BFWiFiSpinningHeaderView

@synthesize activityIndicator = _activityIndicator;


- (id)init {
    return [self initWithFrame:CGRectMake(0, 0, 320, 45.0)];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(frame.origin.x, 
                                           frame.origin.y,
                                           frame.size.width, 
                                           (frame.size.height < 45.0f) ? 45.0f : frame.size.height)];
    if (self) {
        [self addSubview:[self activityIndicator]];
    }
    return self;
}

- (UIActivityIndicatorView *)activityIndicator {
    if (_activityIndicator == nil) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [[_activityIndicator layer] setShadowColor:[[UIColor whiteColor] CGColor]];
        [[_activityIndicator layer] setShadowOffset:CGSizeMake(0, 1)];
        [[_activityIndicator layer] setShadowOpacity:1.00];
        [[_activityIndicator layer] setShadowRadius:0.0];
        
        CGFloat sideOffset = fmaxf((CGRectGetWidth(self.bounds) - 130.0f) / 10.0f, 0.0f);
        
        [_activityIndicator setFrame:CGRectMake(sideOffset + 200,
                                                self.frame.size.height/2 - _activityIndicator.frame.size.height/2, 
                                                _activityIndicator.frame.size.width, 
                                                _activityIndicator.frame.size.height)];
        
    }
    return _activityIndicator;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	CGRect myFrame = [self frame];
	CGRect indicatorFrame = [[self activityIndicator] frame];
	
	indicatorFrame.origin.y = myFrame.size.height/2 - indicatorFrame.size.height/2;
	[[self activityIndicator] setFrame:indicatorFrame];
}

- (void)dealloc {
    [_activityIndicator release];
    [super dealloc];
}

- (BOOL)isSpinning {
    return [_activityIndicator isAnimating];
}

- (void)startSpinning {
    [_activityIndicator startAnimating];
}

- (void)stopSpinning {
    [_activityIndicator stopAnimating];
}

@end
