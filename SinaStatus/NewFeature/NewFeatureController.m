//
//  NewFeatureController.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/11.
//  Copyright (c) 2015年 XLP. All rights reserved.
//
#define imageCount 4

#import "NewFeatureController.h"
#import "MainTabBarController.h"

@interface NewFeatureController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation NewFeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *newScrollView = [[UIScrollView alloc] init];
    [self.view addSubview:newScrollView];
    newScrollView.frame = self.view.bounds;
    newScrollView.delegate = self;
    
    CGFloat imgW = self.view.frame.size.width;
    CGFloat imgH = self.view.frame.size.height;
    for (int i = 0; i < imageCount; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * imgW, 0, imgW, imgH)];
        [newScrollView addSubview:imgView];
        NSString *imageStr = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        imgView.image = [UIImage imageNamed:imageStr];
        //在最后一张版本新特性图片上添加一些按钮
        if (i == imageCount - 1) {
            [self setUpLastImageView:imgView];
        }
    }
    
    newScrollView.pagingEnabled = YES; //分页
    newScrollView.contentSize = CGSizeMake(imgW * imageCount, 0);
    newScrollView.showsHorizontalScrollIndicator = NO;  //隐藏水平滚动条
    newScrollView.backgroundColor = SinaColor(244,244, 244);
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.centerX = self.view.width * 0.5;
    self.pageControl.centerY = self.view.height - 30;
    self.pageControl.numberOfPages = 4;
    self.pageControl.pageIndicatorTintColor = SinaColor(189, 189, 189);
    self.pageControl.currentPageIndicatorTintColor = SinaColor(253, 98, 42);
    [self.view addSubview:self.pageControl];
}

/**
 *  在版本新特性最后一张图片上加几个按钮
 */
- (void) setUpLastImageView:(UIImageView *)imageView
{
    UIButton *shareBtn = [[UIButton alloc] init];
    shareBtn.size = CGSizeMake(150, 23);
    shareBtn.centerX = self.view.width * 0.5;
    shareBtn.centerY = self.view.height - 120;
    [imageView addSubview:shareBtn];
    imageView.userInteractionEnabled = YES;
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn addTarget:self action:@selector(clickShareBtn:) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    //开始按钮
    UIButton *startBtn = [[UIButton alloc] init];
    [imageView addSubview:startBtn];
    startBtn.size = CGSizeMake(120, 35);
    startBtn.centerX = self.view.width * 0.5;
    startBtn.centerY = self.view.height - 80;
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button" ] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(clickStartBtn) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 
- (void) clickShareBtn:(UIButton *)button
{
    button.selected = !button.selected;
}

- (void) clickStartBtn
{
    MainTabBarController *tabVc = [[MainTabBarController alloc] init];
//    [self.navigationController pushViewController:tabVc animated:YES];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = tabVc;
}

/**
 *  scrollView 结束拖拽时调用，利用scrollView的位置计算出pageControl得当前页数
 */
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //拿到当前pageControl的页码
    CGFloat pages = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = pages + 0.5;
}

@end
