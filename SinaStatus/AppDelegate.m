//
//  AppDelegate.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/7/29.
//  Copyright (c) 2015年 XLP. All rights reserved.

// NSURLSession/NSURLConnection HTTP load failed (kCFStreamErrorDomainSSL, -9802) ios9.0后错误
// 将info.plist配置文件改掉（添加一些Key），
// <key>NSAppTransportSecurity</key>
//<dict>
//<key>NSAllowsArbitraryLoads</key>
//<true/>
//</dict>
//安全机制改了 真蛋疼

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "NewFeatureController.h"
#import "OAuthController.h"
#import "Account.h"
#import "ChangeVcTool.h"
#import "AccountTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "SDImageCache.h"
#import "SDWebImageManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    //先看有没有账号，有账号的话，在看沙盒中有没有版本版本
    Account *account = [AccountTool account];
    
    NSDate *nowTime = [NSDate date];
    if ( [account.expires_time compare:nowTime] == NSOrderedAscending){ //NSOrderedAscending 升序 越往右边越大
        // 现在时间大于过期时间，代码账号过期
        return account = nil;
    }
    if (account){
        //比较进来的版本号,如果当前的版本号，沙盒当中没有则需要显示版本新特性
        [ChangeVcTool jumpNewFeatureControllerOrTabBarController];
    }else{
        self.window.rootViewController = [[OAuthController alloc] init];
    }
    
    [self.window makeKeyAndVisible];
    
    // 4.监控网络
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 当网络状态改变了，就会调用
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                SinaLog(@"没有网络(断网)");
                [MBProgressHUD showError:@"网络异常，请检查网络设置！"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                SinaLog(@"手机自带网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                SinaLog(@"WIFI");
                [MBProgressHUD showSuccess:@"wifi网络"];
                break;
        }
    }];
    // 开始监控
    [mgr startMonitoring];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

/**
 *  程序进入后台调用该方法
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 提醒操作系统：当前这个应用程序需要在后台开启一个任务
    // 操作系统会允许这个应用程序在后台保持运行状态（能够持续的时间是不确定）
    UIBackgroundTaskIdentifier taskID = [application beginBackgroundTaskWithExpirationHandler:^{
        // 后台运行的时间到期了，就会自动调用这个block
        [application endBackgroundTask:taskID];
    }];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

/**
 *   应用程序内存警告
 */
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 赶紧清除所有的内存缓存
    [[SDImageCache sharedImageCache] clearMemory];
    // 赶紧停止正在进行的图片下载操作
    [[SDWebImageManager sharedManager] cancelAll];
}

@end
