//
//  YXSegmentedCellInfo.h
//  ModelTableViewFramework
//
//  Created by Vladislav Alekseev on 10.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

UIKIT_EXTERN NSString *const YXSegmentedCellInfoDefaultReuseIdentidier;

#import <Foundation/Foundation.h>
#import "YXCellInfo.h"

/**
 YXSegmentedCellInfo is cell info object that represents cell with segmented control.
 */

@interface YXSegmentedCellInfo : YXCellInfo {
    id _target;
    SEL _valueSetterSelector;
    SEL _valueGetterSelector;
    NSArray *_segmentTitles;
    BOOL _animatesSwitching;
}
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL valueSetterSelector;
@property (nonatomic, assign) SEL valueGetterSelector;
@property (nonatomic, retain) NSArray *segmentTitles;
@property (nonatomic, assign) BOOL animatesSwitching;

/**
 Creates and returns YXSegmentedCellInfo object with default reuse identifier.
 */
+ (id)cellWithTarget:(id)target
              setter:(SEL)setter 
              getter:(SEL)getter 
        segmentItems:(NSArray *)items;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                       target:(id)target
                       setter:(SEL)setter 
                       getter:(SEL)getter 
                 segmentItems:(NSArray *)items;

@end
