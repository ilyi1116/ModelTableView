//
//  UITableView+ExtendedAnimations.m
//  TableViewExtAnimations
//
//  Created by Алексеев Влад on 08.07.11.
//  Copyright 2011 beefon software. All rights reserved.
//

#import "UITableView+ExtendedAnimations.h"
#import <QuartzCore/QuartzCore.h>

typedef enum {
    YXCellInfoTransitionDirectionDown,
    YXCellInfoTransitionDirectionUp,
} YXCellInfoTransitionDirection;

#define kUITableViewExtendedAnimationsDuration 0.29f

CGFloat const kUITableViewEAScale = 0.9;

@implementation UITableView (YXExtendedAnimations)

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([(NSString *)context isEqualToString:@"UITableViewExtendedAnimationsContext"]) {
		if ([keyPath isEqualToString:@"superview"] && [change valueForKey:NSKeyValueChangeNewKey] == nil) {
			// cell was removed from superview by animation
			[self addSubview:(UITableViewCell *)object];
			[object removeObserver:self forKeyPath:@"superview"];
		}
	}
	else {
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}

#pragma mark -
#pragma mark Move Row

- (void)moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {

	UIView *backgroundDimView = [[UIView alloc] initWithFrame:self.bounds];
	[backgroundDimView setBackgroundColor:[UIColor blackColor]];
	[self addSubview:backgroundDimView];
	[backgroundDimView setAlpha:0.0];
	
	[UIView beginAnimations:@"dimContent" context:nil];
	[UIView setAnimationDuration:0.1];
	[backgroundDimView setAlpha:0.25];
	[UIView commitAnimations];
	
	UITableViewCell *managedCell = [[[self cellForRowAtIndexPath:fromIndexPath] retain] autorelease];
	
	[managedCell addObserver:self forKeyPath:@"superview" options:NSKeyValueObservingOptionNew context:@"UITableViewExtendedAnimationsContext"];
	
	CGRect cellSourceFrame = [self rectForRowAtIndexPath:fromIndexPath];
	CGRect cellTargetFrame = [self rectForRowAtIndexPath:toIndexPath];
	
	id datasource = self.dataSource;
	[datasource tableView:self moveCell:managedCell fromIndexPath:fromIndexPath toIndexPath:toIndexPath];
	
	[self beginUpdates];
	[self deleteRowsAtIndexPaths:[NSArray arrayWithObject:fromIndexPath] withRowAnimation:UITableViewRowAnimationTop];
	[self insertRowsAtIndexPaths:[NSArray arrayWithObject:toIndexPath] withRowAnimation:UITableViewRowAnimationBottom];
	[self endUpdates];
	
	UITableViewCell *insertedCell = [[[self cellForRowAtIndexPath:toIndexPath] retain] autorelease];
	
	CGRect insertedCellTargetRect = [insertedCell frame];
	
	managedCell.alpha = 1.0;
	
	[self bringSubviewToFront:insertedCell];
	[self bringSubviewToFront:managedCell];

	[managedCell setFrame:cellSourceFrame];
	[insertedCell setFrame:cellSourceFrame];
	
	[UIView beginAnimations:@"moveAnimation" context:nil];
	[UIView setAnimationDuration:kUITableViewExtendedAnimationsDuration];
	
	managedCell.alpha = 0.0;
	
	[managedCell setFrame:cellTargetFrame];
	[insertedCell setFrame:insertedCellTargetRect];
	
	[UIView commitAnimations];
	
	[UIView beginAnimations:@"undimContent" context:nil];
	[UIView setAnimationDuration:0.4];
	[UIView setAnimationDelay:kUITableViewExtendedAnimationsDuration];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(_undimAnimation:didStop:withDimView:)];
	[backgroundDimView setAlpha:0.0];
	[UIView commitAnimations];
}

#pragma mark -
#pragma mark Transit Row

