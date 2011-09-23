//
//  YMCacheCellTransition.h
//  YandexMaps
//
//  Created by Алексеев Влад on 03.07.11.
//  Copyright 2011 Yandex. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YXCellInfo;

@protocol YXCellInfoTransitionable <NSObject>
- (UITableViewCell *)cellView;
@end

@protocol YXCellInfoTransitionDelegate;

@interface YXCellInfoTransition : NSObject {
    YXCellInfo <YXCellInfoTransitionable> *_cellInfoFrom;
    YXCellInfo <YXCellInfoTransitionable> *_cellInfoTo;
	id <YXCellInfoTransitionDelegate> _delegate;
}
@property (nonatomic, retain) YXCellInfo <YXCellInfoTransitionable> *cellInfoFrom;
@property (nonatomic, retain) YXCellInfo <YXCellInfoTransitionable> *cellInfoTo;
@property (nonatomic, assign) id <YXCellInfoTransitionDelegate> delegate;

+ (id)transitionFromCellInfo:(YXCellInfo <YXCellInfoTransitionable> *)fromCellInfo 
				  toCellInfo:(YXCellInfo <YXCellInfoTransitionable> *)toCellInfo 
					delegate:(id <YXCellInfoTransitionDelegate>)delegate;
- (void)performAnimated;

@end

@protocol YXCellInfoTransitionDelegate <NSObject>

@optional

- (void)cellInfoTransitionWillStart:(YXCellInfoTransition *)transition;
- (void)cellInfoTransitionDidStart:(YXCellInfoTransition *)transition;
- (void)cellInfoTransitionWillFinish:(YXCellInfoTransition *)transition;
- (void)cellInfoTransitionDidFinish:(YXCellInfoTransition *)transition;

@end

