//
//  MainNaviBarController.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/7/30.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import "MainNaviBarController.h"

@interface MainNaviBarController ()

@end

@implementation MainNaviBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//当第一次使用这个类的时候只会调用一次
+ (void)initialize
{
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSMutableDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName,[UIColor orangeColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSMutableDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName,[UIColor redColor],NSForegroundColorAttributeName, nil] forState:UIControlStateHighlighted];
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSMutableDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName,[UIColor grayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateDisabled];
    
    // 技巧: 为了让某个按钮的背景消失, 可以设置一张完全透明的背景图片
    [[UIBarButtonItem appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:NavBarTitleFont,NSFontAttributeName,[UIColor blackColor],NSForegroundColorAttributeName, nil]];
}

//拦截所有push进来的控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageNamed:@"navigationbar_back" highlightImageName:@"navigationbar_back_highlighted" target:self action:@selector(back)];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageNamed:@"navigationbar_more" highlightImageName:@"navigationbar_more_highlighted" target:self action:@selector(root)];
    }
    [super pushViewController:viewController animated:YES];
}

- (void) back
{
    [self popViewControllerAnimated:YES];
}

- (void) root
{
    [self popToRootViewControllerAnimated:YES];
}

@end
