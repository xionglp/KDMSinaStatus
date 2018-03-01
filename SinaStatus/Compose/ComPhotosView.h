//
//  ComPhotosView.h
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/15.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComPhotosView : UIView

/**
 *  将图片加到图片集中
 *  @param image 相册中选择的图片
 */
- (void) addImage:(UIImage *)image;

/**
 *  返回图片的个数
 */
- (NSArray *)images;

@end
