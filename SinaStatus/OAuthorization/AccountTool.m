//
//  AccountTool.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/12.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#define accountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

#import "AccountTool.h"
#import "Account.h"

@implementation AccountTool

/**
 *  将用户账号存到沙盒中
 */
+ (void) saveAccount:(Account *) account{
    [NSKeyedArchiver archiveRootObject:account toFile:accountFile];
}

/**
 *  读取账号
 */
+ (Account *) account{
    //反归档，将文件从沙盒中读取出来
    Account *account = [NSKeyedUnarchiver unarchiveObjectWithFile:accountFile];
    return account;
}

@end
