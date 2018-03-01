//
//  HomeController.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/7/30.
//  Copyright (c) 2015年 XLP. All rights reserved.
//  首页

#import "HomeViewController.h"
#import "HomeNavTitleBtn.h"
#import "HomeMenuView.h"
#import "Account.h"
#import "AccountTool.h"
#import "Status.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "MainHttpTool.h"
#import "StatusFrame.h"
#import "HomeStatusesCell.h"
#import "MBProgressHUD+MJ.h"
#import "TestViewController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,popmenuViewDelegate>
@property (nonatomic, strong) NSMutableArray *statusFrameArray;
@property (nonatomic, strong) HomeNavTitleBtn *navTitieBtn;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = TableViewBackgroundColor;
    //设置导航栏
    [self setUpNavigationBar];
    
    //下拉刷新
    [self headerRefresh];
    
    //上拉刷新加载更多数据
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.tableView.header.hidden = YES;
        [self footerLoadingMoreStatus];
    }];
    
    //设置用户昵称信息
    [self setUpUserInfo];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setupCustomRefersh];
}

- (void) headerRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.tableView.footer.hidden = YES;
        [self headerLoadingMoreStatus];
    }];
    [self.tableView.header beginRefreshing];
}

- (void) setupCustomRefersh
{
    self.tableView.header.hidden = NO;
    self.tableView.footer.hidden = NO;
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
}

#pragma mark  Setter/getter
- (NSMutableArray *)statusFrameArray
{
    if (_statusFrameArray == nil) {
        self.statusFrameArray = [NSMutableArray array];
    }
    return _statusFrameArray;
}

#pragma mark  网络请求数据
/**
 *  获取用户的昵称信息
 */
- (void) setUpUserInfo
{
    Account *account = [AccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    [MainHttpTool get:users_show params:params success:^(id responseObject) {
        User *user = [User objectWithKeyValues:responseObject];
        [self.navTitieBtn setTitle:user.name forState:UIControlStateNormal];
        //将user.name 存到沙盒中
        account.name = user.name;
        [AccountTool saveAccount:account];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"网络异常，请检查网络设置！"];
    }];
}

/**
 *  根据微博模型数组 转成 微博frame模型数据
 *
 *  @param statuses 微博模型数组
 *
 */
- (NSArray *)statusFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (Status *status in statuses) {
        StatusFrame *frame = [[StatusFrame alloc] init];
        // 传递微博模型数据，计算所有子控件的frame
        frame.status = status;
        [frames addObject:frame];
    }
    return frames;
}

/**
 *  下拉加载最新数据
 */
- (void) headerLoadingMoreStatus
{
    Account *account = [AccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    StatusFrame *firstStatus =  [self.statusFrameArray firstObject];
    if (firstStatus) {
        //since_id 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
        params[@"since_id"] = firstStatus.status.idstr;
    }
    [MainHttpTool get:statuses_friends params:params success:^(id responseObject) {
        
        [self setupCustomRefersh];
        
        NSArray *dictArray = [responseObject objectForKey:@"statuses"];
        //通过一个通过字典数组来创建一个模型数组
        NSArray *newStatusArray = [Status objectArrayWithKeyValuesArray:dictArray];
        
        // 获得最新的微博frame数组
        NSArray *newFrame = [self statusFramesWithStatuses:newStatusArray];

        //将新的数据查到旧的数据的最前面
        NSRange range = NSMakeRange(0, newFrame.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrameArray insertObjects:newFrame atIndexes:indexSet];
        [self.tableView reloadData];
        SinaLog(@"新数据的长度---%ld",newFrame.count);
        [self.tableView.header endRefreshing];
        //显示刷新的微博数
        [self showNewLoadingStatusCount:newFrame.count];
    } failure:^(NSError *error) {
        
        [self setupCustomRefersh];
        
        SinaLog(@"error:%@",error);
        [self.tableView.header endRefreshing];
        [MBProgressHUD showError:@"网络异常，请检查网络设置！"];
    }];
}

//上拉加载更多微博数据
- (void) footerLoadingMoreStatus
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AccountTool account].access_token;
    StatusFrame *lastStatus =  [self.statusFrameArray lastObject];
    if (lastStatus) {
        // max_id若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        params[@"max_id"] = @([lastStatus.status.idstr longLongValue] - 1);
    }
    [MainHttpTool get:statuses_home params:params success:^(id responseObject) {
        
        [self setupCustomRefersh];
         NSArray *statusDictArray = responseObject[@"statuses"];
         // 微博字典数组 ---> 微博对象数组
         NSArray *newStatuses = [Status objectArrayWithKeyValuesArray:statusDictArray];
        // 获得最新的微博frame数组
        NSArray *newFrame = [self statusFramesWithStatuses:newStatuses];

         // 将新数据插入到旧数据的最后面
         [self.statusFrameArray addObjectsFromArray:newFrame];
         [self.tableView reloadData];
         [self.tableView.footer endRefreshing];
    } failure:^(NSError *error) {
        
        [self setupCustomRefersh];
        SinaLog(@"error:%@",error);
        [MBProgressHUD showError:@"网络异常，请检查网络设置！"];
    }];
}

