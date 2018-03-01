//
//  MainTabBar.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/11.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import "MainTabBar.h"

@interface MainTabBar ()
@property (nonatomic, strong) UIButton *plusButton;

@end

@implementation MainTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIButton *plusButton = [[UIButton alloc] init];
        // 设置背景
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        // 设置图标
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [plusButton addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        self.plusButton = plusButton;
        [self addSubview:self.plusButton];
    }
    return self;
}

- (void) plusClick
{
    if ([self.delegate respondsToSelector:@selector(tabbarDidClickPlusButton:)]) {
        [self.delegate tabbarDidClickPlusButton:self];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    int index = 0;
    //遍历tabbar子控件，调整内部的tabbarbutton的frame
    for (UIView *tabBarButton in self.subviews) {
        if (![tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        tabBarButton.width = self.width / (self.items.count + 1);
        tabBarButton.height = self.height;
        tabBarButton.y = 0;
        if (index > 1) {
            tabBarButton.x = tabBarButton.width * (index + 1);
        }else{
            tabBarButton.x = index * tabBarButton.width;
        }
        
        //改掉系统tabbarbutton的文字属性
        NSInteger selectedIndex = [self.items indexOfObject:self.selectedItem];
        for (UILabel *label in tabBarButton.subviews) {
            if (![label isKindOfClass:[UILabel class]]) continue;
            if (selectedIndex == index) {
//                label.font = [UIFont systemFontOfSize:10];
                label.textColor = [UIColor orangeColor];
            }else{
                label.textColor = [UIColor grayColor];
            }
        }
        index++;
    }
    
    self.plusButton.size = self.plusButton.currentBackgroundImage.size;
    self.plusButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
}

@end
