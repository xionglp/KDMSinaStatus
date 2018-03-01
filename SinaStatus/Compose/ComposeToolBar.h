//
//  ComposeTool.h
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/15.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

typedef enum {
    ComposeToolbarButtonTypeCamera, // 照相机
    ComposeToolbarButtonTypePicture, // 相册
    ComposeToolbarButtonTypeMention, // 提到@
    ComposeToolbarButtonTypeTrend, // 话题
    ComposeToolbarButtonTypeEmotion // 表情
} ComposeToolbarButtonType;

#import <UIKit/UIKit.h>
@class ComposeToolBar;

@protocol ComposeToolBarDelegate <NSObject>

@optional

- (void)ComposeToolBar:(ComposeToolBar *)toolBar DidClickToolBarButton:(ComposeToolbarButtonType)type;

@end


@interface ComposeToolBar : UIView
@property (nonatomic, weak) id<ComposeToolBarDelegate>delegate;
@property (nonatomic, assign) BOOL showEmotion;

@end
