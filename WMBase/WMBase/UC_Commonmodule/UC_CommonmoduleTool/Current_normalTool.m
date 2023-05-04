//
//  Current_normalTool.m
//  test_pod
//
//  Created by 樊腾 on 2020/7/24.
//  Copyright © 2020 TT. All rights reserved.
//

#import "Current_normalTool.h"
#import "TT_DarkmodeTool.h"
#import "DataUtil.h"
#import <WebKit/WebKit.h>
#import "TT_GifV.h"

#import <objc/runtime.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <AdSupport/AdSupport.h>
#import <sys/sysctl.h>
#import <sys/socket.h>
#import <net/if.h>
#import <net/if_dl.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#include <netdb.h>
#import "sys/utsname.h"
#import "TSShareHelper.h"

#import "TT_GeneralProfile.h"
#import "UC_CommonmoduleCat.h"
#import "XXX_Datautil.h"
#import "KWLoginedManager.h"
@implementation Current_normalTool


+ (BOOL)isBlankString:(NSString *)str
{
    if (str == nil || str == NULL) {
        return YES;
    }
    return [str isEmpty];
}

+ (BOOL)dataishave:(id)data {
    if ([data isKindOfClass:[NSString class]]) {
        return NO;
    }else {
        return YES;
    }
}
+ (NSString*)getBundleVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];;
}

+ (NSString*)getBundleName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];;
}

+ (NSString*)getBundleDisplayName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];;
}

+ (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0){
        return NO;
    }
    return YES;
}

/// 邮箱格式校验
/// @param email email email
+(BOOL)xxx_isValidateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
     BOOL isVlaidate = [emailTest evaluateWithObject:email];
    return isVlaidate;
}


+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)isHasOtherChar:(NSString *)s
{
    //提示 标签不能输入特殊字符
    NSString *str =@"^[A-Za-z0-9]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:s]) {
        return YES;
    }
    return NO;
}

+ (UIColor *)colorForHex:(NSString *)hexColor
{
    hexColor = [[hexColor stringByTrimmingCharactersInSet:
                 [NSCharacterSet whitespaceAndNewlineCharacterSet]
                 ] uppercaseString];
    if ([hexColor hasPrefix:@"#"])
        hexColor = [hexColor substringFromIndex:1];
    if ([hexColor length] > 6)
        return [UIColor blackColor];
    if ([hexColor length] != 6)
        return [UIColor blackColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [hexColor substringWithRange:range];
    range.location = 2;
    NSString *gString = [hexColor substringWithRange:range];
    range.location = 4;
    NSString *bString = [hexColor substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

//获取版本号
+ (NSString *)getAppVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

//获取应用名称
+ (NSString *)getAppDisplayName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

//获取当前设备语言信息
+ (NSString *)getDeviceLanguage
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    NSString * preferredLang = [allLanguages objectAtIndex:0];
    return preferredLang;
}

//字典转json
+(NSString *)jsonStringFromDictionary:(NSDictionary *)dic
{
    //将字典转换成json 数据
    NSString *str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dic
                                                                                   options:NSJSONWritingPrettyPrinted
                                                                                     error:nil]
                                          encoding:NSUTF8StringEncoding];
    return str;
}

//数组转json
+ (NSString *)jsonStringFromArr:(NSMutableArray *)arr{
    //将字典转换成json 数据
    NSString *str = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:arr
                                                                                   options:NSJSONWritingPrettyPrinted
                                                                                     error:nil]
                                          encoding:NSUTF8StringEncoding];
    return str;
}

+ (NSDictionary *)objToDic:(id)objc{
    unsigned int count;
    objc_property_t * properties = class_copyPropertyList(object_getClass(objc), &count);
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    for (int i =0; i<count; i++) {
        const char * propertyName = property_getName(properties[i]);
        [dic setObject:[objc valueForKey:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]] forKey:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
    }
    NSLog(@"转化后dic%@",dic);
    return dic;
}

