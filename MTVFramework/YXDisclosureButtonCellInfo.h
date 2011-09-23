//
//  YXDisclosureButtonCellInfo.h
//  YandexFoundation
//
//  Created by Vladislav Alekseev on 11.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

UIKIT_EXTERN NSString *const YXDisclosureButtonCellInfoDefaultReuseIdentidier;

#import <Foundation/Foundation.h>
#import "YXDisclosureCellInfo.h"

@interface YXDisclosureButtonCellInfo : YXDisclosureCellInfo {
    SEL _disclosureAction;
}
@property (nonatomic, assign) SEL disclosureAction;

+ (id)cellWithTitle:(NSString *)title 
             target:(id)target 
             action:(SEL)action
   disclosureAction:(SEL)disclosureAction;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                        title:(NSString *)title 
                       target:(id)target 
                       action:(SEL)action
             disclosureAction:(SEL)disclosureAction;

@end
