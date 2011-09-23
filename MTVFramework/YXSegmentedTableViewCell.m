//
//  YXSegmentedTableViewCell.m
//  ModelTableViewFramework
//
//  Created by Vladislav Alekseev on 10.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

#import "YXSegmentedTableViewCell.h"

CGFloat const kSegmentedHeightPlainStyle = 44.0f;
CGFloat const kSegmentedHeightBarStyle = 30.0f;
CGFloat const kSegmentedHeightBezeledStyle = 40.0f;

@implementation YXSegmentedTableViewCell

@synthesize segmentedControl = _segmentedControl;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [[self contentView] setBackgroundColor:[UIColor clearColor]];
		[self setBackgroundColor:[UIColor clearColor]];
        [[self contentView] addSubview:[self segmentedControl]];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
	
	[[self backgroundView] setHidden:YES];
	
	CGRect contentBounds = [[self contentView] bounds];
    [[self segmentedControl] setFrame:contentBounds];
}

- (UISegmentedControl *)segmentedControl {
    if (_segmentedControl == nil) {
        _segmentedControl = [[UISegmentedControl alloc] initWithFrame:CGRectZero];
        [_segmentedControl setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    }
    return _segmentedControl;
}

- (void)dealloc {
    [_segmentedControl release];
    [super dealloc];
}

- (void)setTarget:(id)target action:(SEL)action {
    if (_segmentedControl) {
        [_segmentedControl removeTarget:nil action:NULL forControlEvents:UIControlEventValueChanged];
        [_segmentedControl addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    }
}

@end
