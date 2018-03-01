//
//  CommonItem.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/18.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import "CommonItem.h"

@implementation CommonItem

/**
 *  tableViewCell 每行的样式
 *  @param title    cell标题
 *  @param subTitle cell子标题
 *  @param icon     cell头像
 */
+ (instancetype) itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle icon:(NSString *)icon
{
    CommonItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    item.subTitle = subTitle;
    return item;
}

/**
 *  tableViewCell 每行的样式
 *  @param title    cell标题
 *  @param subTitle cell子标题
 */
+ (instancetype) itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle
{
    return [self itemWithTitle:title subTitle:subTitle icon:nil];
}

/**
 *  tableViewCell 每行的样式
 *  @param title    cell标题
 *  @param icon     cell头像
 */
+ (instancetype) itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    return [self itemWithTitle:title subTitle:nil icon:icon];
}


/**
 *  tableViewCell 每行的样式
 *  @param title    cell标题
 *  @param icon     cell头像
 */
+ (instancetype) itemWithTitle:(NSString *)title
{
    return [self itemWithTitle:title subTitle:nil icon:nil];
}

@end
