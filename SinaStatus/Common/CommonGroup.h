//
//  CommonGroup.h
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/18.
//  Copyright (c) 2015年 XLP. All rights reserved.
//  tableView section对象 （组头,组尾，每行的item）

#import <Foundation/Foundation.h>
@class CommonItem;

@interface CommonGroup : NSObject
/**
 *  组头
 */
@property (nonatomic, strong) NSString *groupHeader;
/**
 *  组尾
 */
@property (nonatomic, strong) NSString *groupFooter;

/**
 *   这组的所有行模型(数组中存放的都是CommonItem模型)
 */
@property (nonatomic, strong) NSArray *itemsArray;

+ (instancetype) group;

@end
