//
//  HomeNavigationTitleBtn.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/8/2.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import "HomeNavTitleBtn.h"

@implementation HomeNavTitleBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.imageView.contentMode = UIViewContentModeCenter;
        //adjusts 调整  当高亮的时候不改变图片样式
        self.adjustsImageWhenHighlighted = NO;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = NavBarTitleFont;
    }
    return self;
}

/**
 *  重新调整按钮内部图片的位置
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageW = contentRect.size.height;
    CGFloat imageH = contentRect.size.height;
    CGFloat imageX = self.width - contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

/**
 *  重新调整按钮内部文字的位置
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleH = contentRect.size.height;
    CGFloat titleW = self.width - titleH;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    CGSize textSize = [title sizeWithFont:NavBarTitleFont];
    self.width = textSize.width + self.height + 10;
}

@end
