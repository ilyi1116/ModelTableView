//
//  YXCell.m
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXCellInfo.h"
#import "YXSectionInfo.h"
#import "YXStyleInfo.h"
#import "YXModelTableViewController.h"

@implementation YXCellInfo

@synthesize reuseIdentifier = _reuseIdentifier;
@synthesize userInfo = _userInfo;
@synthesize sectionInfo = _sectionInfo;
@synthesize rowHeight = _rowHeight;
@synthesize supportsSwipeToDelete = _supportsSwipeToDelete;
@synthesize allowsSelection = _allowsSelection;
@synthesize deselectsAutomatically = _deselectsAutomatically;
@synthesize recessed = _recessed;
@synthesize selectionStyle = _selectionStyle;
@synthesize styleInfo = _styleInfo;

+ (NSString *)defaultReuseIdentifier {
    @throw @"defaultReuseIdentifier: abstract method";
}

+ (UIImage *)recessedBoundsImage {
	CGSize imageSize = CGSizeMake(3.0, 3.0);
	
	UIGraphicsBeginImageContext(imageSize);
	
	CGContextRef currentContext = UIGraphicsGetCurrentContext();
	
	CGContextSetLineWidth(currentContext, 2.0);
	
	UIColor *topLineColor = [UIColor whiteColor];
	[topLineColor setStroke];
	CGContextMoveToPoint(currentContext, 0, 0);
	CGContextAddLineToPoint(currentContext, imageSize.width, 0);

	CGContextStrokePath(currentContext);
	
	UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	return [outputImage stretchableImageWithLeftCapWidth:1 topCapHeight:1];
}

- (void)dealloc {
	self.reuseIdentifier = nil;
	self.userInfo = nil;

	[super dealloc];
}

- (UITableViewCellSelectionStyle)_tableViewCellSelectionStyleForCellInfoSelectionStyle:(YXCellInfoSelectionStyle)style {
    if (style == YXCellInfoSelectionStyleBlue)
        return UITableViewCellSelectionStyleBlue;
    else if (style == YXCellInfoSelectionStyleGray)
        return UITableViewCellSelectionStyleGray;
    else if (style == YXCellInfoSelectionStyleNone)
        return UITableViewCellSelectionStyleNone;
    else if (style == YXCellInfoSelectionStyleInherited && (self.styleInfo))
        return self.styleInfo.cellSelectionStyle;

    return UITableViewCellSelectionStyleBlue;
}

- (id)init {
    self = [super init];
    
    if ([self class] == [YXCellInfo class]) { 
        NSLog(@"Error: attempting to instantiate YXCellInfo directly. You should use derived classes only."); 
        [self release]; 
        return nil; 
    }
    
	if (self) {
        _allowsSelection = YES;
        _deselectsAutomatically = YES;
        _selectionStyle = YXCellInfoSelectionStyleInherited;
		_recessed = NO;
	}
	return self;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super init];
    
    if ([self class] == [YXCellInfo class]) { 
        NSLog(@"Error: attempting to instantiate YXCellInfo directly. You should use derived classes only."); 
        [self release]; 
        return nil; 
    }
    
	if (self) {
		self.reuseIdentifier = reuseIdentifier;
        _allowsSelection = YES;
        _deselectsAutomatically = YES;
        _selectionStyle = YXCellInfoSelectionStyleInherited;
		_recessed = NO;
		_rowHeight = 45.0f;
	}
	return self;
}

- (void)setStyleInfo:(YXStyleInfo *)styleInfo {
    if (_styleInfo == styleInfo) 
        return;
    [_styleInfo release], _styleInfo = [styleInfo retain];
}

- (void)applyStyleForCell:(UITableViewCell *)cell {
    [cell setSelectionStyle:[self _tableViewCellSelectionStyleForCellInfoSelectionStyle:self.selectionStyle]];
    
    if (self.styleInfo) {
        cell.backgroundColor = self.styleInfo.cellBackgroundColor;
        
        cell.textLabel.font = self.styleInfo.cellDefaultTextFont;
        cell.textLabel.textColor = self.styleInfo.cellDefaultTextColor;
        cell.textLabel.highlightedTextColor = self.styleInfo.cellDefaultTextColorHighlighted;
    }
	
	YXModelTableViewController *controller = [[self sectionInfo] modelTableViewController];
	if (_recessed && [controller tableViewStyle] == UITableViewStylePlain) {
		[[cell textLabel] setShadowColor:[UIColor whiteColor]];
		[[cell textLabel] setShadowOffset:CGSizeMake(0, 1)];
		[[cell textLabel] setOpaque:NO];
		[[cell textLabel] setBackgroundColor:[UIColor clearColor]];
		
		[cell setBackgroundView:[[[UIImageView alloc] initWithImage:[YXCellInfo recessedBoundsImage]] autorelease]];
	}
}

- (void)configureCell:(UITableViewCell *)reusableCell {
    if ([self class] == [YXCellInfo class])
        @throw @"configureCell: abstract method";
    
    [self applyStyleForCell:reusableCell];
}

- (UITableViewCell *)tableViewCell  {
	@throw @"tableViewCell: abstract method";
}

- (void)updateCellAppearenceAnimated:(BOOL)animated {
    YXModelTableViewController *modelTableViewController = [_sectionInfo modelTableViewController];
    [modelTableViewController updateCellForCellInfo:self animated:animated];
}

- (BOOL)shouldUpdateCell:(UITableViewCell *)tableViewCell usingRowAnimation:(UITableViewRowAnimation)animationStyle {
    return YES;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [self applyStyleForCell:cell];
}

- (BOOL)tableView:(UITableView *)tableView willSelectCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if (_deselectsAutomatically) {
        [tableView deselectRowAtIndexPath:indexPath animated:_allowsSelection];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	
}

- (void)tableView:(UITableView *)tableView cellAccessoryButtonTapped:(UITableViewCell *)cell aIndexPath:(NSIndexPath *)indexPath {
    
}

@end
