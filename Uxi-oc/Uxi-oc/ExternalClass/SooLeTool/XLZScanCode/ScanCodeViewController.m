//
//  ScanCodeViewController.m
//  Uxi-oc
//
//  Created by jecansoft on 16/9/6.
//  Copyright © 2016年 zyhl. All rights reserved.
//

#import "ScanCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ShadowView.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define customShowSize CGSizeMake(200, 200);



@interface ScanCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>

/** 输入数据源 */
@property (nonatomic, strong) AVCaptureDeviceInput *avCapIntput;

/** 输出数据源 */
@property (nonatomic, strong) AVCaptureMetadataOutput *avCapOutput;

/** 输入输出的中间桥梁 负责把捕获的音视频数据输出到输出设备中 */
@property (nonatomic, strong) AVCaptureSession *avCapSession;

/** 相机拍摄预览图层 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *avCapLayerView;

/** 预览图层尺寸 */
@property (nonatomic, assign) CGSize layerViewSize;

/** 有效扫码范围 */
@property (nonatomic, assign) CGSize showSize;

/** 自定义的View视图 */
@property (nonatomic, strong) ShadowView *shadowView;


@end


@implementation ScanCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //显示范围
    self.showSize = customShowSize;
    //调用
    [self creatScanQRcode];
    
    //添加拍摄图层
    [self.view.layer addSublayer:self.avCapLayerView];
    
    //开始扫描二维码
    [self.avCapSession startRunning];
    
    //设置可用扫码范围
    [self allowScanRect];
    
    //添加上层影阴视图
    self.shadowView = [[ShadowView alloc]initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64)];
    [self.view addSubview:self.shadowView];
    self.shadowView.showSize = self.showSize;
    
    //添加扫描相册按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册中选" style:UIBarButtonItemStylePlain target:self action:@selector(takeQRCodeFromPicture:)];
    
    
    
}


#pragma mark - 创建二维码 扫描
- (void)creatScanQRcode{
    
    /** 创建输入数据源 **/
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.avCapIntput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    /** 创建输出数据源 */
    self.avCapOutput = [[AVCaptureMetadataOutput alloc]init];
    [self.avCapOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    
    /* session设置  */
    self.avCapSession = [[AVCaptureSession alloc]init];
    [self.avCapSession setSessionPreset:AVCaptureSessionPresetHigh];
    [self.avCapSession addInput:self.avCapIntput];
    [self.avCapSession addOutput:self.avCapOutput];
    
    //设置扫码支付的编码的格式
    self.avCapOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeFace,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeUPCECode];
    
    
    /** 扫码视图  **/
        //扫描框的位置和大小
    self.avCapLayerView = [AVCaptureVideoPreviewLayer layerWithSession:self.avCapSession];
    self.avCapLayerView.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.avCapLayerView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64);
    
    //将扫描框大小定义为属性 下面会有调用
    self.layerViewSize = CGSizeMake(self.avCapLayerView.frame.size.width, self.avCapLayerView.frame.size.height);
    
    
}

#pragma mark - 实现代理方法 完成二维码扫描
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if (metadataObjects.count > 0) {
        //停止动画
        [self.shadowView stopTimer];
        
        //停止扫描
        [self.avCapSession startRunning];
        
        AVMetadataMachineReadableCodeObject *metaObject = [metadataObjects objectAtIndex:0];
        //输出扫描的字符串
        XLZLog(@"输出字符串:%@",metaObject.stringValue);
        
        [self.avCapSession stopRunning];
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@", metaObject.stringValue] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    }
}


#pragma mark - 配置扫码范围
- (void)allowScanRect{
    
    /** 扫描是默认是横屏, 原点在[右上角]
     *  rectOfInterest = CGRectMake(0, 0, 1, 1);
     *  AVCaptureSessionPresetHigh = 1920×1080   摄像头分辨率
     *  需要转换坐标 将屏幕与 分辨率统一
     */
    
    //剪切出需要的大小位置
    CGRect shearRect = CGRectMake((self.layerViewSize.width - self.showSize.width) / 2,(self.layerViewSize.height - self.showSize.height) / 2,self.showSize.height,self.showSize.height);
    
    CGFloat deviceProportion = 1920.0 / 1080.0;
    CGFloat screecProportion = self.layerViewSize.height/self.layerViewSize.width;
    
    
    //分辨率 > 屏幕比（相当于屏幕的高不够）
    if (deviceProportion > screecProportion) {
        //换算出 分辨率比 对应的 屏幕高
        CGFloat finalHeight = self.layerViewSize.width * deviceProportion;
        
        //得到 偏差值
        CGFloat addNum = (finalHeight - self.layerViewSize.height)/2;
        
        // (对应的实际位置 + 偏差值)  /  换算后的屏幕高
        self.avCapOutput.rectOfInterest = CGRectMake((shearRect.origin.y + addNum) / finalHeight,
                                                shearRect.origin.x / self.layerViewSize.width,
                                                shearRect.size.height/ finalHeight,
                                                shearRect.size.width/ self.layerViewSize.width);
    }else{
        CGFloat finalWidth = self.layerViewSize.height/deviceProportion;
        
        CGFloat addNum = (finalWidth - self.layerViewSize.width)/2;
        
        self.avCapOutput.rectOfInterest = CGRectMake(shearRect.origin.y / self.layerViewSize.height,
                                                     (shearRect.origin.x + addNum) / finalWidth,
                                                     shearRect.size.height / self.layerViewSize.height,
                                                     shearRect.size.width / finalWidth);
    }
    
}


#pragma mark - 读取相册的图片二维码
- (void)takeQRCodeFromPicture:(UIBarButtonItem *)barButtonItem{
    
    if ([[[UIDevice currentDevice]systemVersion]doubleValue] < 8) {
        UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请更新系统至8.0以上!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alerView show];
        
    }else{
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController *pickerCtl = [[UIImagePickerController alloc]init];
            pickerCtl.delegate = self;
            pickerCtl.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            
            [self presentViewController:pickerCtl animated:YES completion:nil];
            
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"设备不支持访问相册，请在设置->隐私->照片中进行设置！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取选择的图片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    
    //初始化一个监视器
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
    [picker dismissViewControllerAnimated:YES completion:^{
       //检测到的结果数组  防止识别完之后的数据
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
        //判断是否有数据（是否是二维码）
        if (features.count >= 1) {
            /** 结果对象 **/
            CIQRCodeFeature *feature = [features objectAtIndex:0];
            NSString *scannedResult = feature.messageString;
            
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:scannedResult delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else{
            
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该图片没有包含二维码！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            
        }
    }];
}




#pragma mark - alerView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
        [self.avCapSession startRunning];
        [self.shadowView startTimer];
    }else{
        
        [self.avCapSession startRunning];
        [self.shadowView startTimer];
    }
}


- (void)creatAlertViewTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id /*<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles{
    if (kiOS8Later) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:otherButtonTitles style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.avCapSession startRunning];
            [self.shadowView startTimer];
            
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [self.avCapSession startRunning];
            [self.shadowView startTimer];
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
        [alertView show];
        
    }
    
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