//json转字典
+ (NSDictionary *)dicFromjsonStr:(NSString *)jsonStr{
    if ([Current_normalTool isBlankString:jsonStr]) {
        return nil;
    }
    NSData * jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError * err;
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&err];
    if (err) {
        NSLog(@"json解析失败 %@",err);
        return nil;
    }
    return dic;
}

//json转数组
+ (NSMutableArray *)arrFromjsonStr:(NSString *)jsonStr{
    if ([Current_normalTool isBlankString:jsonStr]) {
        return nil;
    }
    NSData * jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError * err;
    NSMutableArray * arr = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&err];
    if (err) {
        NSLog(@"json解析失败 %@",err);
        return nil;
    }
    return arr;
}

static char encodingTable[64] = {
    'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',
    'Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f',
    'g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v',
    'w','x','y','z','0','1','2','3','4','5','6','7','8','9','+','/' };

+ (NSString *) base64Encoding:(NSData *)data withLineLength:(unsigned int) lineLength {
    const unsigned char    *bytes = [data bytes];
    NSMutableString *result = [NSMutableString stringWithCapacity:[data length]];
    unsigned long ixtext = 0;
    unsigned long lentext = [data length];
    long ctremaining = 0;
    unsigned char inbuf[3], outbuf[4];
    short i = 0;
    unsigned int charsonline = 0;
    short ctcopy = 0;
    unsigned long ix = 0;
    while( YES ) {
        ctremaining = lentext - ixtext;
        if( ctremaining <= 0 ) break;
        
        for( i = 0; i < 3; i++ ) {
            ix = ixtext + i;
            if( ix < lentext ) inbuf[i] = bytes[ix];
            else inbuf [i] = 0;
        }
        outbuf [0] = (inbuf [0] & 0xFC) >> 2;
        outbuf [1] = ((inbuf [0] & 0x03) << 4) | ((inbuf [1] & 0xF0) >> 4);
        outbuf [2] = ((inbuf [1] & 0x0F) << 2) | ((inbuf [2] & 0xC0) >> 6);
        outbuf [3] = inbuf [2] & 0x3F;
        ctcopy = 4;
        switch( ctremaining ) {
            case 1:
                ctcopy = 2;
                break;
            case 2:
                ctcopy = 3;
                break;
        }
        for( i = 0; i < ctcopy; i++ )
            [result appendFormat:@"%c", encodingTable[outbuf[i]]];
        
        for( i = ctcopy; i < 4; i++ )
            [result appendFormat:@"%c",'='];
        
        ixtext += 3;
        charsonline += 4;
        
        if( lineLength > 0 ) {
            if (charsonline >= lineLength) {
                charsonline = 0;
                [result appendString:@"\n"];
            }
        }
    }
    
    return result;
}

//判断是否含有非法字符 yes 有  no没有
+ (BOOL)JudgeTheillegalCharacter:(NSString *)content{
    //提示 标签不能输入特殊字符
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:content]) {
        return YES;
    }
    return NO;
}

+ (NSString *)getMobileCarrier
{

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
    if (NSClassFromString(@"CTTelephonyNetworkInfo"))
    {
        CTTelephonyNetworkInfo *netinfo = [[CTTelephonyNetworkInfo alloc] init];
        CTCarrier *carrier = [netinfo subscriberCellularProvider];
        NSString *carrierStr = [carrier carrierName];
        if (carrierStr) {
            return carrierStr;
        }
    }
#endif
    NSString *carrierStr = [NSString stringWithFormat:@""];
    return carrierStr;

}

