//
//  NSString+TextFrame.h
//  07-23-QQ聊天布局
//
//  Created by 熊鲁平 on 15/7/26.
//  Copyright (c) 2015年 熊鲁平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface NSString (TextFrame)
/**
 *  计算文字尺寸，在初始化控件的时候一定要设置文本的字体大小
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
@end
