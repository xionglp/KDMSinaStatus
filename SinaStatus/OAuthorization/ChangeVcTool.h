//
//  ChangeVcTool.h
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/12.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChangeVcTool : NSObject

/**
 *  判断是调到版本新特性还是调到tabbarController
 */
+ (void) jumpNewFeatureControllerOrTabBarController;

@end
