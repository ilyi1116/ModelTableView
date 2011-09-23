//
//  YXKVOSegmentedCellInfo.h
//  ModelTableViewFramework
//
//  Created by Vladislav Alekseev on 10.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXSegmentedCellInfo.h"

@interface YXKVOSegmentedCellInfo : YXSegmentedCellInfo {
    id _object;
    NSString *_key;
}
@property (nonatomic, retain) id object;
@property (nonatomic, copy) NSString *key;

+ (id)cellObservingObject:(id)object
                   forKey:(NSString *)key
             segmentItems:(NSArray *)items;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier 
                observeObject:(id)object
                       forKey:(NSString *)key
                 segmentItems:(NSArray *)items;

@end
