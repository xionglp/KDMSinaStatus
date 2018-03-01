//
//  ProfileController.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/7/30.
//  Copyright (c) 2015年 XLP. All rights reserved.
//  我，个人信息

#import "ProfileController.h"
#import "MoreViewController.h"
#import "SettingViewController.h"
#import "CommonSettingCell.h"
#import "CommonGroup.h"
#import "CommonItem.h"
#import "CommonItemArrow.h"

@interface ProfileController ()

@end

@implementation ProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
    
    CommonGroup *group1 = [CommonGroup group];
    CommonItem *newFriend = [CommonItem itemWithTitle:@"新的好友" icon:@"new_friend"];
    newFriend.badgeValue = @"3";
    CommonItemArrow *vip = [CommonItemArrow itemWithTitle:@"微博等级" icon:@"vip"];
    group1.itemsArray = @[newFriend,vip];
    [self.groupsArray addObject:group1];
    
    CommonGroup *group2 = [CommonGroup group];
    CommonItemArrow *photo = [CommonItemArrow itemWithTitle:@"我的相册" icon:@"album"];
    CommonItemArrow *like = [CommonItemArrow itemWithTitle:@"我的赞" icon:@"like"];
    CommonItemArrow *collect = [CommonItemArrow itemWithTitle:@"我的点评" icon:@"collect"];
    group2.itemsArray = @[photo,like,collect];
    [self.groupsArray addObject:group2];
    
    CommonGroup *group3 = [CommonGroup group];
    CommonItemArrow *draft = [CommonItemArrow itemWithTitle:@"草稿箱" icon:@"draft"];
    CommonItemArrow *pay = [CommonItemArrow itemWithTitle:@"微博支付" icon:@"pay"];
    CommonItemArrow *more = [CommonItemArrow itemWithTitle:@"更多" icon:@"card"];
    more.destVcClass = [MoreViewController class];
    group3.itemsArray = @[draft,pay,more];
    [self.groupsArray addObject:group3];
}

- (void) setting
{
    SettingViewController *settingVc = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingVc animated:YES];
}

@end
