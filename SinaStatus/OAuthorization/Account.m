//
//  Account.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/12.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import "Account.h"

@implementation Account

//反归档，将对象写到文件中
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_access_token forKey:@"access_token"];
    [aCoder encodeObject:_expires_in forKey:@"expires_in"];
    [aCoder encodeObject:_remind_in forKey:@"remind_in"];
    [aCoder encodeObject:_uid forKey:@"uid"];
    [aCoder encodeObject:_expires_time forKey:@"expires_time"];
    [aCoder encodeObject:_name forKey:@"name"];
}

//归档
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _access_token = [aDecoder decodeObjectForKey:@"access_token"];
        _expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        _remind_in = [aDecoder decodeObjectForKey:@"remind_in"];
        _uid = [aDecoder decodeObjectForKey:@"uid"];
        _expires_time = [aDecoder decodeObjectForKey:@"expires_time"];
        _name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}

@end
