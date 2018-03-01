//
//  ComTextView.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/15.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import "ComTextView.h"

@interface ComTextView ()
/**
 *  显示占位文字的label
 */
@property (nonatomic, strong) UILabel *placeLabel;

@end

@implementation ComTextView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.placeLabel = [[UILabel alloc] init];
        [self addSubview:self.placeLabel];
        self.placeLabel.numberOfLines = 0;
        self.font = [UIFont systemFontOfSize:15];
        self.placeLabel.backgroundColor = [UIColor clearColor];
        self.placeLabel.textColor = [UIColor lightGrayColor];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(placeHoldeTextCicChange) name:UITextViewTextDidChangeNotification object:self];
        
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placeLabel.x = 5;
    self.placeLabel.y = 8;
    self.placeLabel.width = self.width - 2*self.placeLabel.x;
    CGSize placeZise = [self.placeholder boundingRectWithSize:CGSizeMake(self.placeLabel.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeLabel.font} context:nil].size;
    self.placeLabel.height = placeZise.height;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.placeLabel.text = placeholder;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeLabel.textColor = placeholderColor;
    [self setNeedsLayout];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeLabel.font = font;
    //这行会调用 layoutSubviews方法，重新计算文字的尺寸
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self placeHoldeTextCicChange];
}

- (void) placeHoldeTextCicChange
{
    self.placeLabel.hidden = (self.text.length != 0);
}

@end
