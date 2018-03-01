//
//  PictureViewController.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/21.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import "PictureViewController.h"
#import "CommonGroup.h"
#import "CommonItem.h"
#import "CommonItemArrow.h"
#import "CommonItemSwitch.h"
#import "CommonItemLabel.h"
#import "CommonItemCheck.h"

@interface PictureViewController ()

@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CommonGroup *group1 = [CommonGroup group];
    group1.groupHeader = @"上传图片质量";
    group1.groupFooter = @"建议在网速较快情况下上传高清图片";
    CommonItem *readMode = [CommonItem itemWithTitle:@"高清"];
    CommonItemCheck *textFont = [CommonItemCheck itemWithTitle:@"标清"];
    group1.itemsArray = @[readMode,textFont];
    [self.groupsArray addObject:group1];
    
    CommonGroup *group2 = [CommonGroup group];
    group2.groupHeader = @"下载图片质量";
    group2.groupFooter = @"建议在网速较快情况下下载高清图片";
    CommonItem *gaoqing = [CommonItem itemWithTitle:@"高清"];
    CommonItemCheck *biaoqing = [CommonItemCheck itemWithTitle:@"标清"];
    group2.itemsArray = @[gaoqing,biaoqing];
    [self.groupsArray addObject:group2];
}

@end
