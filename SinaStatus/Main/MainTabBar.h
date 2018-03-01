//
//  MainTabBar.h
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/11.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainTabBar;

@protocol MainTabBarDelegate <NSObject>

@optional
- (void) tabbarDidClickPlusButton:(MainTabBar *)tabbar;

@end

@interface MainTabBar : UITabBar

@property (nonatomic, weak) id <MainTabBarDelegate>delegate;


@end
