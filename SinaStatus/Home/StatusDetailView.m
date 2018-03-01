//
//  StatusesDetailView.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/16.
//  Copyright (c) 2015年 XLP. All rights reserved.
//  微博的具体内容，分成俩快 （原创微博+转发微博）

#import "StatusDetailView.h"
#import "StatusOriginalView.h"
#import "StatusRetweetView.h"
#import "StatusFrame.h"

@interface StatusDetailView ()
@property (nonatomic, strong) StatusOriginalView *originalView;
@property (nonatomic, strong) StatusRetweetView *retweetView;

@end

@implementation StatusDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizableImage:@"timeline_card_top_background"];
        
        //原创微博view
        self.originalView = [[StatusOriginalView alloc] init];
        [self addSubview:self.originalView];
        
        //转发微博view
        self.retweetView = [[StatusRetweetView alloc] init];
        [self addSubview:self.retweetView];
        
    }
    return self;
}

- (void)setStatusframe:(StatusFrame *)statusframe
{
    _statusframe = statusframe;
    self.frame = statusframe.detailViewFrame;
    //原创微博的frame
    self.originalView.statusframe = statusframe;
    //转发微博的frame
    self.retweetView.statusframe = statusframe;
}


@end
