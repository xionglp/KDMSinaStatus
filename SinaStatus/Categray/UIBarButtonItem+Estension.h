//
//  UIBarButtonItem+Estension.h
//  SinaStatus
//
//  Created by 熊鲁平 on 15/7/30.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Estension)
/**
 *  创建一个带有普通和高亮图片的item
 */
+ (UIBarButtonItem *) itemWithImageNamed:(NSString *)imageNamed highlightImageName:(NSString *)highlightImageName target:(id)target action:(SEL)action;

@end