+ (NSString *)getIDFA {
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


+ (NSString *)getMACAdress
{

    int                    mib[6];
    size_t                len;
    char                *buf;
    unsigned char        *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl    *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return [outstring uppercaseString];
}

+ (NSString *)getOSVersion
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

+ (NSString *)getScreenResolution{
    
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
    CGRect bounds = [[UIScreen mainScreen] bounds];
    CGFloat scale = [[UIScreen mainScreen] respondsToSelector:@selector(scale)] ? [[UIScreen mainScreen] scale] : 1.f;
    CGSize res = CGSizeMake(bounds.size.width * scale, bounds.size.height * scale);
    NSString *result = [NSString stringWithFormat:@"%gx%g", res.width, res.height];
    return result;
#else
    NSRect screenRect = NSScreen.mainScreen.frame;
    return [NSString stringWithFormat:@"%.1fx%.1f", screenRect.size.width, screenRect.size.height];
#endif
}

+ (NSString *)getIpAddresses
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        temp_addr = interfaces;
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    return address;
}

+ (NSString *)getOSLanguage
{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    return preferredLang;
}

+ (NSString *)getPlatForm{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return deviceString;
}

+ (BOOL)isAppFirstRun
{
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary]
                                objectForKey:@"CFBundleShortVersionString"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastRunKey = [defaults objectForKey:@"last_run_version_key"];
    if (!lastRunKey) {
        [defaults setObject:currentVersion forKey:@"last_run_version_key"];
        return YES;
    }
    else if (![lastRunKey isEqualToString:currentVersion]) {
        [defaults setObject:currentVersion forKey:@"last_run_version_key"];
        return YES;
    }
    return NO;
}

//添加自定义视图的动画(显示)
+ (void)animationShowWithView:(UIView *)view duration:(CFTimeInterval)duration
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    [view.layer addAnimation:animation forKey:nil];
}

