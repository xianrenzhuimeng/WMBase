//
//  Current_normalTool.h
//  test_pod
//
//  Created by 樊腾 on 2020/7/24.
//  Copyright © 2020 TT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN

@interface Current_normalTool : NSObject

+ (NSString*)getBundleVersion;
+ (NSString*)getBundleName;
+ (NSString*)getBundleDisplayName;
//判断字符串是否为空
+ (BOOL)isBlankString:(NSString *)str;
//判断此字符串是否全是数字
+ (BOOL)isPureNumandCharacters:(NSString *)string;
//判断手机号有效性
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
//判断字符串中是否只有数字或者英文
+ (BOOL)isHasOtherChar:(NSString *)s;
//获取颜色
+ (UIColor *)colorForHex:(NSString *)hexColor;
//获取版本号
+ (NSString *)getAppVersion;
//获取当前设备语言信息
+ (NSString *)getDeviceLanguage;
//字典转json
+ (NSString *)jsonStringFromDictionary:(NSDictionary*)dic;
//数组转json
+ (NSString *)jsonStringFromArr:(NSMutableArray *)arr;
//json转字典
+ (NSDictionary *)dicFromjsonStr:(NSString *)jsonStr;
//json转数组
+ (NSMutableArray *)arrFromjsonStr:(NSString *)jsonStr;
//对象转字典 字典的key-value:属性名－属性值(@property修饰)
+ (NSDictionary *)objToDic:(id)objc;

+ (NSString *) base64Encoding:(NSData *)data withLineLength:(unsigned int) lineLength;

//判断是否含有非法字符 yes 有 no没有
+ (BOOL)JudgeTheillegalCharacter:(NSString *)content;
//获取sim卡运营商名称
+ (NSString *)getMobileCarrier;
//获取IDFA
+ (NSString *)getIDFA;
//获取MAC地址
+ (NSString *)getMACAdress;
//获取系统版本
+ (NSString *)getOSVersion;
//获取设备分辨率
+ (NSString *)getScreenResolution;
//获取设备IP地址
+ (NSString *)getIpAddresses;
//获取设备系统语言
+ (NSString *)getOSLanguage;
//获取设备型号
+ (NSString *)getPlatForm;
//获取应用程序名称
+ (NSString *)getAppDisplayName;
//判读app是否为第一次运行，或者更新完第一次启动
+ (BOOL)isAppFirstRun;
//添加自定义视图的动画(显示)
+ (void)animationShowWithView:(UIView *)view duration:(CFTimeInterval)duration;
//获取某年某个月天数
+ (int)getDays:(NSInteger )year and:(NSInteger)day;
//获取某年某个月第一天为周几的函数， 0为周日
+ (int)GetTheWeekOfDayByYear:(int)year andByMonth:(int)month;
//根据域名获取ip地址
+ (NSString *)getIPAddressByHostName:(NSString*)strHostName;
//获取当前日期
+(NSString*)getCurrentDate;
//将渐变色转化为图片
//    gradientType = 0,//从上到小
//    gradientType = 1,//从左到右
//    gradientType = 2,//左上到右下
//    gradientType = 3,//右上到左下
+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(NSInteger )gradientType imgSize:(CGSize)imgSize;

//添加分割线方法
+ (void)addLineToView:(UIView *)view frame:(CGRect)frame;

//根据图片获取图片的主色调
+ (UIColor*)mostColor:(UIImage*)image;


//label两头添加图片
//1左侧 2右侧
+ (NSAttributedString *)labelAddImgRect:(CGRect)imgRect
                            imgPosition:(NSInteger)position
                                spacing:(CGFloat)spacing
                              labelFont:(UIFont *)labelFont
                              textColor:(UIColor *)textColor
                                   text:(NSString *)text
                                  image:(UIImage *)image;
//将RGBAStr转化成UIColor
+ (UIColor *)exchangeColorFromRGBAStr:(NSString *)rgbaStr;
//去除字符串中的转义符
+ (NSString *)deleteTransSymbol:(NSString *)str;
//时间戳转时间 @"yyyy-MM-dd HH:mm:ss"
+ (NSString *)getTimeFromTimeStamp:(NSString *)timeStampStr;
//判断用户是否登录
+ (BOOL)judgeUserIsLogin;
//背景图片绘制文字返回新图片
+ (UIImage *)imageWithTitle:(NSString *)title fontSize:(CGFloat)fontSize drawImg:(UIImage *)drawImg;
//清楚网也缓存
+ (void)clearHTMLCache;
//显示加载视图
+ (void)showCustomLoadingView;
/// 关闭动画
+ (void)dismiss;
//编码URL 只编码当中的中文字符
+ (NSString *)encodeURLWithChineseChar:(NSString *)string;
//按照给定的大小压缩图片
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;
//压缩图片分辨率
+ (UIImage *)processImage:(UIImage *)image;
//是否是纯数字
+ (BOOL)isNumText:(NSString *)str;
//修改图片分辨率
+ (NSString *)processImageResolution:(NSString *)origin;
//获取当前时间戳
+ (NSString *)getNowTimeTimestamp;
//获取当前时间戳 得到yyyMMddHHm
+ (NSString *)getTimeFromTimeStampWithyyyMMddHHmm:(NSString *)timeStampStr;
/**
 服务器时间转 -> formatterStr 格式化时间

 @param timeStampStr 时间格式化Str
 @return 格式化时间
 */
+ (NSString *)getTimeDateFormatterStr:(NSString *)formatterStr stamp:(NSString *)timeStampStr;

/**
 NSDate 转化时间格式 Str

 @param formatterStr 格式化时间
 @return 当前的格式时间
 */
+(NSString *)getDate:(NSDate *)date formatterStr:(NSString *)formatterStr;
//解码地址
+ (NSString *)decodeUrl:(NSString *)url;

//计算lLab 的高度
+(CGFloat)getHeightLabWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font;
/// 判断H5版本是否需要清空
+ (void)tengtengconfightmlupdate;

+ (id)tengteng_confignsuserdefaultobjectforkey:(NSString *)object normalobject:(NSString *)normal;


/// 调用系统分享
+ (void)configShrae:(NSMutableArray *)shareImgArr
                 CC:(UIViewController *)CC;


///检验邮箱的合法性
+(BOOL)xxx_isValidateEmail:(NSString *)email;
/// 获取最顶部的 Controller
+ (UIViewController *)topViewController;

+ (UINavigationController *)currentNav;

@end

NS_ASSUME_NONNULL_END
