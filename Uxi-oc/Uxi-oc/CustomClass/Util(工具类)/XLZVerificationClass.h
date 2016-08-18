//
//  XLZVerificationClass.h
//  Uxi-oc
//
//  Created by jecansoft on 16/8/17.
//  Copyright © 2016年 zyhl. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface XLZVerificationClass : NSObject


+ (BOOL)xlz_VerificaStringIsAllNumber:(NSString *)str;


+ (BOOL)xlz_validateIdentityCard:(NSString *)identityCard;


+ (BOOL)xlz_isValidateMobile:(NSString *)mobile;


+ (BOOL)xlz_ValidateTelphone:(NSString *)telphone;


+ (BOOL)xlz_ValidateEmail:(NSString *)email;


+ (BOOL)xlz_ValidateUrl:(NSString *)url;


+ (BOOL)xlz_ValidateZipCode:(NSString *)zipCode;


+ (NSString*)xlz_DeviceVersion;


+(BOOL)xlz_checkIdentityCardNo:(NSString*)cardNo;





@end


