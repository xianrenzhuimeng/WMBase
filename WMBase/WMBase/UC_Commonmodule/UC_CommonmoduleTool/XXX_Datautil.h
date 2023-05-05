//
//  XXX_Datautil.h
//  XXX
//
//  Created by 樊腾 on 2020/1/17.
//  Copyright © 2020 绑耀. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>


/// =========     AD    ============

/// 激励广告
#define rewardVideoAd @"rewardVideoAd"
/// 信息流广告
#define informationFlowAd @"informationFlowAd"
/// banner 广告
#define bannerAd @"bannerAd"
/// 插屏广告
#define screenAd @"screenAd"
/// 全屏广告
#define fullScreenAd @"fullScreenAd"
/// Draw信息流广告
#define DrawInformationFlowAd @"DrawInformationFlowAd"

/// 穿山甲APPID
#define APPID_IOS @"APPID_IOS"
/// 开屏
#define AD_OPEN_SCREEN_IOS @"AD_OPEN_SCREEN_IOS"
/// 激励
#define AD_EXCITATION_VIDEO_IOS @"AD_EXCITATION_VIDEO_IOS"


#define SD_Normal    [UIImage imageNamed:@"UnLoadImage"]

#define Tap_LaunchImg @"Tap_launch"

#define Normal_STR @"TT"

#define CellID @"CELLID"



NS_ASSUME_NONNULL_BEGIN

@interface XXX_Datautil : NSObject

/// 返回字典对应的key
+ (id)configDic:(NSDictionary *)dic
         forkey:(NSString *)dickey;

/// 判断字典是否包含key
+ (BOOL)configDic:(NSDictionary *)dic
              key:(NSString *)key ;

+ (NSString *)getuploadhtml;
//根据是否是测试服或者正式服获得URL前缀
+ (NSString *)getPrexifURl;
+ (NSString *)getdomainname;
+ (NSString *)getWebSeverUrl;
/// 获取商户ID
+ (NSString *)tengteng_configBiz_id;
/// 获取代码版本号
+ (NSString *)tengteng_configcodeversion;
/// 获取开发环境
+ (NSInteger)tengteng_configenvironment;

+ (UIFont *)confignormalfontsize:(NSInteger)fontsize;

+ (UIFont *)confignormalboldfontsize:(NSInteger)fontsiez;
@end


NS_ASSUME_NONNULL_END
