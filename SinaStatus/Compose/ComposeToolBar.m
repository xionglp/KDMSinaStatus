//
//  ComposeTool.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/15.
//  Copyright (c) 2015年 XLP. All rights reserved.
//  键盘上面的工具条

#import "ComposeToolBar.h"

@interface ComposeToolBar ()

/**
 *  emotion表情按钮
 */
@property (nonatomic, strong) UIButton *emotionBtn;

@end

@implementation ComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        // 添加所有的子控件
        [self addButtonWithIcon:@"compose_trendbutton_background" highIcon:@"compose_trendbutton_background_highlighted" tag:ComposeToolbarButtonTypeTrend];
        [self addButtonWithIcon:@"compose_camerabutton_background" highIcon:@"compose_camerabutton_background_highlighted" tag:ComposeToolbarButtonTypeCamera];
        [self addButtonWithIcon:@"compose_toolbar_picture" highIcon:@"compose_toolbar_picture_highlighted" tag:ComposeToolbarButtonTypePicture];
        [self addButtonWithIcon:@"compose_mentionbutton_background" highIcon:@"compose_mentionbutton_background_highlighted" tag:ComposeToolbarButtonTypeMention];
        self.emotionBtn = [self addButtonWithIcon:@"compose_emoticonbutton_background" highIcon:@"compose_emoticonbutton_background_highlighted" tag:ComposeToolbarButtonTypeEmotion];
    }
    return self;
}

- (void)setShowEmotion:(BOOL)showEmotion
{
    _showEmotion = showEmotion;
    if (showEmotion) {//当前显示键盘按钮，切换到表情按钮
        [self.emotionBtn setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.emotionBtn setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }else{//当前显示的表情按钮，切换到键盘按钮
        [self.emotionBtn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.emotionBtn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger btnCount = self.subviews.count;
    for (int i = 0; i < btnCount; i++) {
        UIButton *btn = self.subviews[i];
        btn.height = self.height;
        btn.width = self.width/btnCount;
        btn.y = 0;
        btn.x = i * btn.width;
    }
}

/**
 *  添加一个按钮
 *  @param icon     默认图标
 *  @param highIcon 高亮图标
 */
- (UIButton *)addButtonWithIcon:(NSString *)icon highIcon:(NSString *)highIcon tag:(ComposeToolbarButtonType)tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = (NSInteger)tag;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    [self addSubview:button];
    return button;
}

- (void) buttonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(ComposeToolBar:DidClickToolBarButton:)]) {
        [self.delegate ComposeToolBar:self DidClickToolBarButton:button.tag];
    }
}

@end
