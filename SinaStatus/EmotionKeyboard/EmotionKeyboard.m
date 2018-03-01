//
//  EmotionKeyboard.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/22.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#define emotionToolBarMaxButton 4

#import "EmotionKeyboard.h"
#import "EmotionScrollView.h"

@interface EmotionKeyboard ()
/**
 *  表情列表view
 */
@property (nonatomic, weak) EmotionScrollView *emotionView;
/**
 *  表情工具条
 */
@property (nonatomic, weak) UIView *emoToolBar;
/**
 *  记录当前选中的按钮
 */
@property (nonatomic, strong) UIButton *selectedButton;

@end

@implementation EmotionKeyboard

+ (instancetype) keyboard
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加emotion表情
        EmotionScrollView *emotionView = [[EmotionScrollView alloc] init];
        [self addSubview:emotionView];
        self.emotionView = emotionView;
        self.emotionView.backgroundColor = [UIColor greenColor];
        
        //添加emotion表情工具条
        UIView *emoToolBar = [[UIView alloc] init];
        [self addSubview:emoToolBar];
        self.emoToolBar = emoToolBar;
        
        [self setupEmotionToolBarButton:@"最近"];
        UIButton *defalutButton = [self setupEmotionToolBarButton:@"默认"];
        [self clickEmotionToolBarButton:defalutButton]; //调用一下，设置“默认”按钮为默认点击的按钮
        [self setupEmotionToolBarButton:@"Emoji"];
        [self setupEmotionToolBarButton:@"浪小花"];
    }
    return self;
}

- (UIButton *) setupEmotionToolBarButton:(NSString *)title
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button addTarget:self action:@selector(clickEmotionToolBarButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.emoToolBar addSubview:button];
    [button setBackgroundImage:[UIImage resizableImage:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage resizableImage:@"compose_emotion_table_mid_selected"] forState:UIControlStateSelected];
    return button;
}

- (void) clickEmotionToolBarButton:(UIButton *)button
{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //计算表情工具条的frame
    self.emoToolBar.x = 0;
    self.emoToolBar.width = self.width;
    self.emoToolBar.height = 35;
    self.emoToolBar.y = self.height - self.emoToolBar.height;
    
    //计算表情列表view的frame
    self.emotionView.x = 0;
    self.emotionView.width = self.width;
    self.emotionView.height = self.emoToolBar.y;
    self.emotionView.y = 0;
    
    //计算emotionToolBar里面按钮的frame
    for (int i = 0; i < emotionToolBarMaxButton; i ++) {
        UIButton *button = self.emoToolBar.subviews[i];
        button.width = self.emoToolBar.width / emotionToolBarMaxButton;
        button.height = self.emoToolBar.height;
        button.y = 0;
        button.x = i * button.width;
    }
}

@end
