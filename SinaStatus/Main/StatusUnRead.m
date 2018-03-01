//
//  StatusUnRead.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/16.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import "StatusUnRead.h"

@implementation StatusUnRead

//getter方法
- (int)messageCount
{
    return self.dm + self.cmt + self.mention_cmt + self.mention_status;
}

- (int)totalCount
{
    return self.messageCount + self.status + self.follower;
}

@end
