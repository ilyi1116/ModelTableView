//
//  YXDisclosureCell.h
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

UIKIT_EXTERN NSString *const YXDisclosureCellInfoDefaultReuseIdentidier;

#import <Foundation/Foundation.h>
#import "YXCellInfo.h"

@interface YXDisclosureCellInfo : YXCellInfo {
	NSString * _title;
	id _target;
	SEL _action;
}

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;

+ (id)cellWithTitle:(NSString *)title 
             target:(id)target 
             action:(SEL)action;

// selector is a method like - (void)disclosureTapped:(YXDisclosureCell*)cell;
+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                        title:(NSString *)title 
                       target:(id)target 
                       action:(SEL)action;

@end
