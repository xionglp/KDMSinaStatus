//
//  DiscoverCell.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/18.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import "CommonSettingCell.h"
#import "CommonItem.h"
#import "CommonItemArrow.h"
#import "CommonItemSwitch.h"
#import "CommonItemLabel.h"
#import "NSString+TextFrame.h"
#import "BadgeValueView.h"
#import "CommonItemCheck.h"

@interface CommonSettingCell ()
/** 箭头 */
@property (nonatomic, strong) UIImageView *arrowView;
/** 开关 */
@property (nonatomic, strong) UISwitch *switchView;
/** 文字 */
@property (nonatomic, strong) UILabel *textView;
/** 提醒数字 */
@property (nonatomic, strong) BadgeValueView *badgeView;
/** 打钩图片 */
@property (nonatomic, strong) UIImageView *checkView;

@end

@implementation CommonSettingCell

#pragma mark - init私有方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont boldSystemFontOfSize:14];
        self.detailTextLabel.font = [UIFont systemFontOfSize:11];
    }
    return self;
}

+ (instancetype) cellWithtableView:(UITableView *)tableView
{
    static NSString *ID = @"discoverID";
    CommonSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CommonSettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 5;
}

- (void)setCommonItem:(CommonItem *)commonItem
{
    _commonItem = commonItem;
    if (commonItem.badgeValue) {
        self.badgeView.badgeValue = commonItem.badgeValue;
        self.accessoryView = self.badgeView;
        
    }else if ([commonItem isKindOfClass:[CommonItemArrow class]]) {
        self.accessoryView = self.arrowView;
    }else if ([commonItem isKindOfClass:[CommonItemSwitch class]]){
        self.accessoryView = self.switchView;
    }else if ([commonItem isKindOfClass:[CommonItemLabel class]]){
        //设置文字
        CommonItemLabel *labelItem = (CommonItemLabel *)commonItem;
        self.textView.text = labelItem.text;
        self.textView.size = [NSString sizeWithText:labelItem.text font:self.textView.font maxSize:CGSizeMake(200, 20)];
        self.accessoryView = self.textView;
    } else if ([commonItem isKindOfClass:[CommonItemCheck class]]){
        self.accessoryView = self.checkView;
    }else{
        self.accessoryView = nil;
    }
    self.textLabel.text = commonItem.title;
    self.detailTextLabel.text = commonItem.subTitle;
    self.imageView.image = [UIImage imageNamed:commonItem.icon];
}

#pragma mark - 懒加载方法
- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        //这样创建出来的图片尺寸就是当前图片的大小
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _arrowView;
}

- (UIImageView *)checkView
{
    if (_checkView == nil) {
        _checkView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_checkmark"]];
    }
    return _checkView;
}

- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
    }
    return _switchView;
}

- (UILabel *)textView
{
    if (_textView == nil) {
        _textView = [[UILabel alloc] init];
        self.textView.textColor = [UIColor lightGrayColor];
        self.textView.font = [UIFont systemFontOfSize:13];
    }
    return _textView;
}

- (BadgeValueView *)badgeView
{
    if (_badgeView == nil) {
        _badgeView = [[BadgeValueView alloc] init];
    }
    return _badgeView;
}

@end
