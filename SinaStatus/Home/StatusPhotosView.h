//
//  StatusPhotosView.h
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/17.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusPhotosView : UIView

@property (nonatomic, strong) NSArray *photoArray;

/**
 *  根据图片的个数，返回相册的尺寸
 */
+ (CGSize) sizeWithPhotosCount:(NSUInteger)photosCount;

@end
