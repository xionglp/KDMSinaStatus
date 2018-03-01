//
//  Status.h
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/13.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;

@interface Status : NSObject
/** string 微博创建时间*/
@property (nonatomic, copy) NSString *created_at;
/** string 字符串型的微博ID*/
@property (nonatomic, copy) NSString *idstr;
/** string 微博信息内容*/
@property (nonatomic, copy) NSString *text;
/** string 微博来源*/
@property (nonatomic, strong) NSString *source;
/** object 微博作者的用户信息字段 详细*/
@property (nonatomic, strong) User *user;
/** object 被转发的原微博信息字段，当该微博为转发微博时返回 详细*/
@property (nonatomic, strong) Status *retweeted_status;
/** int 转发数*/
@property (nonatomic, assign) int reposts_count;
/** int 评论数*/
@property (nonatomic, assign) int comments_count;
/** int 表态数*/
@property (nonatomic, assign) int attitudes_count;
/** object 微博配图地址。多图时返回多图链接。无配图返回“[]”  数组里面都是HMPhoto模型*/
@property (nonatomic, strong) NSArray *pic_urls;

@end
