//
//  UIImage+Estension.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/7/30.
//  Copyright (c) 2015年 XLP. All rights reserved.
// 设置可以随意拉伸图片不变形

#import "UIImage+Estension.h"

@implementation UIImage (Estension)
/**
 *  设置可以随意拉伸图片不变形
 *  @param nameImage 图片名称
 */
+ (UIImage *)resizableImage:(NSString *)nameImage
{
    UIImage *nomal = [UIImage imageNamed:nameImage];
    CGFloat w = nomal.size.width * 0.5;
    CGFloat H = nomal.size.height * 0.5;
    return [nomal resizableImageWithCapInsets:UIEdgeInsetsMake(H, w, H, w) resizingMode:UIImageResizingModeStretch];
}

@end