//获取当前时间日期
+(NSString*)getCurrentDate
{
    NSDate *date=[NSDate date];
    NSDateFormatter *format1=[[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *dateStr;
    dateStr=[format1 stringFromDate:date];
    NSLog(@"%@",dateStr);
    return dateStr;
}

//获取某年某个月天数
+ (int)getDays:(NSInteger )year and:(NSInteger)day
{
    int times [] = {31,28,31,30,31,30,31,31,30,31,30,31};
    if ((year%4==0&&year%100!=0)||year%400==0) {
        times[1] = 29;
    }
    return (times[day-1]);
}

//获取某年某个月第一天为周几的函数， 0为周日
+ (int)GetTheWeekOfDayByYear:(int)year andByMonth:(int)month{
    int sum = 0;
    for(int i = 1;i<month;i++){
        sum+=[self getDays:year and:i];
    }
    int nedDay = sum+1;
    return ((year-1)+(year-1)/4 -(year/100)+(year/400)+nedDay)%7;
}

//根据域名获取ip地址
+ (NSString *)getIPAddressByHostName:(NSString*)strHostName{
    const char* szname = [strHostName UTF8String];
    struct hostent* phot ;
    @try
    {
        phot = gethostbyname(szname);
    }
    @catch (NSException * e)
    {
        return nil;
    }
    
    struct in_addr ip_addr;
    memcpy(&ip_addr,phot->h_addr_list[0],4);///h_addr_list[0]里4个字节,每个字节8位，此处为一个数组，一个域名对应多个ip地址或者本地时一个机器有多个网卡
    char ip[20] = {0};
    inet_ntop(AF_INET, &ip_addr, ip, sizeof(ip));
    NSString* strIPAddress = [NSString stringWithUTF8String:ip];
    return strIPAddress;
}


+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(NSInteger )gradientType imgSize:(CGSize)imgSize {
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    //    GradientTypeTopToBottom = 0,//从上到下
    //    GradientTypeLeftToRight = 1,//从左到右
    //    GradientTypeUpleftToLowright = 2,//左上到右下
    //    GradientTypeUprightToLowleft = 3,//右上到左下
    
    switch (gradientType) {
        case 0:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        case 1:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, 0.0);
            break;
        case 2:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, imgSize.height);
            break;
        case 3:
            start = CGPointMake(imgSize.width, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        default:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
    }
    
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

+ (void)addLineToView:(UIView *)view frame:(CGRect)frame{
    UIView *splitView = [[UIView alloc]initWithFrame:frame];
    splitView.backgroundColor = [TT_DarkmodeTool TT_normaEEE];
    [view addSubview:splitView];
}

//根据图片获取图片的主色调
+(UIColor*)mostColor:(UIImage*)image{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize=CGSizeMake(image.size.width/2, image.size.height/2);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    //第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    if (data == NULL) return nil;
    NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    
    for (int x=0; x<thumbSize.width; x++) {
        for (int y=0; y<thumbSize.height; y++) {
            int offset = 4*(x*y);
            int red = data[offset];
            int green = data[offset+1];
            int blue = data[offset+2];
            int alpha =  data[offset+3];
            if (alpha>0) {//去除透明
                if (red==255&&green==255&&blue==255) {//去除白色
                }else{
                    NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
                    [cls addObject:clr];
                }
                
            }
        }
    }
    CGContextRelease(context);
    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    NSArray *MaxColor=nil;
    NSUInteger MaxCount=0;
    while ( (curColor = [enumerator nextObject]) != nil )
    {
        NSUInteger tmpCount = [cls countForObject:curColor];
        if ( tmpCount < MaxCount ) continue;
        MaxCount=tmpCount;
        MaxColor=curColor;
        
    }
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}

//label两头添加图片
//1左侧 2右侧
+ (NSAttributedString *)labelAddImgRect:(CGRect)imgRect
                            imgPosition:(NSInteger)position
                                spacing:(CGFloat)spacing
                              labelFont:(UIFont *)labelFont
                              textColor:(UIColor *)textColor
                                   text:(NSString *)text
                                  image:(UIImage *)image{
    
    // 创建一个富文本
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:text];
    // 修改富文本中的不同文字的样式
    [attriStr addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, text.length)];
    [attriStr addAttribute:NSFontAttributeName value:labelFont range:NSMakeRange(0, text.length)];
    /**
     添加图片到指定的位置
     */
    NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
    // 表情图片
    attchImage.image = image;
    // 设置图片大小
    attchImage.bounds = imgRect;
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
    if (position == 1) {
        [attriStr insertAttributedString:stringImage atIndex:0];
    }
    if (position == 2) {
        [attriStr insertAttributedString:stringImage atIndex:text.length];
    }
    return attriStr;
}

//将RGBAStr转化成UIColor
+ (UIColor *)exchangeColorFromRGBAStr:(NSString *)rgbaStr{
    if ([Current_normalTool isBlankString:rgbaStr]) {
        return [UIColor clearColor];
    }
    if ([rgbaStr hasPrefix:@"#"]) {
        return [UIColor colorWithHexString:rgbaStr];
    }
    NSMutableString * mulStr = [NSMutableString stringWithString:rgbaStr];
    [mulStr deleteCharactersInRange:NSMakeRange(0, 5)];
    [mulStr deleteCharactersInRange:NSMakeRange(mulStr.length-1, 1)];
    
    NSArray * arr = [mulStr componentsSeparatedByString:@","];
    if (arr.count == 4) {
        return [UIColor colorWithRed:[[arr objectAtIndex:0] floatValue]/255.0 green:[[arr objectAtIndex:1] floatValue]/255.0 blue:[[arr objectAtIndex:2] floatValue]/255.0 alpha:[[arr objectAtIndex:3] floatValue]];
    }else {
        return [UIColor whiteColor];
    }
}

//去除字符串中的转义符
+ (NSString *)deleteTransSymbol:(NSString *)str{
    
    NSMutableString *responseString = [NSMutableString stringWithString:str];
    NSString *character = nil;
    for (int i = 0; i < responseString.length; i ++) {
        character = [responseString substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:@"\\"])
            [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
    }
    return responseString;
}