- (void)transitRowAtIndexPath:(NSIndexPath *)fromIndexPath toRowIndexPath:(NSIndexPath *)toIndexPath {
	
	UIView *backgroundDimView = [[UIView alloc] initWithFrame:self.bounds];
	[backgroundDimView setBackgroundColor:[UIColor blackColor]];
	[self addSubview:backgroundDimView];
	[backgroundDimView setAlpha:0.0];
	
	[UIView beginAnimations:@"dimContent" context:nil];
	[UIView setAnimationDuration:0.15];
	[backgroundDimView setAlpha:0.35];
	[UIView commitAnimations];
	
	id datasource = self.dataSource;
	
	UITableViewCell *cellTransitionFrom = [[[self cellForRowAtIndexPath:fromIndexPath] retain] autorelease];
	
	[self bringSubviewToFront:cellTransitionFrom];
	
	CGRect sourceFrame = cellTransitionFrom.frame;
	
	[self beginUpdates];
	[datasource tableView:self transitionDeletedCellForRowAtIndexPath:fromIndexPath];
	[self deleteRowsAtIndexPaths:[NSArray arrayWithObject:fromIndexPath] withRowAnimation:UITableViewRowAnimationTop];
	[datasource tableView:self transitionInsertedCellForRowAtIndexPath:toIndexPath];
	[self insertRowsAtIndexPaths:[NSArray arrayWithObject:toIndexPath] withRowAnimation:UITableViewRowAnimationTop];
	[self endUpdates];
	
	UITableViewCell *cellTransitionTo = [[[self cellForRowAtIndexPath:toIndexPath] retain] autorelease];
	
	CGRect targetFrame;
	if (cellTransitionTo) {
		targetFrame = cellTransitionTo.frame;
	}
	else {
		targetFrame = [self rectForRowAtIndexPath:toIndexPath];
	}
	
	// both cells need to be moved from source cell to destination place
	// while moving we need to hide cell that we are moving, showing target cell
	
	[self bringSubviewToFront:cellTransitionTo];
	[self bringSubviewToFront:cellTransitionFrom];
	
	cellTransitionFrom.frame = sourceFrame;
	cellTransitionTo.frame = sourceFrame;
	
	[UIView beginAnimations:@"transitionAnimation" context:nil];
	[UIView setAnimationDuration:kUITableViewExtendedAnimationsDuration];
	
	CGPoint tableContentOffset = [self contentOffset];
	tableContentOffset.y += 1;
	[self setContentOffset:tableContentOffset];
	tableContentOffset.y -= 1;
	[self setContentOffset:tableContentOffset];
	
	cellTransitionFrom.frame = targetFrame;
	cellTransitionTo.frame = targetFrame;
	
	cellTransitionFrom.alpha = 0.0;
	
	[UIView commitAnimations];
	
	[UIView beginAnimations:@"undimContent" context:nil];
	[UIView setAnimationDuration:0.4];
	[UIView setAnimationDelay:kUITableViewExtendedAnimationsDuration - 0.1];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(_undimAnimation:didStop:withDimView:)];
	[backgroundDimView setAlpha:0.0];
	[UIView commitAnimations];
}

#pragma mark -
#pragma mark Exchange Row

- (void)exchangeRowAtIndexPath:(NSIndexPath *)indexPath1 withRowAtIndexPath:(NSIndexPath *)indexPath2 {
	CGRect cell1SourceFrame = [self rectForRowAtIndexPath:indexPath1];
	CGRect cell2SourceFrame = [self rectForRowAtIndexPath:indexPath2];
	
	UITableViewCell *cell1 = [self cellForRowAtIndexPath:indexPath1];
	UITableViewCell *cell2 = [self cellForRowAtIndexPath:indexPath2];
	
	UIView *backgroundDimView = [[UIView alloc] initWithFrame:self.bounds];
	[backgroundDimView setBackgroundColor:[UIColor blackColor]];
	[self addSubview:backgroundDimView];
	[backgroundDimView setAlpha:0.0];
	
	[UIView beginAnimations:@"dimContent" context:nil];
	[UIView setAnimationDuration:0.15];
	[backgroundDimView setAlpha:0.25];
	[UIView commitAnimations];
	
	id datasource = self.dataSource;
	[datasource tableView:self
			 exchangeCell:cell1 atIndexPath:indexPath1
				 withCell:cell2 atIndexPath:indexPath2];
	
	[cell1 setFrame:cell2SourceFrame];
	[cell2 setFrame:cell1SourceFrame];
	
	[self bringSubviewToFront:cell1];
	[self bringSubviewToFront:cell2];
	
	[UIView beginAnimations:@"exchangeAnimation" context:nil];
	[UIView setAnimationDuration:kUITableViewExtendedAnimationsDuration];
	
	[cell1 setFrame:cell1SourceFrame];
	[cell2 setFrame:cell2SourceFrame];
	
	[UIView commitAnimations];
	
	[UIView beginAnimations:@"undimContent" context:[backgroundDimView retain]];
	[UIView setAnimationDuration:0.4];
	[UIView setAnimationDelay:kUITableViewExtendedAnimationsDuration - 0.1];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(_undimAnimation:didStop:withDimView:)];
	[backgroundDimView setAlpha:0.0];
	[UIView commitAnimations];
}

- (void)_undimAnimation:(NSString *)animation didStop:(NSNumber *)stop withDimView:(UIView *)backgroundDimView {
	[backgroundDimView removeFromSuperview];
	[backgroundDimView release];
	
	[self reloadData];
	
	[self setNeedsLayout];
}

@end
