//
//  OauthController.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/12.
//  Copyright (c) 2015年 XLP. All rights reserved.
//
// 1.成为新浪微博的开发者，创建一个移动app
//  App Key：3871670971
//  App Secret：0fa40c618c2ea7610b8472bd57207765


//第三方（这个应用）想要访问服务提供商（新浪微博）的用户数据时，需要进行Oauth授权
//步骤：1. 拿到未授权的request token  (显示登录界面)
//     2. 拿到已授权的request token  (进行用户登录)
//     3. 利用已授权的request token换取access token （访问标记）

//演示：
// 1. 获取未授权的request token 展示登陆界面
//  OAuth授权URL：https://api.weibo.com/oauth2/authorize
// 参数：
//client_id	true	string	申请应用时分配的AppKey。 应用的唯一标示，知道是哪个应用授权
//redirect_uri	true	string	授权回调地址  授权成功后回调页面url

//2. 授权成功后，回调的授权页面
//http://www.weibo.com/u/2689686383/home?wvr=5&code=c6adfe527ee6b8743390c9634e0ee5ea
//后面拼接授权成功后的request token code=c6adfe527ee6b8743390c9634e0ee5ea

//3. 获取授权的access token
// URL https://api.weibo.com/oauth2/access_token
// 参数：
//client_id	true	string	申请应用时分配的AppKey。
//client_secret	true	string	申请应用时分配的AppSecret。
//grant_type	true	string	请求的类型，填写authorization_code
//code	true	string	调用authorize获得的code值。
//redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。

#import "OAuthController.h"
#import "MBProgressHUD+MJ.h"
#import "Account.h"
#import "ChangeVcTool.h"
#import "AccountTool.h"
#import "MainHttpTool.h"

@interface OAuthController ()<UIWebViewDelegate>

@end

@implementation OAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    webView.delegate = self;
    
    NSString *str = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",client_id,redirect_uri];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate
/**
 *  每次发送请求之前都会调用这个方法，
 *
 *  @return YES 说明允许访问
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    NSLog(@"url:%@",url);
    NSString *string = [NSString stringWithFormat:@"%@/?code=",redirect_uri];
    NSLog(@"string:%@",string);
    NSRange range = [url rangeOfString:string];
    if (range.location !=NSNotFound) {
        //截取字符串
        NSInteger interger = range.length + range.location;
        NSString *code = [url substringFromIndex:interger];
        
        [self accessTokenToCode:code];
        return NO; //禁止加载回调界面
    }
    return YES;
}



/**
 *  将授权回调的request token 换取成access token
 *  @param code 授权回调的request token
 */
- (void) accessTokenToCode:(NSString *)code
{
    NSDictionary *params = @{
                             @"client_id" : client_id,
                             @"client_secret" : client_secret,
                             @"grant_type" : @"authorization_code",
                             @"code" : code,
                             @"redirect_uri" : redirect_uri,
                             };
    [MainHttpTool post:access_token params:params success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        Account *account = [[Account alloc] init];
        [account setValuesForKeysWithDictionary:responseObject];
        NSDate *nowTime = [NSDate date];
        account.expires_time = [nowTime dateByAddingTimeInterval:account.expires_in.doubleValue];
        //将对象归档到沙盒的Documents目录中
        [AccountTool saveAccount:account];
        //授权成功后，要判断是调到版本新特性还是直接调到tabbar
        [ChangeVcTool jumpNewFeatureControllerOrTabBarController];
        
    } failure:^(NSError *error) {
        NSLog(@"error:%@",error);
        [MBProgressHUD hideHUD];
    }];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
