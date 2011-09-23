//
//  YMCacheCellTransition.m
//  YandexMaps
//
//  Created by Алексеев Влад on 03.07.11.
//  Copyright 2011 Yandex. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "YXCellInfo.h"
#import "YXCellInfoTransition.h"

#import "YXSectionInfo.h"
#import "YXModelTableViewController.h"

typedef enum {
    YXCellInfoTransitionDirectionDown,
    YXCellInfoTransitionDirectionUp,
} YXCellInfoTransitionDirection;

@implementation YXCellInfoTransition

@synthesize cellInfoFrom = _cellInfoFrom;
@synthesize cellInfoTo = _cellInfoTo;
@synthesize delegate = _delegate;

+ (id)transitionFromCellInfo:(YXCellInfo <YXCellInfoTransitionable> *)fromCellInfo 
				  toCellInfo:(YXCellInfo <YXCellInfoTransitionable> *)toCellInfo 
					delegate:(id <YXCellInfoTransitionDelegate>)delegate {
    YXCellInfoTransition *cellInfoTransition = [[self alloc] init];
	[cellInfoTransition setDelegate:delegate];
    [cellInfoTransition setCellInfoFrom:fromCellInfo];
    [cellInfoTransition setCellInfoTo:toCellInfo];
    
    [cellInfoTransition performAnimated];
    
    return [cellInfoTransition autorelease];
}

- (void)dealloc {
    [_cellInfoFrom release], _cellInfoFrom = nil;
	[_cellInfoTo release], _cellInfoTo = nil;
    
    [super dealloc];
}

- (void)performAnimated {
    [self retain];
	
	if ([self.delegate respondsToSelector:@selector(cellInfoTransitionWillStart:)]) {
		[self.delegate cellInfoTransitionWillStart:self];
	}
    
    //    YXSectionInfo *fromSectionInfo = self.cellInfoFrom.sectionInfo;
    
    UITableViewCell *fromCell = [self.cellInfoFrom cellView];
    UITableViewCell *toCell = [self.cellInfoTo cellView];
    
    UITableView *sharedTableView = (UITableView *)fromCell.superview;
    
    NSIndexPath *fromIndexPath = [sharedTableView indexPathForCell:fromCell];
    NSIndexPath *toIndexPath = [sharedTableView indexPathForCell:toCell];
    
    CGRect fromIndexPathFrame = [sharedTableView rectForRowAtIndexPath:fromIndexPath];
    CGRect toIndexPathFrame = [sharedTableView rectForRowAtIndexPath:toIndexPath];
    
    CGRect fromCellFrame = fromCell.frame;
    fromCellFrame.origin = fromIndexPathFrame.origin;
    CGRect toCellFrame = toCell.frame;
    toCellFrame.origin = toIndexPathFrame.origin;
    
    YXCellInfoTransitionDirection transitionDirection;
    if (fromIndexPath.section > toIndexPath.section) {
        transitionDirection = YXCellInfoTransitionDirectionUp;
    }
    else if (fromIndexPath.section < toIndexPath.section) {
        transitionDirection = YXCellInfoTransitionDirectionDown;
    }
    else {
        if (fromIndexPath.row > toIndexPath.row) {
            transitionDirection = YXCellInfoTransitionDirectionUp;
        }
        else {
            transitionDirection = YXCellInfoTransitionDirectionDown;
        }
    }
    
    if (transitionDirection == YXCellInfoTransitionDirectionUp) {
        fromCellFrame.origin.y -= toCellFrame.size.height;
    }
    else {
        toCellFrame.origin.y -= fromCellFrame.size.height;
    }
    
    self.cellInfoFrom.rowHeight = 0.0f;
    [sharedTableView beginUpdates];
    [sharedTableView endUpdates];
    
    // размещаем ячейки на одной высоте fromCellFrame, toCell под fromCell
    CGPoint cellsOrigin = fromCellFrame.origin;
    CGRect fromCellTransitionFrame = CGRectMake(cellsOrigin.x, cellsOrigin.y, fromCellFrame.size.width, fromCellFrame.size.height);
    CGRect toCellTransitionFrame = CGRectMake(cellsOrigin.x, cellsOrigin.y, toCellFrame.size.width, toCellFrame.size.height);
    [sharedTableView.superview addSubview:toCell];
    [sharedTableView.superview addSubview:fromCell];
    fromCell.frame = fromCellTransitionFrame;
    toCell.frame = toCellTransitionFrame;
    
    // двигаем анимированно ячейки на toCellFrame, скрывая fromCell
    
    [UIView beginAnimations:@"transitionAnimation" context:nil];
    [UIView setAnimationDuration:0.29];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    fromCell.alpha = 0.0f;
    
    fromCell.frame = toCellFrame;
    toCell.frame = toCellFrame;
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(transitionAnimationDidStop:finished:context:)];
    
    [UIView commitAnimations];
	
	if ([self.delegate respondsToSelector:@selector(cellInfoTransitionDidStart:)]) {
		[self.delegate cellInfoTransitionDidStart:self];
	}
}

- (void)delayedFinishTransition {
	if ([self.delegate isKindOfClass:[NSObject class]] &&
        [self.delegate respondsToSelector:@selector(cellInfoTransitionDidFinish:)]) 
    {
		[(NSObject*)self.delegate performSelectorOnMainThread:@selector(cellInfoTransitionDidFinish:) 
                                                   withObject:self 
                                                waitUntilDone:NO];
	}
}

- (void)transitionAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	if ([self.delegate respondsToSelector:@selector(cellInfoTransitionWillFinish:)]) {
		[self.delegate cellInfoTransitionWillFinish:self];
	}
	
    UITableViewCell *fromCell = [self.cellInfoFrom cellView];
    UITableViewCell *toCell = [self.cellInfoTo cellView];
    
    YXSectionInfo *fromSectionInfo = self.cellInfoFrom.sectionInfo;
    YXSectionInfo *toSectionInfo = self.cellInfoTo.sectionInfo;
    NSUInteger toCellIndex = [toSectionInfo.cells indexOfObject:self.cellInfoTo];
    
    [fromCell removeFromSuperview];
    [toCell removeFromSuperview];
	
	//YXModelTableViewController *tvController = fromSectionInfo.modelTableViewController;
    
    [fromSectionInfo removeCellInfo:self.cellInfoFrom animated:NO];
    [toSectionInfo removeCellInfo:self.cellInfoTo animated:NO];
    [toSectionInfo insertCellInfo:self.cellInfoTo atIndex:toCellIndex animateWithStyle:UITableViewRowAnimationNone];
	
	[self performSelector:@selector(delayedFinishTransition) withObject:nil afterDelay:0.3];
	
	[self release];
}

@end
