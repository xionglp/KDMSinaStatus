//
//  Photo.h
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/13.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject
/** 缩略图 */
@property (nonatomic, copy) NSString *thumbnail_pic;
/** 大图 */
@property (nonatomic, copy) NSString *bmiddle_pic;

@end
