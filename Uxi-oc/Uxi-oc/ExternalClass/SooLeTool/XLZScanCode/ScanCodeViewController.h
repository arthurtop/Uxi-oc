//
//  ScanCodeViewController.h
//  Uxi-oc
//
//  Created by jecansoft on 16/9/6.
//  Copyright © 2016年 zyhl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScanCodeQRDelegate <NSObject>

//扫描完成
- (void)scanCodeQRFinshedResult:(NSString *)result;

@end


@interface ScanCodeViewController : UIViewController



@end


