//
//  YXKVOTitleValueCell.h
//  ModelTableViewFramework
//
//  Created by Vladislav Alekseev on 06.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXTitleValueCellInfo.h"

@interface YXKVOTitleValueCellInfo : YXTitleValueCellInfo {
    id _titleObject;
    NSString *_titleKey;
    
    id _valueObject;
    NSString *_valueKey;
}
@property (nonatomic, retain) id titleObject;
@property (nonatomic, retain) id valueObject;

@property (nonatomic, copy) NSString *titleKey;
@property (nonatomic, copy) NSString *valueKey;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
        observeObjectForTitle:(id)titleObject
                       forKey:(NSString *)titleKey
        observeObjectForValue:(id)valueObject
                       forKey:(NSString *)valueKey;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
        observeObjectForTitle:(id)titleObject
                       forKey:(NSString *)titleKey
                  staticValue:(NSString *)value;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                  staticValye:(NSString *)title
        observeObjectForValue:(id)valueObject
                       forKey:(NSString *)valueKey;

@end
