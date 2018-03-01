//
//  StatusUnRead.h
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/16.
//  Copyright (c) 2015年 XLP. All rights reserved.
//
/*	follower = 0,
mention_cmt = 0,
status = 0,
chat_group_client = 0,
all_mention_status = 0,
chat_group_notice = 0,
attention_mention_cmt = 0,
invite = 0,
badge = 0,
all_mention_cmt = 0,
all_follower = 0,
all_cmt = 0,
mention_status = 0,
group = 0,
page_friends_to_me = 0,
attention_follower = 0,
notice = 0,
cmt = 0,
chat_group_pc = 0,
attention_cmt = 0,
attention_mention_status = 0,
photo = 0,
dm = 0
 */

#import <Foundation/Foundation.h>

@interface StatusUnRead : NSObject
/**
 *  新微博未读数
 */
@property (nonatomic, assign) int status;

/**
 *  新粉丝数
 */
@property (nonatomic, assign) int follower;

/**
 *  新评论数
 */
@property (nonatomic, assign) int cmt;

/**
 *  新私信数
 */
@property (nonatomic, assign) int dm;

/**
 *  新提及我的微博数
 */
@property (nonatomic, assign) int mention_cmt;

/**
 *  新提及我的评论数
 */
@property (nonatomic, assign) int mention_status;

/**
 *  消息未读数 （cmt+dm+mention_cmt+mention_status）
 */
- (int) messageCount;
/**
 *  总的未读数 
 */
- (int) totalCount;

@end
