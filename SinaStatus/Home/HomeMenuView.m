//
//  PopmenuView.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/8/2.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import "HomeMenuView.h"

@interface HomeMenuView ()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *coverBtn;
@property (nonatomic, strong) UIImageView *container;  //容器控件（菜单栏弹框）

@end

@implementation HomeMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //后边的遮盖板，将button的颜色清空
        UIButton *coverBtn = [[UIButton alloc] init];
        coverBtn.backgroundColor = [UIColor clearColor];
        [self addSubview:coverBtn];
        [coverBtn addTarget:self action:@selector(clickCoverBtn) forControlEvents:UIControlEventTouchUpInside];
        self.coverBtn = coverBtn;
        
        //菜单栏弹框
        UIImageView *container = [[UIImageView alloc] init];
        container.image = [UIImage resizableImage:@"popover_background"];
        [self addSubview:container];
        container.userInteractionEnabled = YES;
        self.container = container;
    }
    return self;
}

- (instancetype) initWithPopContentView:(UIView *)contentview
{
    if (self = [super init]) {
        //将传进来的contentView用强指针的成员变量保存起来
        self.contentView = contentview;
    }
    return self;
}

+ (instancetype) popmenuViewWithContentView:(UIView *)contentView
{
    return [[self alloc] initWithPopContentView:contentView];
}

- (void) showInRect:(CGRect)rect
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    self.frame = window.bounds;
    self.container.frame = rect;
}

- (void) dismiss
{
    if ([self.delegate respondsToSelector:@selector(PopmenuDidDismiss:)]) {
        [self.delegate PopmenuDidDismiss:self];
    }
    [self removeFromSuperview];
}

- (void) setBackground:(UIImage *)backgroundImage
{
    self.container.image = backgroundImage;
}

//设置子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.coverBtn.frame = self.bounds;
}

- (void) clickCoverBtn
{
    [self dismiss];
}
@end
