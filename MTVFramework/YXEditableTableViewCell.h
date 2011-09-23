//
//  YXEditableViewCell.h
//  YandexMaps
//
//  Created by Roman Busyghin on 7/23/10.
//  Copyright 2010 Яндекс. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YXEditableTableViewCell : UITableViewCell <UITextFieldDelegate> {
@private
	UITextField * textField_;
	UILabel * valueSuffixLabel_;
	id target_;
	SEL action_;
	
	UITextAutocorrectionType autocorrectionType_;
	BOOL secureTextEntry_;
}

@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;
@property (nonatomic, retain) NSString * placeholder;
@property (nonatomic, retain) NSString * valueSuffix;
@property (nonatomic, retain) NSString * textValue;
@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, assign) UITextAutocapitalizationType autocapitalizationType;
@property (nonatomic, assign) UITextFieldViewMode clearButtonMode;

- (UITextField *)textField;
- (UILabel *)label;

- (void)presentKeyboard;
- (void)dismissKeyboard;

@end
