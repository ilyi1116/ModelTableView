//
//  YXEditableCell.h
//  YandexMaps
//
//  Created by Roman Busyghin on 7/23/10.
//  Copyright 2010 Яндекс. All rights reserved.
//

#import "YXCellInfo.h"
#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const YXTextFieldCellInfoDefaultReuseIdentidier;

@interface YXTextFieldCellInfo : YXCellInfo {
@private
	id _target;
	SEL _action;
    SEL _initialValueSelector;
	
	NSString * _placeholder;
	NSString * _title;
	NSString * _value;
	UIKeyboardType _keyboardType;
	UITextAutocapitalizationType _autocapitalizationType;
    UITextFieldViewMode _clearButtonMode;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, assign) UITextAutocapitalizationType autocapitalizationType;
@property (nonatomic, assign) UITextFieldViewMode clearButtonMode;

@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;
@property (nonatomic, assign) SEL initialValueSelector;

// Sample signature looks like
// - (NSString *)initialValueForMyEditableCell:(YXEditableCell *)cell;
// - (void)myEditableCell:(YXEditableCell *)cell didUpdateValue:(NSString *)newValue;

+ (id)cellWithTitle:(NSString *)title 
              value:(NSString *)value 
        placeholder:(NSString *)placeholder 
             target:(id)target 
             action:(SEL)action 
initialValueSelector:(SEL)initialValueSelector;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
						title:(NSString *)title
						value:(NSString *)value
				  placeholder:(NSString *)placeholder
                       target:(id)target
                       action:(SEL)action 
         initialValueSelector:(SEL)initialValueSelector;

@end
