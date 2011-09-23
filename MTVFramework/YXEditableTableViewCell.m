//
//  YXEditableViewCell.m
//  YandexMaps
//
//  Created by Roman Busyghin on 7/23/10.
//  Copyright 2010 Яндекс. All rights reserved.
//

#import "YXEditableTableViewCell.h"

@interface YXEditableTableViewCell ()

@property (nonatomic, retain) UITextField * textField;
@property (nonatomic, retain) UILabel * valueSuffixLabel;

@end


@implementation YXEditableTableViewCell

static const CGFloat kContentMargin = 10.0f;
static const CGFloat kTextFieldMargin = 8.0f;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])) {
		
		self.selectionStyle = UITableViewCellSelectionStyleNone;

		// TODO: Make these params customizable
		autocorrectionType_ = UITextAutocorrectionTypeDefault;
		secureTextEntry_ = NO;
		
        textField_ = [[UITextField alloc] initWithFrame:CGRectZero];
		textField_.delegate = self;
		textField_.font = [UIFont systemFontOfSize:17.0f];
		textField_.textColor = [UIColor blackColor];
		textField_.textAlignment = UITextAlignmentLeft;
		textField_.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		textField_.borderStyle = UITextBorderStyleNone;
		textField_.returnKeyType = UIReturnKeyDone;
		textField_.autocorrectionType = autocorrectionType_;
		textField_.secureTextEntry = secureTextEntry_;
		textField_.clearButtonMode = UITextFieldViewModeUnlessEditing;
		
		[self.contentView addSubview:textField_];
		
		valueSuffixLabel_ = [[UILabel alloc] initWithFrame:CGRectZero];
		valueSuffixLabel_.font = [UIFont boldSystemFontOfSize:17.0f];
		valueSuffixLabel_.textColor = [UIColor blackColor];
		valueSuffixLabel_.textAlignment = UITextAlignmentLeft;
		valueSuffixLabel_.backgroundColor = [UIColor clearColor];
		
		[self.contentView addSubview:valueSuffixLabel_];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(textFieldDidChange:)
													 name:UITextFieldTextDidChangeNotification
												   object:self.textField];
    }
    return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	CGFloat contentViewWidth = CGRectGetWidth(self.contentView.frame);
	CGFloat contentViewHeight = CGRectGetHeight(self.contentView.frame);
	
	CGRect labelFrame = self.valueSuffixLabel.frame;
	CGPoint textFieldOrigin = CGPointZero;
	
	if (CGRectEqualToRect(labelFrame, CGRectZero) == false) {
		CGFloat labelWidth = CGRectGetWidth(labelFrame);
		CGPoint labelOrigin = CGPointMake(kContentMargin, 0.0f);
		CGSize labelSize = CGSizeMake(labelWidth, contentViewHeight);
		
		labelFrame.origin = labelOrigin;
		labelFrame.size = labelSize;
		
		self.valueSuffixLabel.frame = labelFrame;
		textFieldOrigin = CGPointMake(CGRectGetMaxX(labelFrame) + kTextFieldMargin, 0.0f);
	}
	else {
		textFieldOrigin = CGPointMake(kContentMargin, 0.0f);
	}
	
	
	
	CGSize textFieldSize = CGSizeMake(contentViewWidth - CGRectGetMaxX(labelFrame) - kContentMargin,
									  contentViewHeight);
	CGRect textFieldFrame = self.textField.frame;
	
	textFieldFrame.origin = textFieldOrigin;
	textFieldFrame.size = textFieldSize;
	
	self.textField.frame = textFieldFrame;
}


#pragma mark -
#pragma mark Custom accessors


- (void)setPlaceholder:(NSString *)newPlaceholder {
	self.textField.placeholder = newPlaceholder;
	[self setNeedsLayout];
}

- (NSString *)placeholder {
	return self.textField.placeholder;
}

- (void)setValueSuffix:(NSString *)newValueSuffix {
	self.valueSuffixLabel.text = newValueSuffix;
	[self.valueSuffixLabel sizeToFit];
	
	[self setNeedsLayout];
}

- (NSString *)valueSuffix {
	return self.valueSuffixLabel.text;
}

- (void)setTextValue:(NSString *)newTextValue {
	self.textField.text = newTextValue;
	[self setNeedsLayout];
}

- (NSString *)textValue {
	return self.textField.text;
}

- (void)setKeyboardType:(UIKeyboardType)newKeyboardType {
	self.textField.keyboardType = newKeyboardType;
}

- (UIKeyboardType)keyboardType {
	return self.textField.keyboardType;
}

- (void)setAutocapitalizationType:(UITextAutocapitalizationType)newAutocapitalizationType {
	self.textField.autocapitalizationType = newAutocapitalizationType;
}

- (UITextAutocapitalizationType)autocapitalizationType {
	return self.textField.autocapitalizationType;
}

- (void)setClearButtonMode:(UITextFieldViewMode)clearButtonMode {
    self.textField.clearButtonMode = clearButtonMode;
}

- (UITextFieldViewMode)clearButtonMode {
    return self.textField.clearButtonMode;
}


#pragma mark -
#pragma mark Text field notifications & delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

- (void)textFieldDidChange:(NSNotification *)notification {
	[self.target performSelector:self.action withObject:self.textField];
}


#pragma mark -
#pragma mark Memory management


@synthesize valueSuffixLabel = valueSuffixLabel_;
@synthesize textField = textField_;
@synthesize target = target_;
@synthesize action = action_;
@synthesize autocapitalizationType = autocapitalizationType_;


- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UITextFieldTextDidChangeNotification
												  object:textField_];
	
	[valueSuffixLabel_ release];
	[textField_ release];
	
    [super dealloc];
}

- (void)presentKeyboard {
    [textField_ becomeFirstResponder];
}

- (void)dismissKeyboard {
    [textField_ resignFirstResponder];
}

- (UITextField *)textField {
	return textField_;
}

- (UILabel *)label {
	return valueSuffixLabel_;
}

@end
