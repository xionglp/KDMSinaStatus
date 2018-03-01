//
//  StatusesOriginalView.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/16.
//  Copyright (c) 2015年 XLP. All rights reserved.
//  原创微博，自己发的微博

#import "StatusOriginalView.h"
#import "StatusFrame.h"
#import "Status.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "StatusPhotosView.h"

@interface StatusOriginalView ()
@property (nonatomic, strong) UILabel *namelabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *sourceLabel;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIImageView *vipView;
@property (nonatomic, strong) StatusPhotosView *photosView; //图片集view

@end

@implementation StatusOriginalView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //用户头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        //用户昵称
        UILabel *namelabel = [[UILabel alloc] init];
        [self addSubview:namelabel];
        self.namelabel = namelabel;
        self.namelabel.font = StatusOrginalNameFont;
        
        //发表时间
        UILabel *timeLabel = [[UILabel alloc] init];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        self.timeLabel.font = StatusOrginalTimeFont;
        self.timeLabel.textColor = [UIColor orangeColor];
        
        //来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        self.sourceLabel.font = StatusOrginalSourceFont;
        self.sourceLabel.textColor = [UIColor lightGrayColor];
        
        //正文
        UILabel *textLabel = [[UILabel alloc] init];
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        self.textLabel.font = StatusOrginalTextFont;
        self.textLabel.numberOfLines = 0;
        
        //会员图标
        UIImageView *vipView = [[UIImageView alloc] init];
        [self addSubview:vipView];
        vipView.contentMode = UIViewContentModeCenter;
        self.vipView = vipView;
        
        //图片集view
        self.photosView = [[StatusPhotosView alloc] init];
        [self addSubview:self.photosView];
    }
    return self;
}

- (void)setStatusframe:(StatusFrame *)statusframe
{
    _statusframe = statusframe;
    self.frame = statusframe.originalViewFrame;
    
    //昵称
    self.namelabel.text = statusframe.status.user.name;
    self.namelabel.frame = statusframe.originalNameFrame;
    if (statusframe.status.user.isVip) {
        self.namelabel.textColor = [UIColor orangeColor];
    }else{
        self.namelabel.textColor = [UIColor blackColor];
    }
    
    //vip图标
    if (statusframe.status.user.isVip) {
        NSString *imageStr = [NSString stringWithFormat:@"common_icon_membership_level%d",statusframe.status.user.mbrank];
        self.vipView.image = [UIImage imageNamed:imageStr];
        self.vipView.hidden = NO;
    }else{ //为了循环利用，不是会员的应将会员图标隐藏
        self.vipView.hidden = YES;
    }
    self.vipView.frame = statusframe.originalVipFrame;
    
    //发布时间
    self.timeLabel.text = statusframe.status.created_at;
    self.timeLabel.frame = statusframe.originalTimeFrame;
    
    //来源
    self.sourceLabel.text = statusframe.status.source;
    self.sourceLabel.frame = statusframe.originalSourceFrame;
    
    //正文
    self.textLabel.text = statusframe.status.text;
    self.textLabel.frame = statusframe.originalTextFrame;
    
    //微博用户头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:statusframe.status.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.iconView.frame = statusframe.originalIconFrame;
    
    if (statusframe.status.pic_urls.count) {
        self.photosView.hidden = NO;
        self.photosView.frame = statusframe.originalPhotosFrame;
        self.photosView.photoArray = statusframe.status.pic_urls;
    }else{
        self.photosView.hidden = YES;
    }
}


@end
