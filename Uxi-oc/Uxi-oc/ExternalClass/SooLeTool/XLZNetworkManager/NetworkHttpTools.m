//
//  NetworkHttpTools.m
//  XLZMaxMester
//
//  Created by jecansoft on 16/6/20.
//  Copyright © 2016年 songlei. All rights reserved.
//

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...);
#endif

#define BaseUrlStr @"http://apistore.baidu.com/"   ///基础url

#import "NetworkHttpTools.h"

static NSString *sg_privateNetworkBaseUrl = nil;

static NSMutableArray *tasksArray;


@interface NetworkHttpTools()

@end

@implementation NetworkHttpTools


+ (void)updateBaseUrl:(NSString *)baseUrl{
    sg_privateNetworkBaseUrl = baseUrl;
}

+ (NSString *)baseUrl{
    return sg_privateNetworkBaseUrl;
}



#pragma mark - networking share
+ (NetworkHttpTools *)sharedXLZNetworking{
    static NetworkHttpTools *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[NetworkHttpTools alloc]init];
        
    });
    return handler;
}


+ (NSMutableArray *)tasksArray{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DLog(@"创建数组")
        tasksArray = [[NSMutableArray alloc]init];
    });
    return tasksArray;
}



#pragma mark - GET  and   POST
+ (XLZURLSessionTask *)GETWithUrl:(NSString *)url params:(id)params success:(XLZResponseSuccess)success fail:(XLZResponseFail)fail showHUD:(BOOL)showHUD{
    return [self baseRequestType:RequestTypeGET url:url params:params success:success fail:fail showHUD:showHUD];
}

+ (XLZURLSessionTask *)POSTWithUrl:(NSString *)url params:(id)params success:(XLZResponseSuccess)success fail:(XLZResponseFail)fail showHUD:(BOOL)showHUD{
    
    return [self baseRequestType:RequestTypePOST url:url params:params success:success fail:fail showHUD:showHUD];
}



#pragma mark - GET and  POST 请求
+ (XLZURLSessionTask *)baseRequestType:(RequestType)type url:(NSString *)url params:(id)params success:(XLZResponseSuccess)success fail:(XLZResponseFail)fail showHUD:(BOOL)showHUD{
    DLog(@"")
    if (url == nil) {
        return nil;
    }else{
        url = [NSString stringWithFormat:@"%@%@",BaseUrlStr,url];
    }
    
    if (showHUD == YES) {
        [SVProgressHUD show];
    }
    
    ///检查地址是否有中文
    NSString *urlstr = [NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    
    AFHTTPSessionManager *manager = [self getAFNManager];
    XLZURLSessionTask *sessionTask = nil;
    if (type == RequestTypeGET) {
        sessionTask = [manager GET:urlstr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (success) {
                success(responseObject);
            }
            
            [[self tasksArray]removeObject:sessionTask];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (fail) {
                fail(error);
            }
            
            [[self tasksArray]removeObject:sessionTask];
            
        }];
        
        if (showHUD == YES) {
            [SVProgressHUD dismiss];
        }
        
    }else{
        sessionTask = [manager POST:urlstr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (fail) {
                fail(error);
                
            }
        }];
        
        if (showHUD == YES) {
            [SVProgressHUD dismiss];
        }
    }
    
    if (sessionTask) {
        [[self tasksArray]addObject:sessionTask];
    }
    
    return sessionTask;
}


