//
//  YXCheckmarkCell.h
//  YandexMaps
//
//  Created by Roman Busyghin on 5/17/10.
//  Copyright 2010 Яндекс. All rights reserved.
//

UIKIT_EXTERN NSString *const YXCheckmarkCellInfoDefaultReuseIdentidier;

#import "YXCellInfo.h"

@class YXCheckmarkCellGroupInfo;

/**
 YXCheckmarkCellInfo represents cell that can be selected and deselected. When selected, checkmark appears as accessoryType. When deselected, nothing displayed. YXCheckmarkCellInfo objects can be used together with YXCheckmarkCellGroupInfo groups or YXKVOCheckmarkCellGroupInfo groups to implement group-switching behaviour.
 */

@interface YXCheckmarkCellInfo : YXCellInfo {
	NSString * _title;
	UIImage * _image;
	
	id _delegate;
	SEL _initialValueGetter;
	SEL _changeHandler;
	SEL _shouldChangeHandler;
}
@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) UIImage *image;

/**
 Object that provides initial value, responds to value changes and checks if value can be changed.
 */
@property (nonatomic, assign) id delegate;

/**
 Using this method YXCheckmarkCellInfo gets it's initial value. Typical signature: 
 - (NSNumber *)valueForCheckmarkCellInfo:(YXCheckmarkCellInfo *)cellInfo;
 */
@property (nonatomic, assign) SEL initialValueGetter;

/**
 Asks delegate whether it allows the value to be changed. Typical signature: 
 - (NSNumber *)checkmarkCellInfo:(YXCheckmarkCellInfo *)cellInfo shouldChangeValueTo:(NSNumber *)newBoolValue;
 */
@property (nonatomic, assign) SEL shouldChangeHandler;

/**
 Provides to delegate new value. Typical signature: 
 - (NSNumber *)checkmarkCellInfo:(YXCheckmarkCellInfo *)cellInfo didChangeValueTo:(NSNumber *)newBoolValue;
 */
@property (nonatomic, assign) SEL changeHandler;

/**
 Creates and returns new autoreleased YXCheckmarkCellInfo object with given parameters using default cell identifier.
 @param title Cell title.
 @param image Cell image.
 @param delegate Object that provides initial value, responds to value changes and checks if value can be changed.
 @param initialValueGetter Using this method YXCheckmarkCellInfo gets it's initial value.
 @param changeHandler Provides new value to the delegate.
 */
+ (id)cellWitTitle:(NSString *)title
             image:(UIImage *)image
      withDelegate:(id)delegate 
initialValueGetter:(SEL)initialValueGetter 
     changeHandler:(SEL)changeHandler;

/**
 Creates and returns new autoreleased YXCheckmarkCellInfo object with given parameters.
 @param title Cell title.
 @param image Cell image.
 @param delegate Object that provides initial value, responds to value changes and checks if value can be changed.
 @param initialValueGetter Using this method YXCheckmarkCellInfo gets it's initial value.
 @param changeHandler Provides to delegate new value.
 */
+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
						title:(NSString *)title
						image:(UIImage *)image
				 withDelegate:(id)delegate 
		   initialValueGetter:(SEL)initialValueGetter 
				changeHandler:(SEL)changeHandler;

/**
 Use this method to create YXCheckmarkCellInfo with default reuse identifier and automatically add it into YXCheckmarkCellGroupInfo or YXKVOCheckmarkCellGroupInfo groups.
 @param title Cell title.
 @param image Cell image.
 @param group YXCheckmarkCellGroupInfo or YXKVOCheckmarkCellGroupInfo object into what cell will be added.
 @param selected Indicates whether should be this cell marked as selected. If you are adding Cell Info into YXKVOCheckmarkCellGroupInfo object, this parameter is ignored.
 */
+ (id)cellWithTitle:(NSString *)title
              image:(UIImage *)image
              group:(YXCheckmarkCellGroupInfo *)group
           selected:(BOOL)selected;

/**
 Use this method to fill up YXCheckmarkCellGroupInfo and YXKVOCheckmarkCellGroupInfo groups. This method will automatically add this Cell Info object into the group.
 @param title Cell title.
 @param image Cell image.
 @param group YXCheckmarkCellGroupInfo or YXKVOCheckmarkCellGroupInfo object into what cell will be added.
 @param selected Indicates whether should be this cell marked as selected. If you are adding Cell Info into YXKVOCheckmarkCellGroupInfo object, this parameter is ignored.
 */
+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
						title:(NSString *)title
						image:(UIImage *)image
						group:(YXCheckmarkCellGroupInfo *)group
					 selected:(BOOL)selected;

@end
