//
//  ChangeVcTool.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/12.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import "ChangeVcTool.h"
#import "MainTabBarController.h"
#import "NewFeatureController.h"
#import "AppDelegate.h"

@implementation ChangeVcTool

/**
 *  判断是调到版本新特性还是调到tabbarController
 */
+ (void) jumpNewFeatureControllerOrTabBarController
{
    //比较进来的版本号,如果当前的版本号，沙盒当中没有则需要显示版本新特性
    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
    //取出上次的版本
    NSUserDefaults *defalut = [NSUserDefaults standardUserDefaults];
    NSString *lastversion = [defalut objectForKey:versionKey];
    //拿到当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    AppDelegate *Appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if ([lastversion isEqualToString:currentVersion]) {
        //直接进到tabBarController
        MainTabBarController *tabarVc = [[MainTabBarController alloc] init];
        Appdelegate.window.rootViewController = tabarVc;
    }else{
        //版本新特性
        Appdelegate.window.rootViewController = [[NewFeatureController alloc] init];
        //将版本号存到应用的偏好设置中
        [defalut setObject:currentVersion forKey:versionKey];
        [defalut synchronize];
    }
}

@end
