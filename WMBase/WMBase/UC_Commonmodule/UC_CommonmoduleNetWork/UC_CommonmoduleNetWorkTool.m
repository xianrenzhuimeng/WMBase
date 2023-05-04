//
//  UC_CommonmoduleNetWorkTool.m
//  AFNetworking
//
//  Created by 樊腾 on 2020/9/10.
//

#import "UC_CommonmoduleNetWorkTool.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <AdSupport/AdSupport.h>
#import <sys/sysctl.h>
#import "sys/utsname.h"
#import "KWLoginedManager.h"
@implementation UC_CommonmoduleNetWorkTool


//获取版本号
+ (NSString *)getAppVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}


//判断用户是否登录
+ (NSString *)getUserToken {
    NSString *token = [KWLoginedManager.shareInstance getCurrentLoginedUser].token;
    if (!token || [token isEqualToString:@""]) {
        return @""  ;
    }
    return token;
}
+ (NSString *)getUser_id {
    NSString *userId = [KWLoginedManager.shareInstance getCurrentLoginedUser].user_id;
    if (!userId || [userId isEqualToString:@""]) {
        return @""  ;
    }
    return userId;
}



//获取当前时间戳
+ (NSString *)tt_getNowTimeTimestamp {
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    
    return timeString;
}

+ (NSString *)tt_getHmacmd5:(NSString *)clearText withSecret:(NSString *)secret{
   CCHmacContext ctx;
  //使用GBK编码
  unsigned long encode =   CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
  const char *key = [secret cStringUsingEncoding:encode];
  const char *str = [clearText cStringUsingEncoding:encode];
  unsigned char mac[CC_MD5_DIGEST_LENGTH];
  char hexmac[2 * CC_MD5_DIGEST_LENGTH + 1];
  char *p;
  CCHmacInit(&ctx, kCCHmacAlgMD5, key, strlen(key));
  CCHmacUpdate(&ctx, str, strlen(str));
  CCHmacFinal(&ctx, mac);
  p = hexmac;
  for (int i = 0; i < CC_MD5_DIGEST_LENGTH;i++) {
      snprintf(p,3,"%02x", mac[ i ]);
      p += 2;
  }
  return [NSString stringWithCString:hexmac encoding:encode];
}

+ (id)confignsuserdefaultobjectforkey:(NSString *)object normalobject:(NSString *)normal {
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:object] isKindOfClass:[NSNull class]] && [[NSUserDefaults standardUserDefaults] objectForKey:object]!= nil && [[NSUserDefaults standardUserDefaults] objectForKey:object] !=NULL) {
        return [[NSUserDefaults standardUserDefaults]objectForKey:object];
    }else {
        return normal;
    }
}

+ (NSString *)tt_getOSVersion
{

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
    return [[UIDevice currentDevice] systemVersion];
#else
    SInt32 majorVersion, minorVersion, bugFixVersion;
    Gestalt(gestaltSystemVersionMajor, &majorVersion);
    Gestalt(gestaltSystemVersionMinor, &minorVersion);
    Gestalt(gestaltSystemVersionBugFix, &bugFixVersion);
    if (bugFixVersion > 0)
    {
        return [NSString stringWithFormat:@"%d.%d.%d", majorVersion, minorVersion, bugFixVersion];
    }
    else
    {
        return [NSString stringWithFormat:@"%d.%d", majorVersion, minorVersion];
    }
#endif
}

+ (NSString *)tt_getCurrentDeviceModel{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,1"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,4"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,2"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,5"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([deviceModel isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([deviceModel isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPhone12,1"])   return @"iPhone 11";
    if ([deviceModel isEqualToString:@"iPhone12,3"])   return @"iPhone 11 Pro";
    if ([deviceModel isEqualToString:@"iPhone12,5"])   return @"iPhone 11 Pro Max";
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceModel isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceModel isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    
    if ([deviceModel isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2";
    if ([deviceModel isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4";
    
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    return deviceModel;
}



+ (NSString *)tt_getIDFA {
    SEL advertisingIdentifierSel = sel_registerName("advertisingIdentifier");
    SEL UUIDStringSel = sel_registerName("UUIDString");
    ASIdentifierManager *manager = [ASIdentifierManager sharedManager];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if([manager respondsToSelector:advertisingIdentifierSel]) {
        id UUID = [manager performSelector:advertisingIdentifierSel];
        if([UUID respondsToSelector:UUIDStringSel]) {
            return [UUID performSelector:UUIDStringSel];
        }
    }
#pragma clang diagnostic pop
    return nil;
}





/** 主要方法 */
/** 类型识别:将所有的NSNull类型转化成@"" */
+(id)tt_changeType:(id)myObj;
{
    if ([myObj isKindOfClass:[NSDictionary class]])
    {
        return [self nullDic:myObj];
    }
    else if([myObj isKindOfClass:[NSArray class]])
    {
        return [self nullArr:myObj];
    }
    else if([myObj isKindOfClass:[NSString class]])
    {
        return [self stringToString:myObj];
    }
    else if([myObj isKindOfClass:[NSNull class]])
    {
        return [self nullToString];
    }
    else
    {
        return myObj;
    }
}

/** 将NSDictionary中的Null类型的项目转化成@"" */
+(NSDictionary *)nullDic:(NSDictionary *)myDic
{
    NSArray *keyArr = [myDic allKeys];
    NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < keyArr.count; i ++)
    {
        id obj = [myDic objectForKey:keyArr[i]];
        
        obj = [self tt_changeType:obj];
        
        [resDic setObject:obj forKey:keyArr[i]];
    }
    return resDic;
}

/** 将NSArray中的Null类型的项目转化成@"" */
+(NSArray *)nullArr:(NSArray *)myArr
{
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i ++)
    {
        id obj = myArr[i];
        
        obj = [self tt_changeType:obj];
        
        [resArr addObject:obj];
    }
    return resArr;
}

/** 将NSString类型的原路返回 */
+(NSString *)stringToString:(NSString *)string
{
    return string;
}

/** 将Null类型的项目转化成@"" */
+(NSString *)nullToString
{
    return @"";
}
@end
