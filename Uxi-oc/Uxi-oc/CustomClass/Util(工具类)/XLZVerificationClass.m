//
//  XLZVerificationClass.m
//  Uxi-oc
//
//  Created by jecansoft on 16/8/17.
//  Copyright © 2016年 zyhl. All rights reserved.
//

#import "XLZVerificationClass.h"
#import <sys/utsname.h>

/**
 *  各种验证信息类
 */

@implementation XLZVerificationClass



#pragma mark - - 验证字符串是否全是数字
+ (BOOL)xlz_VerificaStringIsAllNumber:(NSString *)str{
    NSString *regex = @"^[0-9]*$";
    
    NSPredicate *allNumber = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [allNumber evaluateWithObject:str];
}


#pragma mark - 验证身份证号码 正则表达式
+ (BOOL)xlz_validateIdentityCard:(NSString *)identityCard{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}



#pragma mark -  手机号码验证
+ (BOOL)xlz_isValidateMobile:(NSString *)mobile{
    /*
     //手机号以13， 15，18开头，八个 \\d 数字字符
     NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\\\D])|(18[0,0-9]))\\\\d{8}$";
     
     NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
     
     */
    
   
    // 这是正则表达式
    NSString *number = @"^((13[0-9])|(15[^4\\D])|(18[0,2,5-9]))\\d{8}$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", number];
    
    return [numberPre evaluateWithObject:mobile substitutionVariables:nil];
}


#pragma mark - 座机号码验证
+ (BOOL)xlz_ValidateTelphone:(NSString *)telphone{
    
    NSString *phoneRegex = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:telphone];
}


#pragma mark - 邮箱验证
+ (BOOL)xlz_ValidateEmail:(NSString *)email{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

#pragma mark - URL验证
+ (BOOL)xlz_ValidateUrl:(NSString *)url{
    
    NSString *regex = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:url];
}

#pragma mark - 邮编验证
+ (BOOL)xlz_ValidateZipCode:(NSString *)zipCode{
    NSString *regex = @"[0-9]\\d{5}(?!\\d)";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:zipCode];
}


#pragma mark - 设备型号验证  需要 #import "sys/utsname.h"
+ (NSString*)xlz_DeviceVersion{
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    /**
     *  //iPhone
    */
    
//    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
//    
//    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
//    
//    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    
//    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
//    
//    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    
    if ([deviceString isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([deviceString isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([deviceString isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([deviceString isEqualToString:@"iPhone5,3"]) return @"iPhone 5C";
    
    if ([deviceString isEqualToString:@"iPhone5,4"]) return @"iPhone 5C";
    
    if ([deviceString isEqualToString:@"iPhone6,1"]) return @"iPhone 5S";
    
    if ([deviceString isEqualToString:@"iPhone6,2"]) return @"iPhone 5S";

    if ([deviceString isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([deviceString isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([deviceString isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([deviceString isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([deviceString isEqualToString:@"iPhonese,1"]) return @"iPhone se";
    
    
    
    /**
     *  //iPod
     */
    if ([deviceString isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    
    if ([deviceString isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    
    if ([deviceString isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    
    if ([deviceString isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    
    if ([deviceString isEqualToString:@"iPod5,1"]) return @"iPod Touch 5G";
    
    /**
     *  iPad
     */
    
    if ([deviceString isEqualToString:@"iPad1,1"]) return @"iPad";
    
    if ([deviceString isEqualToString:@"iPad2,1"]) return @"iPad 2 (WiFi)";
    
    if ([deviceString isEqualToString:@"iPad2,2"]) return @"iPad 2 (GSM)";
    
    if ([deviceString isEqualToString:@"iPad2,3"]) return @"iPad 2 (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad2,4"]) return @"iPad 2 (32nm)";
    
    if ([deviceString isEqualToString:@"iPad2,5"]) return @"iPad mini (WiFi)";
    
    if ([deviceString isEqualToString:@"iPad2,6"]) return @"iPad mini (GSM)";
    
    if ([deviceString isEqualToString:@"iPad2,7"]) return @"iPad mini (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad3,1"]) return @"iPad 3(WiFi)";
    
    if ([deviceString isEqualToString:@"iPad3,2"]) return @"iPad 3(CDMA)";
    
    if ([deviceString isEqualToString:@"iPad3,3"]) return @"iPad 3(4G)";
    
    if ([deviceString isEqualToString:@"iPad3,4"]) return @"iPad 4 (WiFi)";
    
    if ([deviceString isEqualToString:@"iPad3,5"]) return @"iPad 4 (4G)";
    
    if ([deviceString isEqualToString:@"iPad3,6"]) return @"iPad 4 (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad4,1"]) return @"iPad Air";
    
    if ([deviceString isEqualToString:@"iPad4,2"]) return @"iPad Air";
    
    if ([deviceString isEqualToString:@"iPad4,3"]) return @"iPad Air";
    
    if ([deviceString isEqualToString:@"iPad5,3"]) return @"iPad Air 2";
    
    if ([deviceString isEqualToString:@"iPad5,4"]) return @"iPad Air 2";
    
    if ([deviceString isEqualToString:@"i386"]) return @"Simulator";
    
    if ([deviceString isEqualToString:@"x86_64"]) return @"Simulator";
    
    if ([deviceString isEqualToString:@"iPad4,4"]
        
        ||[deviceString isEqualToString:@"iPad4,5"]
        
        ||[deviceString isEqualToString:@"iPad4,6"]) return @"iPad mini 2";
    
    if ([deviceString isEqualToString:@"iPad4,7"]
        
        ||[deviceString isEqualToString:@"iPad4,8"]
        
        ||[deviceString isEqualToString:@"iPad4,9"]) return @"iPad mini 3";
    
    return deviceString;
    
}


#pragma mark - 验证身份证号码 一般方法
+(BOOL)xlz_checkIdentityCardNo:(NSString*)cardNo{
    if (cardNo.length != 18) {
        return  NO;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[cardNo substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
}



@end
