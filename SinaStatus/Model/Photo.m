//
//  Photo.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/13.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (void)setThumbnail_pic:(NSString *)thumbnail_pic
{
    _thumbnail_pic = thumbnail_pic;
    self.bmiddle_pic = [thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}

@end
