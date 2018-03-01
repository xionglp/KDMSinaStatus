//
//  UIBarButtonItem+Estension.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/7/30.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import "UIBarButtonItem+Estension.h"

@implementation UIBarButtonItem (Estension)

//对UIbarBUttonItem做一个分类扩展，创建一个带有普通和高亮图片的item
+ (UIBarButtonItem *) itemWithImageNamed:(NSString *)imageNamed highlightImageName:(NSString *)highlightImageName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageNamed] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
