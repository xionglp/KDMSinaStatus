//
//  CommonSettingController.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/21.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import "CommonSettingController.h"
#import "CommonSettingCell.h"
#import "CommonGroup.h"
#import "CommonItem.h"

@interface CommonSettingController ()

@end

@implementation CommonSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = TableViewBackgroundColor;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, -20, 0);
    
    NSMutableArray *groupsArray = [NSMutableArray array];
    self.groupsArray = groupsArray;
}

- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

#pragma mark - UITableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groupsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CommonGroup *group = self.groupsArray[section];
    return group.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonSettingCell *cell = [CommonSettingCell cellWithtableView:tableView];
    CommonGroup *group = self.groupsArray[indexPath.section];
    CommonItem *item = group.itemsArray[indexPath.row];
    cell.commonItem = item;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonGroup *group = self.groupsArray[indexPath.section];
    CommonItem *item = group.itemsArray[indexPath.row];
    if (item.destVcClass) {
        UIViewController *destVc = [[item.destVcClass alloc] init];
        destVc.title = item.title;
        [self.navigationController pushViewController:destVc animated:YES];
    }else if (item.operation){
        item.operation();
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    CommonGroup *groups = self.groupsArray[section];
    return groups.groupFooter;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CommonGroup *groups = self.groupsArray[section];
    return groups.groupHeader;
}

@end
