//
//  DiscoverCell.h
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/18.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommonItem;

@interface CommonSettingCell : UITableViewCell
/**
 *  将commonItem对象传进来，重写settet方法，
 */
@property (nonatomic, strong) CommonItem *commonItem;

+ (instancetype) cellWithtableView:(UITableView *)tableView;

@end
