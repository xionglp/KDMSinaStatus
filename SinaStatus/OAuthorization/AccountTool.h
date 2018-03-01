//
//  AccountTool.h
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/12.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Account;

@interface AccountTool : NSObject

/**
 *  将用户账号存到沙盒中
 */
+ (void) saveAccount:(Account *) account;

/**
 *  读取账号
 */
+ (Account *) account;

@end