#pragma mark - 上传图片 mimeType:@"image/jpeg"
+ (XLZURLSessionTask *)uploadWithImage:(UIImage *)image url:(NSString *)url fileName:(NSString *)fileName name:(NSString *)name params:(NSDictionary *)params progress:(XLZUploadProgress)progress success:(XLZResponseSuccess)success fail:(XLZResponseFail)fail showHUD:(BOOL)showHUD{
    
    if (url == nil) {
        return nil;
    }else{
        url = [NSString stringWithFormat:@"%@%@",BaseUrlStr,url];
    }
    
    if (showHUD == YES) {
        [SVProgressHUD show];
    }
    
    NSString *urlstr = [NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    
    AFHTTPSessionManager *manager = [self getAFNManager];
    
    XLZURLSessionTask *sessionTask = [manager POST:urlstr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        ///压缩图片
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        
        NSString *imageFileName = fileName;
        if (fileName == nil || ![fileName isKindOfClass:[NSString class]] || fileName.length == 0) {
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            imageFileName = [NSString stringWithFormat:@"%@.jpg",str];
            
        }
        
        //上传图片，以文件的格式
        [formData appendPartWithFileData:imageData name:imageFileName fileName:name mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        DLog(@"上传进度--:%lld,总进度:%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        if (progress) {
            progress(uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"上传成功=%@",responseObject);
        if (success) {
            success(responseObject);
        }
        [[self tasksArray]removeObject:sessionTask];
        
        if (showHUD == YES) {
            [SVProgressHUD dismiss];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"error:%@",error)
        if (fail) {
            fail(error);
        }
        
        [[self tasksArray]removeObject:sessionTask];
        if (showHUD == YES) {
            [SVProgressHUD dismiss];
        }
        
    }];
    
    if (sessionTask) {
        [[self tasksArray]addObject:sessionTask];
    }
    
    return sessionTask;
}


#pragma mark - 下载文件 等
+ (XLZURLSessionTask *)downloadWithUrl:(NSString *)url saveToPath:(NSString *)saveToPath progress:(XLZDownloadProgress)progress success:(XLZResponseSuccess)success fail:(XLZResponseFail)fail showHUD:(BOOL)showHUD{
    
    DLog(@"")
    if (url == nil) {
        return nil;
    }else{
        url = [NSString stringWithFormat:@"%@%@",BaseUrlStr,url];
    }
    
    if (showHUD == YES) {
        [SVProgressHUD show];
    }
    
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    AFHTTPSessionManager *manager = [self getAFNManager];
    XLZURLSessionTask *sessionTask = nil;
    sessionTask = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        //回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progress) {
                progress(downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
            }
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        if (!saveToPath) {
            NSURL *downloadURL = [[NSFileManager defaultManager]URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            DLog(@"默认路径--%@",downloadURL);
            return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
        }else{
            return [NSURL fileURLWithPath:saveToPath];
        }
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        DLog(@"下载文件成功")
        [[self tasksArray]removeObject:sessionTask];
        if (error == nil) {
            if (success) {
                success([filePath path]);
            }
        }else{
            if (fail) {
                fail(error);
            }
        }
        
        if (showHUD == YES) {
            [SVProgressHUD dismiss];
        }
    }];
    
    ///开始启动任务
    [sessionTask resume];
    if (sessionTask) {
        [[self tasksArray]addObject:sessionTask];
    }
    
    return sessionTask;
}

#pragma mark - 上传文件
+ (XLZURLSessionTask *)uploadFileWithUrl:(NSString *)url uploadingFile:(NSString *)uploadingFile progress:(XLZUploadProgress)progress success:(XLZResponseSuccess)success fail:(XLZResponseFail)fail showHUD:(BOOL)showHUD{
    
    DLog(@"")
    if (url == nil) {
        return nil;
    }else{
        url = [NSString stringWithFormat:@"%@%@",BaseUrlStr,url];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPSessionManager *manager = [self getAFNManager];
    XLZURLSessionTask *sessionTask = nil;
    sessionTask = [manager uploadTaskWithRequest:request fromFile:[NSURL URLWithString:uploadingFile] progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        }
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        [[self tasksArray]removeObject:sessionTask];
        if (error == nil) {
            if (success) {
                success(responseObject);
            }
        }else{
            if (fail) {
                fail(error);
            }
        }
        
        if (showHUD == YES) {
            [SVProgressHUD dismiss];
        }
        
    }];
    ///开始启动任务
    [sessionTask resume];
    if (sessionTask) {
        [[self tasksArray]addObject:sessionTask];
    }
    return sessionTask;
}



#pragma mark - 开始监听网络
+ (void)startMonitoring{
    ///1.获取网络监控的管理者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager manager];
    ///2.设置网络状态改变后的处理
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                DLog(@"未知网络")
                [NetworkHttpTools sharedXLZNetworking].networkStatus =NetworkStatusUnknown;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                DLog(@"没有网络")
                [NetworkHttpTools sharedXLZNetworking].networkStatus = NetworkStatusNotReachable;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                DLog(@"手机自带网络3G 4G")
                [NetworkHttpTools sharedXLZNetworking].networkStatus = NetworkStatusReachableViaWWAM;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                DLog(@"WiFi网络")
                [NetworkHttpTools sharedXLZNetworking].networkStatus = NetworkStatusReachableWiFi;
                break;
            default:
                break;
        }
    }];
    [manager startMonitoring];
    
}



#pragma mark - 创建网络请求
+ (AFHTTPSessionManager *)getAFNManager{
    /////打开菊花  转圈圈
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer]; //返回的数据为JSON
    
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
    
    ////设置允许同时并发数量，过大容易出问题
    manager.operationQueue.maxConcurrentOperationCount = 3;
    
    
    
    return manager;
}






#pragma mark - 检查是否有中文
+ (NSString *)strUTF8Encoding:(NSString *)urlString{
    ///四种识别中文的方法
    
    //1.
    //return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    
    //2.
    //return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    //3.
//    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)urlString,(CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",                                                  NULL, kCFStringEncodingUTF8));
    
    
    //4.
    return [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
}







@end
