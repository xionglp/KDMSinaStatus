//
//  SettingViewController.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/21.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import "SettingViewController.h"
#import "TongYongViewController.h"
#import "CommonGroup.h"
#import "CommonItem.h"
#import "CommonItemArrow.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    
    CommonGroup *group1 = [CommonGroup group];
    CommonItemArrow *accout = [CommonItemArrow itemWithTitle:@"账号管理"];
    group1.itemsArray = @[accout];
    [self.groupsArray addObject:group1];
    
    CommonGroup *group2 = [CommonGroup group];
    CommonItemArrow *background = [CommonItemArrow itemWithTitle:@"主题，背景"];
    group2.itemsArray = @[background];
    [self.groupsArray addObject:group2];
    
    CommonGroup *group3 = [CommonGroup group];
    CommonItemArrow *notifa = [CommonItemArrow itemWithTitle:@"通知和提醒"];
    CommonItemArrow *setting = [CommonItemArrow itemWithTitle:@"通用设置"];
    setting.destVcClass = [TongYongViewController class];
    CommonItemArrow *secure = [CommonItemArrow itemWithTitle:@"隐私与安全"];
    group3.itemsArray = @[notifa,setting,secure];
    [self.groupsArray addObject:group3];
    
    CommonGroup *group4 = [CommonGroup group];
    CommonItemArrow *idea = [CommonItemArrow itemWithTitle:@"意见反馈"];
    CommonItemArrow *weibo = [CommonItemArrow itemWithTitle:@"关于微博"];
    group4.itemsArray = @[idea,weibo];
    [self.groupsArray addObject:group4];
    
    UIButton *logout = [[UIButton alloc] init];
    logout.titleLabel.font = [UIFont systemFontOfSize:15];
    [logout setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    [logout setTitleColor:SinaColor(255, 10, 10) forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizableImage:@"common_card_background"] forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizableImage:@"common_card_background_highlighted"] forState:UIControlStateHighlighted];
    
    // 3.设置尺寸(tableFooterView和tableHeaderView的宽度跟tableView的宽度一样)
    logout.height = 35;
    
    self.tableView.tableFooterView = logout;
}

@end
