//
//  User.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/13.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import "User.h"

@implementation User

/**
 *  判断是否为会员
 */
- (BOOL)isVip
{
    return self.mbtype > 2;
}

@end
