//
//  YXDetailDisclosureCell.h
//  ModelTableViewFramework
//
//  Created by Vladislav Alekseev on 04.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

UIKIT_EXTERN NSString *const YXDetailDisclosureCellInfoDefaultReuseIdentidier;

#import <Foundation/Foundation.h>
#import "YXDisclosureCellInfo.h"

@interface YXDetailDisclosureCellInfo : YXDisclosureCellInfo {
    NSString *_detailText;
}
@property (nonatomic, copy) NSString *detailText;

+ (id)cellWithReuseTitle:(NSString *)title 
              detailText:(NSString *)detailText
                  target:(id)target 
                  action:(SEL)action;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                        title:(NSString *)title 
                   detailText:(NSString *)detailText
                       target:(id)target 
                       action:(SEL)action;

@end
