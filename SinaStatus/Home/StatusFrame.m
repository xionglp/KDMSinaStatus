//
//  StatusFrame.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/16.
//  Copyright (c) 2015年 XLP. All rights reserved.
//  微博frame对象

#import "StatusFrame.h"
#import "Status.h"
#import "User.h"
#import "NSString+TextFrame.h"
#import "StatusPhotosView.h"

@implementation StatusFrame

- (void)setStatus:(Status *)status
{
    _status = status;
    
    //计算原创微博的frame
    [self setOriginalStatusFrame:status];
    
    //计算转发微博的frame
    [self setRetweetStatusFrame:status];
    
    //计算微博详情的frame
    if (status.retweeted_status) {
        self.detailViewFrame = CGRectMake(0, 10, ScreenW, CGRectGetMaxY(self.retweetViewFrame));
    }else{
        self.detailViewFrame = CGRectMake(0, 10, ScreenW, CGRectGetMaxY(self.originalViewFrame));
    }
    
    //计算微博工具条的frame
    self.statusToolFrame = CGRectMake(0, CGRectGetMaxY(self.detailViewFrame), ScreenW, 40);
    
    //计算cell的高度
    self.cellHeight = CGRectGetMaxY(self.statusToolFrame);
}

- (void) setOriginalStatusFrame:(Status *)status
{
    //头像
    self.originalIconFrame = CGRectMake(StatusCellInset, StatusCellInset, 35, 35);
    
    // 2.昵称
    CGFloat nameX = CGRectGetMaxX(self.originalIconFrame) + StatusCellInset;
    CGFloat nameY = StatusCellInset;
    CGSize nameSize = [NSString sizeWithText:status.user.name font:StatusOrginalNameFont maxSize:CGSizeMake(ScreenW - nameX, 30)];
    self.originalNameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    //vip图标
    if (status.user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.originalNameFrame) + StatusCellInset;
        CGFloat vipY = nameY;
        self.originalVipFrame = CGRectMake(vipX, vipY, nameSize.height, nameSize.height);
    }
    
    // 3.时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.originalNameFrame) + StatusCellInset * 0.5;
    CGSize timeSize = [NSString sizeWithText:status.created_at font:StatusOrginalTimeFont maxSize:CGSizeMake(ScreenW, 30)];
    self.originalTimeFrame = (CGRect){{timeX, timeY}, timeSize};
    
    // 4.来源
    CGFloat sourceX = CGRectGetMaxX(self.originalTimeFrame) + StatusCellInset * 0.5;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [NSString sizeWithText:status.source font:StatusOrginalSourceFont maxSize:CGSizeMake(ScreenW, 30)];
    self.originalSourceFrame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    // 5.正文
    CGFloat textX = StatusCellInset;
    CGFloat textY = CGRectGetMaxY(self.originalIconFrame) + StatusCellInset;
    CGFloat maxW = ScreenW - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [NSString sizeWithText:status.text font:StatusOrginalTextFont maxSize:maxSize];
    self.originalTextFrame = (CGRect){{textX, textY}, textSize};
    
    //配图相册
    if (status.pic_urls.count) {
        CGFloat photoX = textX;
        CGFloat photoY = CGRectGetMaxY(self.originalTextFrame) + StatusCellInset;
        CGSize photoSize = [StatusPhotosView sizeWithPhotosCount:status.pic_urls.count];
        self.originalPhotosFrame = CGRectMake(photoX, photoY, photoSize.width, photoSize.height);
    }
    
    // 自己
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = ScreenW;
    CGFloat h;
    if (status.pic_urls.count) {
        h = CGRectGetMaxY(self.originalPhotosFrame) + StatusCellInset;
    }else{
        h = CGRectGetMaxY(self.originalTextFrame) + StatusCellInset;
    }
    self.originalViewFrame = CGRectMake(x, y, w, h);
}

- (void) setRetweetStatusFrame:(Status *)status
{
    // 1.昵称
    CGFloat nameX = StatusCellInset;
    CGFloat nameY = StatusCellInset * 0.5;
    NSString *nameStr = [NSString stringWithFormat:@"@%@",status.retweeted_status.user.name];
    CGSize nameSize = [NSString sizeWithText:nameStr font:StatusRetweetedNameFont maxSize:CGSizeMake(ScreenW - 2 * StatusCellInset, 30)];
    self.retweetNameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    // 2.正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(self.retweetNameFrame) + StatusCellInset * 0.5;
    CGFloat maxW = ScreenW - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [NSString sizeWithText:status.retweeted_status.text font:StatusRetweetedTextFont maxSize:maxSize];
    self.retweetTextFrame = (CGRect){{textX, textY}, textSize};
    
    if (status.retweeted_status.pic_urls.count) {
        CGFloat photoX = textX;
        CGFloat photoY = CGRectGetMaxY(self.retweetTextFrame) + StatusCellInset;
        CGSize photoSize = [StatusPhotosView sizeWithPhotosCount:status.retweeted_status.pic_urls.count];
        self.retweetPhotosFrame = CGRectMake(photoX, photoY, photoSize.width, photoSize.height);
    }
    
    // 自己
    CGFloat x = 0;
    CGFloat y = CGRectGetMaxY(self.originalViewFrame); // 高度 = 原创微博最大的Y值
    CGFloat w = ScreenW;
    CGFloat h = 0;
    if (status.retweeted_status) {
        if (status.retweeted_status.pic_urls.count) {
            h = CGRectGetMaxY(self.retweetPhotosFrame) + StatusCellInset;
        }else{
            h = CGRectGetMaxY(self.retweetTextFrame) + StatusCellInset;
        }
    }else{
        h = 0;
    }
    self.retweetViewFrame = CGRectMake(x, y, w, h);
}

@end
