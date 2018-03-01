//
//  StatusPhotosView.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/17.
//  Copyright (c) 2015年 XLP. All rights reserved.
//  微博的配图相册（图片集）

#import "StatusPhotosView.h"
#import "StatusPictureview.h"
#import "UIImageView+WebCache.h"
#import "Photo.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface StatusPhotosView ()

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, assign) CGRect lastFrame;

@end

@implementation StatusPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //创建所有可能显示的view
        for (int i = 0; i < 9; i ++) {
            StatusPictureview *picView = [[StatusPictureview alloc] init];
            [self addSubview:picView];
            picView.tag = i;
            
            //在UIimageView上面添加一个手势
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPictureViewRecognizer:)];
            [picView addGestureRecognizer:recognizer];
        }
    }
    return self;
}

- (void) clickPictureViewRecognizer:(UITapGestureRecognizer *)recognizer
{
    //创建一个图片浏览器功能
    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
    
    //设置图片浏览器显示的所有图片
    NSMutableArray *photosArray = [NSMutableArray array];
    for (int i = 0; i < self.photoArray.count; i ++) {
        
        Photo *photo = self.photoArray[i];
        
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        //设置图片的路径
        mjphoto.url = [NSURL URLWithString:photo.bmiddle_pic];
        
        //设置图片的来源
        mjphoto.srcImageView = self.subviews[i];
        
        [photosArray addObject:mjphoto];
    }
    brower.currentPhotoIndex = recognizer.view.tag;
    brower.photos = photosArray;
    [brower show];
}


- (void)setPhotoArray:(NSArray *)photoArray
{
    _photoArray = photoArray;
    
    for (int i = 0; i < _photoArray.count; i ++) {
        StatusPictureview *picView = self.subviews[i];
        picView.photo = _photoArray[i];
        picView.hidden = NO;
    }
    
    //cell的循环利用，将多余的picView隐藏，有隐藏，就一定有显示
    for (NSUInteger i = self.photoArray.count; i < self.subviews.count; i++) {
        StatusPictureview *picView = self.subviews[i];
        picView.hidden = YES;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int i = 0; i < self.photoArray.count; i ++) {
        StatusPictureview *picView = self.subviews[i];
        picView.width = 70;
        picView.height = 70;
        //定义每行最多显示多少列
        int maxCols = 3;
        
        if (self.photoArray.count == 4) {
            maxCols = 2;
        }
        int picMargin = 10;
        NSUInteger col = i % maxCols;
        NSUInteger row = i / maxCols;
        picView.x = col * (picView.width + picMargin);
        picView.y = row * (picView.height + picMargin);
    }
    
}

/**
 *  根据图片的个数，返回相册的尺寸
 */
+ (CGSize)sizeWithPhotosCount:(NSUInteger)photosCount
{
    //每一张配图的尺寸
    CGFloat picW = 70;
    CGFloat picH = 70;
    //定义每行最多显示多少列
    int maxCols = 3;
    if (photosCount == 4) {
        maxCols = 2;
    }
    int picMargin = 10;
    //根据图片的个数计算出有多少行，列
    NSUInteger totalCol = photosCount >= 3 ? maxCols : photosCount; //列
    NSUInteger totalRow; //行
    if (photosCount % maxCols == 0) {
        totalRow = photosCount / maxCols;
    }else{
        totalRow = photosCount / maxCols + 1;
    }
    
    CGFloat photoW = totalCol * picW + (totalCol - 1) * picMargin;
    CGFloat photoH = totalRow * picH + (totalRow - 1) * picMargin;
    return CGSizeMake(photoW, photoH);
}

@end
