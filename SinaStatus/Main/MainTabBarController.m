//
//  XXMainTabBarController.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/7/30.
//  Copyright (c) 2015年 XLP. All rights reserved.
//


//测试提交代码


// Xcode的插件安装路径: /Users/用户名/Library/Application Support/Developer/Shared/Xcode/Plug-ins

#import "MainTabBarController.h"
#import "HomeViewController.h"
#import "MessageController.h"
#import "DiscoverController.h"
#import "ProfileController.h"
#import "MainNaviBarController.h"
#import "ComposeController.h"
#import "MainTabBar.h"
#import "MainHttpTool.h"
#import "AccountTool.h"
#import "Account.h"
#import "MJExtension.h"
#import "StatusUnRead.h"

@interface MainTabBarController ()<UITabBarControllerDelegate,MainTabBarDelegate>
@property (nonatomic, strong) HomeViewController *homeVc;
@property (nonatomic, strong) MessageController *messageVc;
@property (nonatomic, strong) ProfileController *profileVc;
@property (nonatomic, strong) UIViewController *lastViewController;

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomeViewController *homeVc = [[HomeViewController alloc] init];
    [self addChildVc:homeVc title:@"首页" nomalImageName:@"tabbar_home"
    selectedImageName:@"tabbar_home_selected"];
    self.homeVc = homeVc;
    self.lastViewController = homeVc;
    
    MessageController *messageVc = [[MessageController alloc] init];
    [self addChildVc:messageVc title:@"消息" nomalImageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    self.messageVc = messageVc;
    
    DiscoverController *disVc = [[DiscoverController alloc] init];
    [self addChildVc:disVc title:@"发现" nomalImageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    ProfileController *profileVc = [[ProfileController alloc] init];
    [self addChildVc:profileVc title:@"我" nomalImageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    self.profileVc = profileVc;
    
    //自定义tabbar替换掉系统的tabbar
    MainTabBar *customTabBar = [[MainTabBar alloc] init];
    customTabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background"];
    customTabBar.selectionIndicatorImage = [UIImage imageNamed:@"navigationbar_button_background"];
    customTabBar.delegate = self;
    
    //利用KVC自定义tabbar替换掉系统的tabbar
    [self setValue:customTabBar forKey:@"tabBar"];
    //设置代理（监听控制器的切换， 控制器一旦切换了子控制器，就会调用代理的tabBarController:didSelectViewController:）
    self.delegate = self;
    
    //每隔一段时间获取用户的未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(getUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void) getUnreadCount
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AccountTool account].access_token;
    params[@"uid"] = [AccountTool account].uid;
    [MainHttpTool get:remind_unread params:params success:^(id responseObject) {
        StatusUnRead *unRead = [StatusUnRead objectWithKeyValues:responseObject];
        //微博为读数
        if (unRead.status == 0) {
            self.homeVc.tabBarItem.badgeValue = nil;
        }else{
            self.homeVc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unRead.status];
        }
        //消息未读数
        if (unRead.messageCount == 0) {
            self.messageVc.tabBarItem.badgeValue = nil;
        }else{
            self.messageVc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unRead.messageCount];
        }
        //粉丝未读数
        if (unRead.follower == 0) {
            self.profileVc.tabBarItem.badgeValue = nil;
        }else{
            self.profileVc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unRead.follower];
        }
        
        // ios8中，第一次应该设置应用的application badge value需要得到用户的许可
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [UIApplication sharedApplication].applicationIconBadgeNumber = unRead.totalCount;
    } failure:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UINavigationController *)viewController
{
    //重新布局tabbar，内部会调用layoutsubviews方法
    [self.tabBar setNeedsLayout];
    
    UIViewController *vc = [viewController.viewControllers lastObject];
    if ([vc isKindOfClass:[HomeViewController class]]) {
        if (self.lastViewController == vc) {
            [self.homeVc refresh:YES];
        }else{
            [self.homeVc refresh:NO];
        }
    }
    
    self.lastViewController = vc;
}

/**
 *  当第一次使用这个类的时候只会调用一次
 */
+ (void)initialize
{
    //[UITabBarItem appearance] 对整个项目的title设置主题
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor grayColor],NSForegroundColorAttributeName,
                                                       [UIFont systemFontOfSize:11],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor orangeColor],NSForegroundColorAttributeName,
                                                       [UIFont systemFontOfSize:11],NSFontAttributeName, nil] forState:UIControlStateSelected];
}

- (void) addChildVc:(UIViewController *)childVc title:(NSString *)title nomalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName
{
    //childVc.title 等于同时设置 childVc.tabBarItem.title 和 childVc.navigationBarItem.title
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:normalImageName];
    
    // 在iOS7中, 会对selectedImage的图片进行再次渲染为蓝色
    // 要想显示原图, 就必须得告诉它: 不要渲染
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    MainNaviBarController *mainNaVc = [[MainNaviBarController alloc] initWithRootViewController:childVc];
    [self addChildViewController:mainNaVc];
}

#pragma mark - MainTabBarDelegate
- (void)tabbarDidClickPlusButton:(MainTabBar *)tabbar
{
    ComposeController *vc = [[ComposeController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    MainNaviBarController *navc = [[MainNaviBarController alloc] initWithRootViewController:vc];
    [self presentViewController:navc animated:YES completion:nil];
}

@end
