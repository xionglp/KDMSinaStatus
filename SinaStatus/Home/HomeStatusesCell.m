//
//  HomeStatusesCell.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/16.
//  Copyright (c) 2015年 XLP. All rights reserved.
//  微博详情的cell
//  分成俩大块 （微博的具体内容 + 微博底部的工具条）

#import "HomeStatusesCell.h"
#import "StatusDetailView.h"
#import "StatusToolBar.h"
#import "StatusFrame.h"

@interface HomeStatusesCell ()
@property (nonatomic, strong) StatusDetailView *detailView;
@property (nonatomic, strong) StatusToolBar *statusTool;

@end

@implementation HomeStatusesCell

+(instancetype) cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"HomeCellID";
    HomeStatusesCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[HomeStatusesCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //微博详情View
        self.detailView = [[StatusDetailView alloc] init];
        [self.contentView addSubview:self.detailView];
        
        //微博底部工具条
        self.statusTool = [[StatusToolBar alloc] init];
        [self.contentView addSubview:self.statusTool];
    }
    return self;
}

- (void)setStatusFrame:(StatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    //微博详情的fame
    self.detailView.statusframe = statusFrame;
    
    //微博底部工具条frame
    self.statusTool.frame = statusFrame.statusToolFrame;
    self.statusTool.status = statusFrame.status;
}

@end
