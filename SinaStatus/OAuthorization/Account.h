//
//  Account.h
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/12.
//  Copyright (c) 2015年 XLP. All rights reserved.
//
//"access_token" = "2.008SeBwCzTIBOE8c6e453274xhdnZB";
//"expires_in" = 157679999;
//"remind_in" = 157679999;
//uid = 2689686383;

#import <Foundation/Foundation.h>

@interface Account : NSObject<NSCoding>
@property (nonatomic, strong) NSString *access_token;
/** string 	access_token的生命周期，单位是秒数。*/
@property (nonatomic, strong) NSString *expires_in;

@property (nonatomic, strong) NSDate *expires_time;
@property (nonatomic, strong) NSString *remind_in;
@property (nonatomic, strong) NSString *uid;

/**
 *  用户的昵称
 */
@property (nonatomic, strong) NSString *name;

@end
