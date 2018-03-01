//
//  StatusesRetweetView.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/16.
//  Copyright (c) 2015年 XLP. All rights reserved.
//  转发微博

#import "StatusRetweetView.h"
#import "StatusFrame.h"
#import "Status.h"
#import "User.h"
#import "UIImage+Estension.h"
#import "StatusPhotosView.h"

@interface StatusRetweetView ()
@property (nonatomic, strong) UILabel *namelabel;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) StatusPhotosView *photosView; //图片集view

@end

@implementation StatusRetweetView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizableImage:@"timeline_retweet_background"];
        //转发昵称
        UILabel *namelabel = [[UILabel alloc] init];
        [self addSubview:namelabel];
        self.namelabel = namelabel;
        self.namelabel.font = StatusRetweetedNameFont;
        self.namelabel.textColor = SinaColor(74, 102, 105);
        
        //正文
        UILabel *textLabel = [[UILabel alloc] init];
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        self.textLabel.font = StatusRetweetedTextFont;
        self.textLabel.numberOfLines = 0;
        
        //图片集view
        self.photosView = [[StatusPhotosView alloc] init];
        [self addSubview:self.photosView];
    }
    return self;
}

- (void)setStatusframe:(StatusFrame *)statusframe
{
    _statusframe = statusframe;
    self.frame = statusframe.retweetViewFrame;
    
    self.namelabel.text = [NSString stringWithFormat:@"@%@",statusframe.status.retweeted_status.user.name];
    self.namelabel.frame = statusframe.retweetNameFrame;
    
    self.textLabel.text = statusframe.status.retweeted_status.text;
    self.textLabel.frame = statusframe.retweetTextFrame;
    
    if (statusframe.status.retweeted_status.pic_urls.count) {
        self.photosView.hidden = NO;
        self.photosView.frame = statusframe.retweetPhotosFrame;
        self.photosView.photoArray = statusframe.status.retweeted_status.pic_urls;
    }else{
        self.photosView.hidden = YES;
    }
}

@end