//时间戳转时间
+ (NSString *)getTimeFromTimeStamp:(NSString *)timeStampStr
{
    NSString *str=timeStampStr;//时间戳
    NSTimeInterval time=[str doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

+ (NSString *)getTimeDateFormatterStr:(NSString *)formatterStr stamp:(NSString *)timeStampStr
{
    NSString *str=timeStampStr;//时间戳
    NSTimeInterval time=[str doubleValue];
    //+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:formatterStr];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

+ (NSString *)getTimeFromTimeStampWithyyyMMddHHmm:(NSString *)timeStampStr
{
    NSString *str=timeStampStr;//时间戳
    NSTimeInterval time=[str doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyy.MM.dd  HH:mm"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

//判断用户是否登录
+ (BOOL)judgeUserIsLogin{
    if (NIL([KWLoginedManager.shareInstance getCurrentLoginedUser].token)) {
        return NO;
    }
    return YES;
}


//背景图片绘制文字返回新图片
+ (UIImage *)imageWithTitle:(NSString *)title fontSize:(CGFloat)fontSize drawImg:(UIImage *)drawImg{
    //画布大小
    CGSize size=CGSizeMake(drawImg.size.width,drawImg.size.height);
    //创建一个基于位图的上下文
    UIGraphicsBeginImageContextWithOptions(size,NO,0.0);//opaque:NO  scale:0.0
    [drawImg drawAtPoint:CGPointMake(0.0,0.0)];
    //文字居中显示在画布上
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment=NSTextAlignmentCenter;//文字居中
    //计算文字所占的size,文字居中显示在画布上
    CGSize sizeText=[title boundingRectWithSize:drawImg.size options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:[TT_DarkmodeTool TT_NormalWhite]}context:nil].size;
    CGFloat width = drawImg.size.width;
    CGFloat height = drawImg.size.height;
    CGRect rect = CGRectMake((width-sizeText.width)/2, (height-sizeText.height)/2, sizeText.width, sizeText.height);
    //绘制文字
    [title drawInRect:rect withAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:[ UIColor whiteColor],NSParagraphStyleAttributeName:paragraphStyle}];
    //返回绘制的新图形
    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//显示加载视图
+ (void)showCustomLoadingView {
    [[TT_GifV share_tool] setupYYImageView];
}

+ (void)dismiss {
    [[TT_GifV share_tool]dismiss];
}

//编码URL 只编码当中的中文字符
+ (NSString *)encodeURLWithChineseChar:(NSString *)string{
    
    if (string && string.length > 0)
       {
           NSString *encodeString = string;
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
           encodeString = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL, kCFStringEncodingUTF8));
#pragma clang diagnostic pop
           return encodeString;
       }else{
           return @"";
       }
}

+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size{
    NSData * data = UIImageJPEGRepresentation(image, 0.3);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.1f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length / 1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    return data;
}

+ (UIImage *)processImage:(UIImage *)image {
    CGFloat newW = image.size.width / 2;
    CGFloat newH = image.size.height / 2;
    CGSize newSize = CGSizeMake(newW, newH);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newW, newH)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//是否是纯数字
+ (BOOL)isNumText:(NSString *)str{
    if (str.length == 0) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}

+ (NSString *)processImageResolution:(NSString *)origin {
    //处理图片分辨率
    if ([origin containsString:@"jpg_"] && [origin containsString:@"x"]) {
        NSRange widthStartRange = [origin rangeOfString:@".jpg_"];
        NSString *widthHeight = [origin substringToIndex:widthStartRange.location];
        
        NSString *newResolution = [NSString stringWithFormat:@"%@.jpg_150x150.jpg", widthHeight];
        return newResolution;
    }
    return origin;
}

//获取当前时间戳
+ (NSString *)getNowTimeTimestamp {
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    
    return timeString;
}
//获取当前时间
+(NSString *)getDate:(NSDate *)date formatterStr:(NSString *)formatterStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:formatterStr];
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    return currentDateStr;
}