#pragma mark - 
/**
 *  点击tabbar，回到页面的顶部
 *
 *  @param formSelf 判断点击的是否自己控制器
 */
- (void) refresh:(BOOL) formSelf
{
    if (self.tabBarItem.badgeValue) { //有未读的微博数字
        //回到首页顶部，并且刷新数据
        [self headerRefresh];
    }else if (formSelf){ //没有数字
        // 让表格回到最顶部
        NSIndexPath *firstRow = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:firstRow atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void) showNewLoadingStatusCount:(NSInteger) count
{
    // 0.清零提醒数字
    [UIApplication sharedApplication].applicationIconBadgeNumber -= self.tabBarItem.badgeValue.intValue;
    self.tabBarItem.badgeValue = nil;
    
    UILabel *staCountLabel = [[UILabel alloc] init];
    //将控件加到导航控制器view上面，
    [self.navigationController.view insertSubview:staCountLabel belowSubview:self.navigationController.navigationBar];
    if (count == 0) {
        staCountLabel.text = @"没有最新微博数据";
    }else{
        staCountLabel.text = [NSString stringWithFormat:@"加载%ld条微博数据",count];
    }
    staCountLabel.textColor = [UIColor whiteColor];
    staCountLabel.textAlignment = NSTextAlignmentCenter;
    staCountLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    staCountLabel.width = self.view.width;
    staCountLabel.height = 35;
    staCountLabel.x = 0;
    staCountLabel.y = 64 - staCountLabel.height;
    CGFloat duration = 1.0;
    [UIView animateWithDuration:duration animations:^{
        staCountLabel.transform = CGAffineTransformMakeTranslation(0, staCountLabel.height);
    }completion:^(BOOL finished) {
        CGFloat delay = 1.0;
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            staCountLabel.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [staCountLabel removeFromSuperview];
        }];
    }];
}

/**
 *  设置导航栏上面的控件
 */
- (void) setUpNavigationBar
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageNamed:@"navigationbar_friendsearch" highlightImageName:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendSearch)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageNamed:@"navigationbar_pop" highlightImageName:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    //自定义导航栏 navigationItem.titleView 的样式
    HomeNavTitleBtn *navTitieBtn = [[HomeNavTitleBtn alloc] init];
    navTitieBtn.height = 35;
    NSString *name = [AccountTool account].name;
    [navTitieBtn setTitle:name ? name : @"首页" forState:UIControlStateNormal];
    [navTitieBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [navTitieBtn setBackgroundImage:[UIImage resizableImage:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    [navTitieBtn addTarget:self action:@selector(clickNavtitleButton:) forControlEvents:UIControlEventTouchUpInside];
//    navTitieBtn.width = 100;
    self.navTitieBtn = navTitieBtn;
    self.navigationItem.titleView = navTitieBtn;
}

- (void) clickNavtitleButton:(UIButton *)titleButton
{
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    HomeMenuView *popMenu = [HomeMenuView popmenuViewWithContentView:nil];
    [popMenu showInRect:CGRectMake(90, 55, 150, 200)];
    popMenu.delegate = self;
}

#pragma mark - popmenuViewDelegate
- (void)PopmenuDidDismiss:(HomeMenuView *)popmenu
{
    HomeNavTitleBtn *navTitieBtn = (HomeNavTitleBtn *)self.navigationItem.titleView;
    [navTitieBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}

#pragma mark - UITableViewDelegate,UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.tableView.footer.hidden = self.statusFrameArray.count == 0;
    return self.statusFrameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeStatusesCell *cell = [HomeStatusesCell cellWithTableView:tableView];
    StatusFrame *statusFrame = self.statusFrameArray[indexPath.row];
    cell.statusFrame = statusFrame;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusFrame *frame = self.statusFrameArray[indexPath.row];
    return frame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestViewController *newVc = [[TestViewController alloc] init];
    newVc.view.backgroundColor = [UIColor whiteColor];
    newVc.title = @"新控制器";
    [self.navigationController pushViewController:newVc animated:YES];
}

#pragma mark -

- (void) friendSearch
{
    SinaLog(@"friendSearch---");
}

-(void) pop
{
    SinaLog(@"pop----");
}

@end
