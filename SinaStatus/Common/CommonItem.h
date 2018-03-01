//
//  CommonItem.h
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/18.
//  Copyright (c) 2015年 XLP. All rights reserved.
//  tableView row对象，（图标，标题，子标题，右边的样式）

#import <Foundation/Foundation.h>

@interface CommonItem : NSObject
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
/**
 * 提醒数字
 */
@property (nonatomic, strong) NSString *badgeValue;

/**
 *  点击cell需要跳转的目标控制器
 */
@property (nonatomic, assign) Class destVcClass;

/**
 *  点击cell需要做的事情
 */
@property (nonatomic, copy) void (^operation)();

/**
 *  cell 每一行的样式
 *
 *  @param title    cell 的标题
 *  @param subTitle cell 的子标题
 *  @param icon     cell 的头像
 *
 *  @return cell每一行的样式
 */
+ (instancetype) itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle icon:(NSString *)icon;

/**
 *  tableViewCell 每行的样式
 *  @param title    cell标题
 *  @param subTitle cell子标题
 */
+ (instancetype) itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle;


/**
 *  tableViewCell 每行的样式
 *  @param title    cell标题
 *  @param icon     cell头像
 */
+ (instancetype) itemWithTitle:(NSString *)title icon:(NSString *)icon;

/**
 *  tableViewCell 每行的样式
 *  @param title    cell标题
 *  @param icon     cell头像
 */
+ (instancetype) itemWithTitle:(NSString *)title;

@end
