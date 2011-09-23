//
//  YXStaticValueCell.h
//  YandexMaps
//
//  Created by Mikhail Kalugin on 6/29/10.
//  Copyright 2010 Yandex. All rights reserved.
//

UIKIT_EXTERN NSString *const YXTitleValueCellInfoDefaultReuseIdentidier;

#import <Foundation/Foundation.h>
#import "YXCellInfo.h"

@interface YXTitleValueCellInfo : YXCellInfo {
    NSString *_title;
	NSString *_value;
    id _target;
    SEL _action;
}
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;

+ (id)cellWithTitle:(NSString *)title 
              value:(NSString *)value
             target:(id)target
             action:(SEL)action;

+ (id)cellWithTitle:(NSString *)title 
              value:(NSString *)value;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                        title:(NSString *)title 
                        value:(NSString *)value
                       target:(id)target
                       action:(SEL)action;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                        title:(NSString *)title 
                        value:(NSString *)value;


@end
