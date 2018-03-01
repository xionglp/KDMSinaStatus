//
//  StatusPictureview.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/17.
//  Copyright (c) 2015年 XLP. All rights reserved.
//  微博的一张配图

#import "StatusPictureview.h"
#import "UIImageView+WebCache.h"
#import "Photo.h"

@interface StatusPictureview ()
@property (nonatomic, strong) UIImageView *gifView;

@end

@implementation StatusPictureview
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;  // 将多余的切掉
        
         self.gifView = [[UIImageView alloc] init];
        [self addSubview:self.gifView];
        self.gifView.image = [UIImage imageNamed:@"timeline_image_gif"];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.frame = CGRectMake(self.width - 27, self.height - 20, 27, 20);
}

- (void)setPhoto:(Photo *)photo
{
    _photo = photo;
    
    NSURL *url = [NSURL URLWithString:photo.thumbnail_pic];
    [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    if ([photo.thumbnail_pic.pathExtension.lowercaseString isEqualToString:@"gif"]) {
        self.gifView.hidden = NO;
    }else{
        self.gifView.hidden = YES;
    }
}

@end
