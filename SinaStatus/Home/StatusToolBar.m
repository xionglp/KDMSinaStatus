//
//  StatusesToolBar.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/16.
//  Copyright (c) 2015年 XLP. All rights reserved.
//  微博底部的工具条

#import "StatusToolBar.h"
#import "Status.h"

@interface StatusToolBar ()
@property (nonatomic, strong) NSMutableArray *buttonAttay;
@property (nonatomic, strong) NSMutableArray *lineArray;
/** 转发按钮 */
@property (nonatomic, strong) UIButton *retweetBtn;
/**评论按钮 */
@property (nonatomic, strong) UIButton *commmentBtn;
/** 点赞按钮 */
@property (nonatomic, strong) UIButton *unlikeBtn;

@end

@implementation StatusToolBar

- (NSMutableArray *)buttonAttay
{
    if (_buttonAttay == nil) {
        _buttonAttay = [NSMutableArray array];
    }
    return _buttonAttay;
}

- (NSMutableArray *)lineArray
{
    if (_lineArray == nil) {
        _lineArray = [NSMutableArray array];
    }
    return _lineArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizableImage:@"timeline_card_bottom_background"];
        
        self.retweetBtn = [self setButtonTitle:@"转发" buttonImage:@"timeline_icon_retweet"];
        self.commmentBtn = [self setButtonTitle:@"评论" buttonImage:@"timeline_icon_comment"];
        self.unlikeBtn = [self setButtonTitle:@"点赞" buttonImage:@"timeline_icon_unlike"];
        
        [self setlineImage];
        [self setlineImage];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //计算子控件的尺寸
    
    NSUInteger btnCount = self.buttonAttay.count;
    NSUInteger btnW = self.width / btnCount;
    for (int i = 0; i < btnCount; i++) {
        UIButton *btn = self.buttonAttay[i];
        btn.width = btnW;
        btn.height = self.height;
        btn.y = 0;
        btn.x = i * btn.width;
    }
    
    NSUInteger lineCount = self.lineArray.count;
    for (int i = 0; i < lineCount; i++) {
        UIImageView *line = self.lineArray[i];
        line.width = 1;
        line.height = self.height;
        line.centerX = (i + 1) * btnW;
        line.centerY = self.height * 0.5;
    }
}

- (void)setStatus:(Status *)status
{
    _status = status;
    
    [self setupButtontitle:self.retweetBtn count:status.reposts_count placehoderTitle:@"转发"];
    [self setupButtontitle:self.commmentBtn count:status.comments_count placehoderTitle:@"评论"];
    [self setupButtontitle:self.unlikeBtn count:status.attitudes_count placehoderTitle:@"点赞"];
}

/**
 *  返回按钮的动态数
 *
 *  @param button          需要设置文字的按钮
 *  @param count           按钮显示的数字
 *  @param placehoderTitle 按钮的初始文字
 */
- (void) setupButtontitle:(UIButton *)button count:(int)count placehoderTitle:(NSString *) placehoderTitle
{
    /**
     *  10000以内，显示具体的数字
     *  一万以后，显示xx.x万
     *  如果是1070300 ，显示107整万，
     */
    NSString *retweetTitle = placehoderTitle;
    if (count > 10000) {  //大于一万
        retweetTitle = [NSString stringWithFormat:@"%.1d万",count / 10000];
    }else if (count > 0){  //[0 ~10000]
        retweetTitle = [NSString stringWithFormat:@"%d",count];
    }
    [button setTitle:retweetTitle forState:UIControlStateNormal];
}

- (void) setlineImage
{
    UIImageView *lineView = [[UIImageView alloc] init];
    [self addSubview:lineView];
    lineView.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self.lineArray addObject:lineView];
}

- (UIButton *) setButtonTitle:(NSString *)title buttonImage:(NSString *)image
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    btn.adjustsImageWhenHighlighted = NO;
    [self addSubview:btn];
    [self.buttonAttay addObject:btn];
    return btn;
}


@end
