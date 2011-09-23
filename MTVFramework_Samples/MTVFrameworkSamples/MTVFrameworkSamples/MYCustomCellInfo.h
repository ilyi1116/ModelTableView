//
//  MYCustomCellInfo.h
//  ModelTableViewFramework
//
//  Created by Vladislav Alekseev on 10.05.11.
//  Copyright 2011 Yandex. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MYCustomCellInfo : YXCustomCellInfo {
    NSUInteger someNumberToDisplay;
}
@property (nonatomic, assign) NSUInteger someNumberToDisplay;

@end
