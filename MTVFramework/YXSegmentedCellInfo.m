//
//  YXSegmentedCellInfo.m
//  ModelTableViewFramework
//
//  Created by Vladislav Alekseev on 10.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

NSString *const YXSegmentedCellInfoDefaultReuseIdentidier = @"YXSegmentedCellInfoDefaultReuseIdentidier";

#import <QuartzCore/QuartzCore.h>

#import "YXModelTableViewController.h"
#import "YXSegmentedCellInfo.h"
#import "YXSegmentedTableViewCell.h"

@implementation YXSegmentedCellInfo

@synthesize target = _target;
@synthesize valueSetterSelector = _valueSetterSelector;
@synthesize valueGetterSelector = _valueGetterSelector;
@synthesize segmentTitles = _segmentTitles;
@synthesize animatesSwitching = _animatesSwitching;

+ (NSString *)defaultReuseIdentifier {
    return YXSegmentedCellInfoDefaultReuseIdentidier;
}

+ (id)cellWithTarget:(id)target
              setter:(SEL)setter 
              getter:(SEL)getter 
        segmentItems:(NSArray *)items {
    return [self cellWithReuseIdentifier:[self defaultReuseIdentifier]
                                  target:target
                                  setter:setter
                                  getter:getter
                            segmentItems:items];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                       target:(id)target
                       setter:(SEL)setter 
                       getter:(SEL)getter 
                 segmentItems:(NSArray *)items {
    
    YXSegmentedCellInfo *cellInfo = [[self alloc] initWithReuseIdentifier:reuseIdentifier];
    [cellInfo setTarget:target];
    [cellInfo setValueGetterSelector:getter];
    [cellInfo setValueSetterSelector:setter];
    [cellInfo setSegmentTitles:items];
	[cellInfo setSelectionStyle:YXCellInfoSelectionStyleNone];
    [cellInfo setAllowsSelection:NO];
    [cellInfo setAnimatesSwitching:YES];
    
    return [cellInfo autorelease];
}

- (void)dealloc {
    [_segmentTitles release];
    
    [super dealloc];
}

- (CGFloat)rowHeight {
	return 45.0f;
}

- (BOOL)shouldUpdateCell:(UITableViewCell *)tableViewCell usingRowAnimation:(UITableViewRowAnimation)animationStyle {
    YXSegmentedTableViewCell *cell = (YXSegmentedTableViewCell *)tableViewCell;
    
    NSNumber *currentValue = [_target performSelector:_valueGetterSelector withObject:self];
    NSUInteger intValue = [currentValue unsignedIntegerValue];
    
    if (self.animatesSwitching) {
        if (animationStyle != UITableViewRowAnimationNone) {
            CATransition *transition = [CATransition animation];
            [transition setType:kCATransitionFade];
            
            [[[cell segmentedControl] layer] addAnimation:transition forKey:kCATransition];
        }
    }
    
    [[cell segmentedControl] setSelectedSegmentIndex:intValue];
    
    return NO;
}

- (UITableViewCell *)tableViewCell {
    return [[[YXSegmentedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:self.reuseIdentifier] autorelease];
}

- (void)configureCell:(UITableViewCell *)reusableCell {
    YXSegmentedTableViewCell *cell = (YXSegmentedTableViewCell *)reusableCell;
    
    NSNumber *currentValue = [_target performSelector:_valueGetterSelector withObject:self];
    NSUInteger intValue = [currentValue unsignedIntegerValue];
    
    if ([[self segmentTitles] count] == [[cell segmentedControl] numberOfSegments]) {
        for (NSString *segmentTitle in [self segmentTitles]) {
            NSUInteger segmentIndex = [[self segmentTitles] indexOfObject:segmentTitle];
            [[cell segmentedControl] setTitle:segmentTitle forSegmentAtIndex:segmentIndex];
        }
    }
    else {
        [[cell segmentedControl] removeAllSegments];
        for (NSString *segmentTitle in [self segmentTitles]) {
            NSUInteger segmentIndex = [[self segmentTitles] indexOfObject:segmentTitle];
            [[cell segmentedControl] insertSegmentWithTitle:segmentTitle
                                                    atIndex:segmentIndex
                                                   animated:NO];
        }
    }
	
    [[cell segmentedControl] setSelectedSegmentIndex:intValue];
    [cell setTarget:self action:@selector(segmentedControlDidChangeSelection:)];
}

- (void)segmentedControlDidChangeSelection:(UISegmentedControl *)control {
    NSUInteger newSelection = [control selectedSegmentIndex];
    NSNumber *newValue = [NSNumber numberWithUnsignedInteger:newSelection];
    
    [_target performSelector:_valueSetterSelector withObject:self withObject:newValue];
}

@end
