//
//  MoreViewController.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/21.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import "MoreViewController.h"
#import "CommonGroup.h"
#import "CommonItem.h"
#import "CommonItemArrow.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CommonGroup *group1 = [CommonGroup group];
    CommonItemArrow *lottery = [CommonItemArrow itemWithTitle:@"微博彩票" icon:@"lottery"];
    CommonItemArrow *car = [CommonItemArrow itemWithTitle:@"微博汽车" icon:@"car"];
    group1.itemsArray = @[lottery,car];
    [self.groupsArray addObject:group1];
    
    CommonGroup *group2 = [CommonGroup group];
    CommonItemArrow *recommend = [CommonItemArrow itemWithTitle:@"推荐" icon:@"recommend"];
    CommonItemArrow *shop = [CommonItemArrow itemWithTitle:@"购物" icon:@"shop"];
    CommonItemArrow *tour = [CommonItemArrow itemWithTitle:@"飞行" icon:@"tour"];
    group2.itemsArray = @[recommend,shop,tour];
    [self.groupsArray addObject:group2];
    
    CommonGroup *group3 = [CommonGroup group];
    CommonItemArrow *read = [CommonItemArrow itemWithTitle:@"阅读" icon:@"read"];
    CommonItemArrow *news = [CommonItemArrow itemWithTitle:@"新闻" icon:@"news"];
    CommonItemArrow *food = [CommonItemArrow itemWithTitle:@"食物" icon:@"food"];
    group3.itemsArray = @[read,news,food];
    [self.groupsArray addObject:group3];
}


@end
