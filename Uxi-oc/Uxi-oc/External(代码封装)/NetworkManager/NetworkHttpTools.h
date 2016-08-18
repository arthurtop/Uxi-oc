//
//  NetworkHttpTools.h
//  XLZMaxMester
//
//  Created by jecansoft on 16/6/20.
//  Copyright © 2016年 songlei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger, NetworkStatus){
    NetworkStatusUnknown                = -1,  //未知网络
    NetworkStatusNotReachable           = 0,   //没有网络
    NetworkStatusReachableViaWWAM       = 1,   //手机自带网络
    NetworkStatusReachableWiFi          = 2    //WiFi
    
};

//请求方式
typedef NS_ENUM(NSInteger , RequestType) {
    RequestTypeGET    = 0,   ///get请求
    RequestTypePOST   = 1    ///post请求
    
};


@class NSURLSessionTask;
// 请勿直接使用NSURLSessionDataTask,以减少对第三方的依赖
// 所有接口返回的类型都是基类NSURLSessionTask，若要接收返回值
// 且处理，请转换成对应的子类类型
typedef NSURLSessionTask XLZURLSessionTask;


//////请求返回 success fail  上传进度  下载进度
typedef void (^ XLZResponseSuccess)(id response);

typedef void (^ XLZResponseFail)(NSError *error);

typedef void (^ XLZUploadProgress)(int64_t bytesProgress, int64_t totalBytesProgress);

typedef void (^ XLZDownloadProgress)(int64_t buytesProgress, int64_t totalBytesProgress);



@interface NetworkHttpTools : NSObject

+ (void)updateBaseUrl:(NSString *)baseUrl;
+ (NSString *)baseUrl;


/**
 *   网络请求方法
 *
 */
@property (nonatomic, assign) RequestType requestType;

/**
 *  获取网络
 */
@property (nonatomic, assign) NetworkStatus networkStatus;

/**
 *  单例
 *
 *  @return
 */
+ (NetworkHttpTools *)sharedXLZNetworking;


/**
 *  方便管理请求任务。执行取消，暂停，继续等任务.
 *  - (void)cancel，取消任务
 *  - (void)suspend，暂停任务
 *  - (void)resume，继续任务
 */



/**
 *  开启网络监测
 */
+ (void)startMonitoring;


/**
 *  get请求方法,block回调
 *
 *  @param url     请求连接，根路径
 *  @param params  参数
 *  @param success 请求成功返回数据
 *  @param fail    请求失败
 *  @param showHUD 是否显示HUD
 */
+ (XLZURLSessionTask *)GETWithUrl:(NSString *)url params:(id)params success:(XLZResponseSuccess)success fail:(XLZResponseFail)fail showHUD:(BOOL)shoeHUD;



/**
 *  post请求方法,block回调
 *
 *  @param url     请求连接，根路径
 *  @param params  参数
 *  @param success 请求成功返回数据
 *  @param fail    请求失败
 *  @param showHUD 是否显示HUD
 */
+ (XLZURLSessionTask *)POSTWithUrl:(NSString *)url params:(id)params success:(XLZResponseSuccess)success fail:(XLZResponseFail)fail showHUD:(BOOL)showHUD;


/**
 *  上传图片方法
 *
 *  @param image      上传的图片
 *  @param url        请求连接，根路径
 *  @param filename   图片的名称(如果不传则以当时间命名)
 *  @param name       上传图片时填写的图片对应的参数
 *	@param mimeType		默认为image/jpeg
 *  @param params     参数
 *  @param progress   上传进度
 *  @param success    请求成功返回数据
 *  @param fail       请求失败
 *  @param showHUD    是否显示HUD
 */
+ (XLZURLSessionTask *)uploadWithImage:(UIImage *)image url:(NSString *)url fileName:(NSString *)fileName name:(NSString *)name params:(NSDictionary *)params progress:(XLZUploadProgress)progress success:(XLZResponseSuccess)success fail:(XLZResponseFail)fail showHUD:(BOOL)showHUD;


/**
 *
 *	上传文件操作
 *
 *	@param url						上传路径
 *	@param uploadingFile	待上传文件的路径
 *	@param progress			上传进度
 *	@param success				上传成功回调
 *	@param fail					上传失败回调
 *
 *	@return
 */
+ (XLZURLSessionTask *)uploadFileWithUrl:(NSString *)url uploadingFile:(NSString *)uploadingFile progress:(XLZUploadProgress)progress success:(XLZResponseSuccess)success fail:(XLZResponseFail)fail showHUD:(BOOL)showHUD;



/**
 *  下载文件方法
 *
 *  @param url           下载地址
 *  @param saveToPath    文件保存的路径,如果不传则保存到Documents目录下，以文件本来的名字命名
 *  @param progressBlock 下载进度回调
 *  @param success       下载完成
 *  @param fail          失败
 *  @param showHUD       是否显示HUD
 *  @return 返回请求任务对象，便于操作
 */
+ (XLZURLSessionTask *)downloadWithUrl:(NSString *)url saveToPath:(NSString *)saveToPath progress:(XLZDownloadProgress)progress success:(XLZResponseSuccess)success fail:(XLZResponseFail)fail showHUD:(BOOL)showHUD;












@end

