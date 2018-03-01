//
//  BadgeValueView.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/18.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import "BadgeValueView.h"
#import "NSString+TextFrame.h"

@implementation BadgeValueView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setBackgroundImage:[UIImage resizableImage:@"main_badge"] forState:UIControlStateNormal];
        self.height = self.currentBackgroundImage.size.height;
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    [self setTitle:badgeValue forState:UIControlStateNormal];
    
    //根据文字的长短，和尺寸计算按钮的大小
    CGSize textSize = [NSString sizeWithText:badgeValue font:self.titleLabel.font maxSize:CGSizeMake(50, 20)];
    
    CGFloat bgImageW = self.currentBackgroundImage.size.width;
    if (textSize.width < bgImageW) {
        self.width = bgImageW;
    }else{
        self.width = textSize.width + 10;
    }
}

@end
