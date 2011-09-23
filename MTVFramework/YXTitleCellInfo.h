//
//  YXTitleCellInfo.h
//  YandexFoundation
//
//  Created by Ruslan Sokolov on 7/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXTitleValueCellInfo.h"

UIKIT_EXTERN NSString *const YXTitleCellInfoDefaultReuseIdentidier;

@interface YXTitleCellInfo : YXTitleValueCellInfo {
    
}

+ (id)cellWithTitle:(NSString *)title;

@end
