//
//  StatusFrame.h
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/16.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Status;

@interface StatusFrame : NSObject

@property (nonatomic, strong) Status *status;

/** 微博详情的frame */
@property (nonatomic, assign) CGRect detailViewFrame;
/** 微博底部工具条的frame */
@property (nonatomic, assign) CGRect statusToolFrame;
/** 原创微博的frame */
@property (nonatomic, assign) CGRect originalViewFrame;
/** 转发微博的frame */
@property (nonatomic, assign) CGRect retweetViewFrame;

/** 原创微博昵称的frame */
@property (nonatomic, assign) CGRect originalNameFrame;
/** 原创微博时间的frame */
@property (nonatomic, assign) CGRect originalTimeFrame;
/** 原创微博头像的frame */
@property (nonatomic, assign) CGRect originalIconFrame;
/** 原创微博来源的frame */
@property (nonatomic, assign) CGRect originalSourceFrame;
/** 原创微博正文的frame */
@property (nonatomic, assign) CGRect originalTextFrame;
/** 原创微博vip图标的frame */
@property (nonatomic, assign) CGRect originalVipFrame;
/** 原创微博图片集的frame */
@property (nonatomic, assign) CGRect originalPhotosFrame;

/** 转发微博昵称的frame */
@property (nonatomic, assign) CGRect retweetNameFrame;
/** 转发微博正文的frame */
@property (nonatomic, assign) CGRect retweetTextFrame;
/** 转发微博图片集的frame */
@property (nonatomic, assign) CGRect retweetPhotosFrame;

@property (nonatomic, assign) CGFloat cellHeight;

@end
