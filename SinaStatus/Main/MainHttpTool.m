//
//  MainHttpTool.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/16.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import "MainHttpTool.h"
#import "AFNetworking.h"

NSString * const users_show =        @"https://api.weibo.com/2/users/show.json";                          //获取用户的昵称信息
NSString * const statuses_friends =  @"https://api.weibo.com/2/statuses/friends_timeline.json";     //获取微博的最新数据
NSString * const statuses_home =     @"https://api.weibo.com/2/statuses/home_timeline.json";           //获取上拉刷新加载以前的旧数据
NSString * const access_token =      @"https://api.weibo.com/oauth2/access_token";                      //获取access_token
NSString * const statuses_update =   @"https://api.weibo.com/2/statuses/update.json";                //发表没有图片的微博
NSString * const remind_unread =     @"https://rm.api.weibo.com/2/remind/unread_count.json";           //获取用户各种消息未读数
NSString * const statuses_upload =   @"https://upload.api.weibo.com/2/statuses/upload.json";         //发表有图片的微博

@implementation MainHttpTool

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送GET请求
    [mgr GET:url parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObj) {
         if (success) {
             success(responseObj);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
}

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送POST请求
    [mgr POST:url parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          if (success) {
              success(responseObj);
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (failure) {
              failure(error);
          }
      }];
}

@end
