//
//  SearchBarTextField.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/7/31.
//  Copyright (c) 2015年 XLP. All rights reserved.
//

#import "DisSearchBarTF.h"

@implementation DisSearchBarTF

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //导航栏顶部搜索栏
        self.background = [UIImage resizableImage:@"searchbar_textfield_background"];
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = 30;
        imageView.height = self.height;
        imageView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        imageView.contentMode = UIViewContentModeCenter;
        self.leftView = imageView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.clearButtonMode = UITextFieldViewModeAlways;
    }
    return self;
}

+ (instancetype)searchBarTextField
{
    return [[self alloc] init];
}

@end
