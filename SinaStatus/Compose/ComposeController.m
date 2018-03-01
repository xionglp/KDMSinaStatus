//
//  ComposeController.m
//  SinaStatus
//
//  Created by 熊鲁平 on 15/9/12.
//  Copyright (c) 2015年 XLP. All rights reserved.
//  发微博页面

#import "ComposeController.h"
#import "ComTextView.h"
#import "ComposeToolBar.h"
#import "ComPhotosView.h"
#import "AFNetworking.h"
#import "Account.h"
#import "AccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "MainHttpTool.h"
#import "EmotionKeyboard.h"

@interface ComposeController ()<UITextViewDelegate,ComposeToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) ComTextView *comTextView;
@property (nonatomic, strong) ComposeToolBar *composeToolBar;
@property (nonatomic, strong) ComPhotosView *photosView;
@property (nonatomic, assign,getter=isChangeKeyboard) BOOL changeKeyboard;
@property (nonatomic, strong) EmotionKeyboard *emotionKeyboard;

@end

@implementation ComposeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发微博";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismissComposeVc)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendStatus)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    //自定义带有占位文字的textView
    ComTextView *comTextView = [[ComTextView alloc] init];
    comTextView.frame = self.view.bounds;
    [self.view addSubview:comTextView];
    comTextView.placeholder = @"分享新鲜事...";
    self.comTextView = comTextView; //竖直方向上又弹簧效果,scrollViewWillBeginDragging方法才会调用
    comTextView.alwaysBounceVertical = YES;
    self.comTextView.delegate = self;
    
    //添加工具条
    ComposeToolBar *composeToolBar = [[ComposeToolBar alloc] init];
    composeToolBar.height = 44;
    composeToolBar.width = self.view.width;
    composeToolBar.delegate = self;
    self.composeToolBar = composeToolBar;
    composeToolBar.y = self.view.height - composeToolBar.height;
    [self.view addSubview:composeToolBar];
    //利用通知监听键盘的显示和退出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //在comTextView上面加一个图片集
    ComPhotosView *photosView = [[ComPhotosView alloc] init];
    [self.comTextView addSubview:photosView];
    self.photosView = photosView;
    photosView.width = self.comTextView.width;
    photosView.height = self.comTextView.height;
    photosView.y = 70;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //控制器的view显示完毕后，弹出键盘
    [self.comTextView becomeFirstResponder];
}

#pragma mark - setting/getting
- (EmotionKeyboard *)emotionKeyboard
{
    if (_emotionKeyboard == nil) {
        self.emotionKeyboard = [EmotionKeyboard keyboard];
        self.emotionKeyboard.width = self.view.width;
        self.emotionKeyboard.height = 252;
        self.emotionKeyboard.backgroundColor = [UIColor blueColor];
    }
    return _emotionKeyboard;
}

- (void)sendStatus {
    if (self.photosView.images.count) { //有图片，发表有图片的微博
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        Account *account = [AccountTool account];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"access_token"] = account.access_token;
        params[@"status"] = self.comTextView.text;
        
        // 3.发送POST请求
        [mgr POST:statuses_upload parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            UIImage *image = [self.photosView.images firstObject];
            //将图片转成NSdata
            NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
            //拼接文件参数
            [formData appendPartWithFileData:imageData name:@"pic" fileName:@"status.jpg" mimeType:@"image/jpeg"];
            
        } success:^(AFHTTPRequestOperation *operation, NSDictionary *statusDict) {
            [MBProgressHUD showSuccess:@"发表成功"];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [MBProgressHUD showError:@"发表失败"];
        }];
    }else{ //发表没有图片的微博
        Account *account = [AccountTool account];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"access_token"] = account.access_token;
        params[@"status"] = self.comTextView.text;
        [MainHttpTool post:statuses_update params:params success:^(id responseObject) {
            [MBProgressHUD showSuccess:@"发表成功"];
        } failure:^(NSError *error) {
            [MBProgressHUD showError:@"发表失败"];
            NSLog(@"error:%@",error);
        }];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 键盘的操作
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) keyboardWillShow:(NSNotification *)noto
{
    CGFloat duration = [noto.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        
        CGRect transformRect = [noto.userInfo[UIKeyboardBoundsUserInfoKey] CGRectValue];
        self.composeToolBar.transform = CGAffineTransformMakeTranslation(0, -transformRect.size.height);
    }];
}

- (void) keyboardWillHide:(NSNotification *)noto
{
//    if (self.isChangeKeyboard) {//切换键盘，为了让toolBar不改变位子，直接return
//        self.changeKeyboard = NO;
//        return;
//    }
    CGFloat duration = [noto.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.composeToolBar.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - UITextViewDelegate
/**
 *  当用户开始拖拽scrollView时调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //结束编辑，退出键盘
    [self.comTextView endEditing:YES];
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = (self.comTextView.text.length != 0);
}

#pragma mark - ComposeToolBarDelegate
- (void)ComposeToolBar:(ComposeToolBar *)toolBar DidClickToolBarButton:(ComposeToolbarButtonType)type
{
    switch (type) {
        case ComposeToolbarButtonTypeCamera:
            [self openCamera]; //打开照相机
            break;
        case ComposeToolbarButtonTypePicture:
            [self openAlbum];  //打开相册
            break;
        case ComposeToolbarButtonTypeMention:
            NSLog(@"提到@");  //提到@
            break;
        case ComposeToolbarButtonTypeTrend:
            NSLog(@"话题");  //话题
            break;
        case ComposeToolbarButtonTypeEmotion:
            [self setEmotionKeyboard];  //表情
            break;
        default:
            break;
    }
}

- (void) setEmotionKeyboard
{
    //切换键盘
//    self.changeKeyboard = YES;
    if (self.comTextView.inputView){ //当前显示的是自定义的键盘，切换到系统自带的键盘
        self.comTextView.inputView = nil;
        
        //显示表情图片的按钮
        self.composeToolBar.showEmotion = YES;
    }else{
        self.comTextView.inputView = self.emotionKeyboard;
        
        self.composeToolBar.showEmotion = NO; //显示键盘图片按钮
    }
    
    [self.comTextView resignFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.comTextView becomeFirstResponder];
    });
}

/**
 *  打开照相机
 */
- (void) openCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        SinaLog(@"模拟器照相机功能不能用");
        return;
    };
    UIImagePickerController *imagepickerVc = [[UIImagePickerController alloc] init];
    imagepickerVc.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagepickerVc.delegate = self;
    [self presentViewController:imagepickerVc animated:YES completion:nil];
}

/**
 *  打开相册
 */
- (void) openAlbum
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    UIImagePickerController *imagepickerVc = [[UIImagePickerController alloc] init];
    imagepickerVc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagepickerVc.delegate = self;
    [self presentViewController:imagepickerVc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.photosView addImage:info[UIImagePickerControllerOriginalImage]];
}

- (void)dismissComposeVc {
    [self.comTextView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