//解码地址
+ (NSString *)decodeUrl:(NSString *)url{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, (CFStringRef)url, CFSTR("")));
}

+(CGFloat)getHeightLabWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font{
    // 创建一个label对象，给出目标label的宽度
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    // 获得文字
    label.text = title;
    // 获得字体大小
    label.font = font;
    // 自适应
    label.numberOfLines = 0;
    [label sizeToFit];
    // 经过自适应之后的label，已经有新的高度
    CGFloat height = label.frame.size.height;
    // 返回高度
    return height;
}

+(NSArray *)stringJSONtoAry:(NSString *)jsonStr
{
    id temp = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
    if ([temp isKindOfClass:[NSArray class]]) {
        return temp;
    }else{
        return [NSArray arrayWithObject:temp];
    }
}

//清楚网也缓存
/** 清理缓存的方法，这个方法会清除缓存类型为HTML类型的文件*/
+ (void)clearHTMLCache{
    if (@available(iOS 9.0, *)) {
        
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
           NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
           [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
           }];
    } else {
        // Fallback on earlier versions
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES) objectAtIndex:0];
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSLog(@"%@", cookiesFolderPath);
        NSError *errors;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    }
}


+ (void)tengtengconfightmlupdate {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSData *xmlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[XXX_Datautil getuploadhtml]]];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSString *xmlString = [[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
    NSArray *arr = [xmlString componentsSeparatedByString:@"</version>"];
    if (arr.count > 1) {
        NSArray *tt = [arr[0] componentsSeparatedByString:@"<version>"];
        if (tt.count > 1) {
            NSString *htmlversion = tt[1];
            Exist(@"htmlV") {
                NSString *htmlV = TakeOut(@"htmlV");
                if ([htmlversion integerValue] > [htmlV integerValue]) {
                    [Current_normalTool clearHTMLCache];
                }
            }else {
                SaveObject(htmlversion, @"htmlV")
                [Current_normalTool clearHTMLCache];
            }
        }
    }
    if (xmlData == nil) {
        NSLog(@"File read failed!:%@", xmlString);
    }else {
        NSLog(@"File read succeed!:%@",xmlString);
    }
}



+ (id)tengteng_confignsuserdefaultobjectforkey:(NSString *)object normalobject:(NSString *)normal {
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:object] isKindOfClass:[NSNull class]] && [[NSUserDefaults standardUserDefaults] objectForKey:object]!= nil && [[NSUserDefaults standardUserDefaults] objectForKey:object] !=NULL) {
        return [[NSUserDefaults standardUserDefaults]objectForKey:object];
    }else {
        return normal;
    }
}






/// 调用系统分享
+ (void)configShrae:(NSMutableArray *)shareImgArr CC:(UIViewController *)CC{
    [TSShareHelper shareWithType:0
               andController:CC
                    andItems:shareImgArr
               andCompletion:^(TSShareHelper *shareHelper, BOOL success) {
        if (success) {
            NSLog(@"成功的回调");
        }else{
            NSLog(@"失败的回调");
        }
    }];
}



+ (UINavigationController *)currentNav {
    UINavigationController *nav;
    UIViewController * vc = [self _topViewController:[UIApplication sharedApplication].delegate.window.rootViewController];
    nav = vc.navigationController;
    return nav;
}

/// 获取最顶部的 Controller
+ (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

+ (void)configdismissViewController {
    UIViewController *rootVC = topViewController().presentingViewController;
    while (rootVC.presentingViewController) {
        rootVC = rootVC.presentingViewController;
    }
    [rootVC dismissViewControllerAnimated:YES completion:nil];
}

+ (void)configpresentViewController:(UIViewController *)vc {
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [topViewController() presentViewController:vc animated:YES completion:nil];
}

@end
