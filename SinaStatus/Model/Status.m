//
//  Status.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/13.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import "Status.h"
#import "MJExtension.h"
#import "Photo.h"
#import "NSDate+MJ.h"

@implementation Status

+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [Photo class]};
}

//- (NSString *)source
//{
//    //<a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>
//    //字符串的截取,获得子串
//    NSRange range;
//    NSString *subStr;
//    range.location = [_source rangeOfString:@">"].location + 1;
//    range.length = [_source rangeOfString:@"</"].location - range.location;
//    subStr = [_source substringWithRange:range];
//    return [NSString stringWithFormat:@"来自%@",subStr];
//}

- (void)setSource:(NSString *)source
{
    NSRange range;
    NSString *subStr;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    subStr = [source substringWithRange:range];
    _source = [NSString stringWithFormat:@"来自%@",subStr];
}

/**
 *  重写getter方法，在返回的creater_at时间值里面判断
 */
- (NSString *)created_at
{
    //Thu Sep 17 09:08:54 +0800 2015
#warning 时间转换没有出来
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    fmt.dateStyle = NSDateFormatterLongStyle;
    // 获得微博发布的具体时间
    NSDate *createDate = [fmt dateFromString:_created_at];
    
    // 判断是否为今年
    if (createDate.isThisYear) {
        if (createDate.isToday) { // 今天
            NSDateComponents *cmps = [createDate deltaWithNow];
            if (cmps.hour >= 1) { // 至少是1小时前发的
                return [NSString stringWithFormat:@"%ld小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1~59分钟之前发的
                return [NSString stringWithFormat:@"%ld分钟前", cmps.minute];
            } else { // 1分钟内发的
                return @"刚刚";
            }
        } else if (createDate.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else { // 至少是前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:createDate];
    }
}


@end
