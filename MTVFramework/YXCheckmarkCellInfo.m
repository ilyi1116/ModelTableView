//
//  YXCheckmarkCell.m
//  YandexMaps
//
//  Created by Roman Busyghin on 5/17/10.
//  Copyright 2010 Яндекс. All rights reserved.
//

#import "YXCheckmarkCellInfo.h"
#import "YXCheckmarkCellGroupInfo.h"
#import "YXKVOCheckmarkCellGroupInfo.h"
#import "YXModelTableViewController.h"
#import "YXStyleInfo.h"

NSString *const YXCheckmarkCellInfoDefaultReuseIdentidier = @"YXCheckmarkCellInfoDefaultReuseIdentidier";

@interface YXCheckmarkCellInfo ()

- (UIImage *)checkmarkImageForBool:(BOOL)flag;
- (BOOL)boolForImage:(UIImage *)accessoryImage;
- (BOOL)delegateAllowsToChangeTo:(BOOL)newValue;

@end

@implementation YXCheckmarkCellInfo

@synthesize title = _title;
@synthesize image = _image;

@synthesize delegate = _delegate;
@synthesize initialValueGetter = _initialValueGetter;
@synthesize changeHandler = _changeHandler;
@synthesize shouldChangeHandler = _shouldChangeHandler;

+ (NSString *)defaultReuseIdentifier {
    return YXCheckmarkCellInfoDefaultReuseIdentidier;
}

- (void)dealloc {
	self.title = nil;
	self.image = nil;

	[super dealloc];
}

+ (id)cellWitTitle:(NSString *)title
             image:(UIImage *)image
      withDelegate:(id)delegate 
initialValueGetter:(SEL)initialValueGetter 
     changeHandler:(SEL)changeHandler {
    return [self cellWithReuseIdentifier:[self defaultReuseIdentifier]
                                   title:title
                                   image:image 
                            withDelegate:delegate
                      initialValueGetter:initialValueGetter
                           changeHandler:changeHandler];
}

+ (id)cellWithReuseIdentifier:(NSString*)reuseIdentifier 
						title:(NSString*)title
						image:(UIImage *)image
				 withDelegate:(id)delegate 
		   initialValueGetter:(SEL)initialValueGetter 
				changeHandler:(SEL)changeHandler {
	NSAssert(delegate != nil, @"");
	NSAssert([delegate respondsToSelector:initialValueGetter], @"");
	NSAssert([delegate respondsToSelector:changeHandler], @"");
	
	YXCheckmarkCellInfo * cell = [[self alloc] initWithReuseIdentifier:reuseIdentifier];
	cell.title = title;
	cell.image = image;
	cell.delegate = delegate;
	cell.initialValueGetter = initialValueGetter;
	cell.changeHandler = changeHandler;
	cell.selectionStyle = YXCellInfoSelectionStyleNone;
	
	return [cell autorelease];
}

+ (id)cellWithTitle:(NSString *)title
              image:(UIImage *)image
              group:(YXCheckmarkCellGroupInfo *)group
           selected:(BOOL)selected {
    return [self cellWithReuseIdentifier:[self defaultReuseIdentifier]
                                   title:title 
                                   image:image 
                                   group:group 
                                selected:selected];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
						title:(NSString *)title
						image:(UIImage *)image
						group:(YXCheckmarkCellGroupInfo *)group
					 selected:(BOOL)selected
{
	YXCheckmarkCellInfo *cell = [[self alloc] initWithReuseIdentifier:reuseIdentifier];
	cell.title = title;
	cell.image = image;
    cell.selectionStyle = YXCellInfoSelectionStyleNone;
	
    if ([group isKindOfClass:[YXKVOCheckmarkCellGroupInfo class]]) {
        [(YXKVOCheckmarkCellGroupInfo *)group addCheckmarkCellInfo:cell];
    }
    else {
     	[group addCheckmarkCellInfo:cell setSelected:selected];   
    }
	
	return [cell autorelease];
}

- (UITableViewCell *)tableViewCell {
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.reuseIdentifier] autorelease];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
	UIImageView *checkmarkImageView = [[[UIImageView alloc] init] autorelease];
	[cell setAccessoryView:checkmarkImageView];
	
    return cell;
}

- (void)configureCell:(UITableViewCell *)reusableCell {
    [super configureCell:reusableCell];
    
   	reusableCell.textLabel.text = self.title;
	reusableCell.imageView.image = self.image;
	
	NSNumber *boolNumber = [self.delegate performSelector:_initialValueGetter withObject:self];
    
    if ([boolNumber boolValue]) {
        [[reusableCell textLabel] setTextColor:[UIColor colorWithRed:50.0f/255.0f green:79.0f/255.0f blue:133.0f/255.0f alpha:1.0f]];
    }
    else {
        [[reusableCell textLabel] setTextColor:[UIColor blackColor]];
    }
	
	UIImageView *checkmarkImageView = (UIImageView *)reusableCell.accessoryView;
	UIImage *checkmarkImage = [self checkmarkImageForBool:[boolNumber boolValue]];
	[checkmarkImageView setImage:checkmarkImage];
	[checkmarkImageView sizeToFit];
	[reusableCell setNeedsLayout];
}

- (void)applyStyleForCell:(UITableViewCell *)cell {
	[super applyStyleForCell:cell];
	
	UIImageView *checkmarkImageView = (UIImageView *)cell.accessoryView;
	
	[checkmarkImageView setHighlightedImage:self.styleInfo.checkmarkCellIndicatorImageHighlighted];
	[cell setNeedsLayout];
	
	if (checkmarkImageView.image != nil) {
		cell.textLabel.textColor = self.styleInfo.checkmarkCellCheckedTextColor;; 
	}
	else {
		cell.textLabel.textColor = self.styleInfo.cellDefaultTextColor;
	}

}

- (void)tableView:(UITableView *)tableView didSelectCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectCell:cell atIndexPath:indexPath];
    
	UIImageView *checkmarkImageView = (UIImageView *)cell.accessoryView;
	
	BOOL previousValue = [self boolForImage:checkmarkImageView.image];
	BOOL newValue = !previousValue;

	BOOL shouldUpdate = [self delegateAllowsToChangeTo:newValue];
	if (shouldUpdate) {	
		[checkmarkImageView setImage:[self checkmarkImageForBool:newValue]];
		[cell setNeedsLayout];
		
		[_delegate performSelector:_changeHandler 
						withObject:self 
						withObject:[NSNumber numberWithBool:newValue]];	
	}
}

- (UIImage *)checkmarkImageForBool:(BOOL)flag {
	if (flag) {
		return self.styleInfo.checkmarkCellIndicatorImage;
	}
	else {
		return nil;
	}
}

- (BOOL)boolForImage:(UIImage *)accessoryImage {
	if (accessoryImage == nil) {
		return NO;
	}
	else {
		return YES;
	}
}

- (BOOL)delegateAllowsToChangeTo:(BOOL)newValue {
	if (![self.delegate respondsToSelector:self.shouldChangeHandler]) {
		return YES;
	}
	NSNumber *boolNumber = [NSNumber numberWithBool:newValue];
    BOOL isAllows = [[self.delegate performSelector:self.shouldChangeHandler withObject:self withObject:boolNumber] boolValue];
	return isAllows;
}

@end
