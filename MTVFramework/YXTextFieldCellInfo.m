//
//  YXEditableCell.m
//  YandexMaps
//
//  Created by Roman Busyghin on 7/23/10.
//  Copyright 2010 Яндекс. All rights reserved.
//

NSString *const YXTextFieldCellInfoDefaultReuseIdentidier = @"YXTextFieldCellInfoDefaultReuseIdentidier";

#import "YXTextFieldCellInfo.h"
#import "YXEditableTableViewCell.h"
#import "YXModelTableViewController.h"

#import "YXStyleInfo.h"

@implementation YXTextFieldCellInfo

@synthesize target = _target;
@synthesize action = _action;
@synthesize initialValueSelector = _initialValueSelector;
@synthesize placeholder = _placeholder;
@synthesize title = _title;
@synthesize value = _value;
@synthesize keyboardType = _keyboardType;
@synthesize autocapitalizationType = _autocapitalizationType;
@synthesize clearButtonMode = _clearButtonMode;

+ (NSString *)defaultReuseIdentifier {
    return YXTextFieldCellInfoDefaultReuseIdentidier;
}

+ (id)cellWithTitle:(NSString *)title 
              value:(NSString *)value 
        placeholder:(NSString *)placeholder 
             target:(id)target 
             action:(SEL)action 
initialValueSelector:(SEL)initialValueSelector {
    return [self cellWithReuseIdentifier:[self defaultReuseIdentifier]
                                   title:title
                                   value:value
                             placeholder:placeholder
                                  target:target
                                  action:action
                    initialValueSelector:initialValueSelector];
}

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
						title:(NSString *)title
						value:(NSString *)value
				  placeholder:(NSString *)placeholder
                       target:(id)target
                       action:(SEL)action 
         initialValueSelector:(SEL)initialValueSelector {
    YXTextFieldCellInfo * cell = [[YXTextFieldCellInfo alloc] initWithReuseIdentifier:reuseIdentifier];
	
	cell.target = target;
	cell.action = action;
    cell.initialValueSelector = initialValueSelector;
	cell.title = title;
	cell.value = value;
	cell.placeholder = placeholder;
    cell.clearButtonMode = UITextFieldViewModeWhileEditing;
	//cell.selectionStyle = YXCellInfoSelectionStyleNone;
    
    [cell addObserver:cell forKeyPath:@"title" options:0 context:nil];
    [cell addObserver:cell forKeyPath:@"placeholder" options:0 context:nil];
    [cell addObserver:cell forKeyPath:@"value" options:0 context:nil];
    [cell addObserver:cell forKeyPath:@"keyboardType" options:0 context:nil];
    [cell addObserver:cell forKeyPath:@"autocapitalizationType" options:0 context:nil];
    [cell addObserver:cell forKeyPath:@"clearButtonMode" options:0 context:nil];
	
	return [cell autorelease];
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"title"];
    [self removeObserver:self forKeyPath:@"placeholder"];
    [self removeObserver:self forKeyPath:@"value"];
    [self removeObserver:self forKeyPath:@"keyboardType"];
    [self removeObserver:self forKeyPath:@"autocapitalizationType"];
    [self removeObserver:self forKeyPath:@"clearButtonMode"];
    
	[_placeholder release];
	[_title release];
	
	_target = nil;
	_action = NULL;
    _initialValueSelector = NULL;
	
	[super dealloc];
}

- (UITableViewCell *)tableViewCell {
    return [[[YXEditableTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:self.reuseIdentifier] autorelease];
}

- (void)configureCell:(UITableViewCell *)reusableCell {
    [super configureCell:reusableCell];
    
    YXEditableTableViewCell *cell = (YXEditableTableViewCell *)reusableCell;
    
    NSString *currentValue = self.value;
    if (_initialValueSelector != NULL) {
        currentValue = [_target performSelector:_initialValueSelector withObject:self];
    }
	
	cell.valueSuffix = self.title;
	cell.textValue = currentValue;
	cell.autocapitalizationType = self.autocapitalizationType;
	cell.keyboardType = self.keyboardType;
	cell.placeholder = self.placeholder;
	cell.target = self;
	cell.action = @selector(textDidChange:);
    cell.clearButtonMode = self.clearButtonMode;
}

- (void)applyStyleForCell:(UITableViewCell *)cell {
	[super applyStyleForCell:cell];
	
	YXEditableTableViewCell *editableCell = (YXEditableTableViewCell *)cell;
	
	[[editableCell label] setFont:self.styleInfo.editableCellTextFont];
	[[editableCell label] setTextColor:self.styleInfo.editableCellTextColor];
	[[editableCell label] setHighlightedTextColor:self.styleInfo.editableCellHighlightedTextColor];
	
	[[editableCell textField] setFont:self.styleInfo.editableCellTextFieldFont];
	[[editableCell textField] setTextColor:self.styleInfo.editableCellTextFieldColor];
	
	YXModelTableViewController *controller = [[self sectionInfo] modelTableViewController];
	if (_recessed && [controller tableViewStyle] == UITableViewStylePlain) {
		[[editableCell label] setShadowColor:[UIColor whiteColor]];
		[[editableCell label] setShadowOffset:CGSizeMake(0, 1)];
		[[editableCell label] setOpaque:NO];
		[[editableCell label] setBackgroundColor:[UIColor clearColor]];
		
		[cell setBackgroundView:[[[UIImageView alloc] initWithImage:[YXCellInfo recessedBoundsImage]] autorelease]];
	}
	else {
		[[editableCell label] setShadowColor:nil];
		[[editableCell label] setBackgroundColor:[UIColor clearColor]];
		if ([controller tableViewStyle] == UITableViewStylePlain) {
			[cell setBackgroundView:nil];	
		}
	}

}

- (void)textDidChange:(UITextField *)textField {
    NSString *newValue = [textField text];
	[self.target performSelector:self.action withObject:self withObject:newValue];
}

- (void)tableView:(UITableView *)tableView didSelectCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    YXEditableTableViewCell *selectedCell = (YXEditableTableViewCell *)cell;
    [selectedCell presentKeyboard];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self) {
        // this is notification that one of our properties changed
        [self updateCellAppearenceAnimated:NO];
    }
}

@end
