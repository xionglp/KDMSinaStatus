//
//  UIImage+Estension.h
//  SinaStatus
//
//  Created by 熊鲁平 on 15/7/30.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Estension)
/**
 *  设置可以随意拉伸图片不变形
 *  @param nameImage 图片名称
 */
+ (UIImage *)resizableImage:(NSString *)nameImage;

@end
