//
//  DiscoverController.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/7/30.
//  Copyright (c) 2015年 XLP. All rights reserved.
//  广场，发现

#import "DiscoverController.h"
#import "DisSearchBarTF.h"
#import "CommonSettingCell.h"
#import "CommonGroup.h"
#import "CommonItem.h"
#import "CommonItemArrow.h"
#import "CommonItemSwitch.h"
#import "CommonItemLabel.h"
#import "CommonItemCheck.h"
#import "AppViewController.h"

@interface DiscoverController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *groupSArray;
@property (nonatomic, strong) DisSearchBarTF *searchBar;

@end

@implementation DiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //导航栏顶部搜索栏
    DisSearchBarTF *searchBar = [DisSearchBarTF searchBarTextField];
    searchBar.width = self.view.frame.size.width - 20;
    searchBar.height = 30;
    self.navigationItem.titleView = searchBar;
    self.searchBar = searchBar;
    
    //设置tableViewcell的样式数据
    [self setupTableViewStyleData];
    
    self.tableView.backgroundColor = TableViewBackgroundColor;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, -20, 0);
}

- (NSMutableArray *)groupSArray
{
    if (_groupSArray == nil) {
        _groupSArray = [NSMutableArray array];
    }
    return _groupSArray;
}

- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void) setupTableViewStyleData
{
    //创建一个组（section）
    CommonGroup *group1 = [CommonGroup group];
    group1.groupHeader = @"第0组的组头";
    group1.groupFooter = @"第0组的组尾";
    //每一组的item（row）
    CommonItemArrow *hotItem = [CommonItemArrow itemWithTitle:@"热门微博" subTitle:@"笑话，娱乐，神最右都搬到这啦" icon:@"hot_status"];
    hotItem.badgeValue = @"1001";
    CommonItemArrow *findItem = [CommonItemArrow itemWithTitle:@"找人" subTitle:@"名人、有意思的人尽在这里" icon:@"find_people"];
    findItem.destVcClass = [AppViewController class];
    group1.itemsArray = @[hotItem,findItem];
    //将这组添加到一个数组中
    [self.groupSArray addObject:group1];
    
    CommonGroup *group2 = [CommonGroup group];
    CommonItemSwitch *gameItem = [CommonItemSwitch itemWithTitle:@"游戏中心" icon:@"game_center"];
    CommonItemSwitch *nearItem = [CommonItemSwitch itemWithTitle:@"周边" icon:@"near"];
    CommonItemLabel *appItem = [CommonItemLabel itemWithTitle:@"应用" icon:@"app"];
    appItem.text = @"测试文字";
    group2.itemsArray = @[gameItem,nearItem,appItem];
    [self.groupSArray addObject:group2];
    
    CommonGroup *group3 = [CommonGroup group];
    CommonItem *videoItem = [CommonItem itemWithTitle:@"视频" icon:@"video"];
    videoItem.badgeValue = @"(10)";
    CommonItemCheck *musicItem = [CommonItemCheck itemWithTitle:@"音乐" icon:@"music"];
    CommonItem *movieItem = [CommonItem itemWithTitle:@"电影" icon:@"movie"];
    CommonItem *castItem = [CommonItem itemWithTitle:@"播客" icon:@"cast"];
    castItem.operation = ^{
        NSLog(@"点击-----博客");
    };
    CommonItem *moreItem = [CommonItem itemWithTitle:@"更多" icon:@"more"];
    group3.itemsArray = @[videoItem,musicItem,movieItem,castItem,moreItem];
    [self.groupSArray addObject:group3];
}

#pragma mark - UITableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groupSArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CommonGroup *group = self.groupSArray[section];
    return group.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonSettingCell *cell = [CommonSettingCell cellWithtableView:tableView];
    CommonGroup *group = self.groupSArray[indexPath.section];
    CommonItem *item = group.itemsArray[indexPath.row];
    cell.commonItem = item;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonGroup *group = self.groupSArray[indexPath.section];
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
    CommonGroup *groups = self.groupSArray[section];
    return groups.groupFooter;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CommonGroup *groups = self.groupSArray[section];
    return groups.groupHeader;
}

/**
 *  @param scrollView tableView继承自scrollview，当tableView拖动时，将键盘退出第一响应
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}

@end
