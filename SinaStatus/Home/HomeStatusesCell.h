//
//  HomeStatusesCell.h
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/16.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StatusFrame;

@interface HomeStatusesCell : UITableViewCell

@property (nonatomic, strong) StatusFrame *statusFrame;

+(instancetype) cellWithTableView:(UITableView *)tableView;

@end
