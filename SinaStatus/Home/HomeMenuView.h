//
//  PopmenuView.h
//  SinaStatus
//
//  Created by 熊鲁平 on 15/8/2.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeMenuView;

@protocol popmenuViewDelegate <NSObject>

@optional
- (void) PopmenuDidDismiss:(HomeMenuView *)popmenu;

@end

@interface HomeMenuView : UIView

@property (nonatomic, weak) id<popmenuViewDelegate>delegate;

- (instancetype) initWithPopContentView:(UIView *)contentview;
+ (instancetype) popmenuViewWithContentView:(UIView *)contentView;

- (void) showInRect:(CGRect)rect;
- (void) dismiss;
- (void) setBackground:(UIImage *)backgroundImage;

@end
