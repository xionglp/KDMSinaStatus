//
//  ComPhotosView.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/15.
//  Copyright (c) 2015年 XLP. All rights reserved.
//  发布微博，选择图片的一个图片集（相册）

#import "ComPhotosView.h"

@implementation ComPhotosView

- (void) addImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    imageView.image = image;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int margin = 10;
    int maxCountPerRow = 4;
    NSInteger imageCount = self.subviews.count;
    for (int i = 0; i < imageCount; i++) {
        //行号
        NSInteger row = i / maxCountPerRow;
        //列号
        int col = i % maxCountPerRow;
        
        UIImageView *imageView = self.subviews[i];
        imageView.width = (self.width - (maxCountPerRow + 1) * margin) / maxCountPerRow;
        imageView.height = imageView.width;
        imageView.x = margin + (margin + imageView.width) * col;
        imageView.y = (margin + imageView.height) * row;
    }
}

- (NSArray *) images
{
    NSMutableArray *array = [NSMutableArray array];
    for (UIImageView *imageView in self.subviews) {
        [array addObject:imageView.image];
    }
    return array;
}

@end
