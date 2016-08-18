//
//  XLZAVCapController.m
//  Uxi-oc
//
//  Created by jecansoft on 16/8/17.
//  Copyright © 2016年 zyhl. All rights reserved.
//

#import "XLZAVCapController.h"
#import <AVFoundation/AVFoundation.h>
#import <objc/runtime.h>


@interface XLZAVCapController ()<AVCaptureMetadataOutputObjectsDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) AVCaptureSession *avSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *avPreviewLayer;


@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UIImageView *scanLineImgView;
@property (nonatomic, strong) NSTimer *scanLineTimer;


@end


@implementation XLZAVCapController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    // 初始化扫描框 界面
    
    
    
    // 扫描功能
    
    
    
    
}

- (void)initWithLoadQRreaderView{
    
    
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
