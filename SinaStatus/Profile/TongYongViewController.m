//
//  TongYongViewController.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/21.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import "TongYongViewController.h"
#import "PictureViewController.h"
#import "CommonGroup.h"
#import "CommonItem.h"
#import "CommonItemArrow.h"
#import "CommonItemSwitch.h"
#import "CommonItemLabel.h"

@interface TongYongViewController ()

@end

@implementation TongYongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CommonGroup *group1 = [CommonGroup group];
    CommonItemLabel *readMode = [CommonItemLabel itemWithTitle:@"阅读模式"];
    readMode.text = @"有图模式";
    CommonItemLabel *textFont = [CommonItemLabel itemWithTitle:@"账号管理"];
    textFont.text = @"大";
    CommonItemSwitch *remark = [CommonItemSwitch itemWithTitle:@"显示备注"];
    group1.itemsArray = @[readMode,textFont,remark];
    [self.groupsArray addObject:group1];
    
    CommonGroup *group2 = [CommonGroup group];
    CommonItemArrow *picture = [CommonItemArrow itemWithTitle:@"图片质量设置"];
    picture.destVcClass = [PictureViewController class];
    group2.itemsArray = @[picture];
    [self.groupsArray addObject:group2];
    
    CommonGroup *group3 = [CommonGroup group];
    CommonItemSwitch *voice = [CommonItemSwitch itemWithTitle:@"声音"];
    group3.itemsArray = @[voice];
    [self.groupsArray addObject:group3];
    
    CommonGroup *group4 = [CommonGroup group];
    CommonItemLabel *language = [CommonItemLabel itemWithTitle:@"多语言环境"];
    language.text = @"跟随系统";
    group4.itemsArray = @[language];
    [self.groupsArray addObject:group4];
    
    CommonGroup *group5 = [CommonGroup group];
    CommonItemArrow *picCache = [CommonItemArrow itemWithTitle:@"清除图片缓存"];
    CommonItemArrow *history = [CommonItemArrow itemWithTitle:@"清空搜索历史"];
    group5.itemsArray = @[picCache,history];
    [self.groupsArray addObject:group5];
}

@end
