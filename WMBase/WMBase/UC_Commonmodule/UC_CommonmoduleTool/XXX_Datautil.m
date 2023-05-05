
//
//  XXX_Datautil.m
//  XXX
//
//  Created by 樊腾 on 2020/1/17.
//  Copyright © 2020 绑耀. All rights reserved.
//



#import "XXX_Datautil.h"
#import "PPNetworkCache.h"
#import "Current_normalTool.h"
#import <AdSupport/AdSupport.h>
#import "DataUtil.h"
#import "FTT_Helper.h"
#import "UC_Generalconfig.h"
#import "TT_GeneralProfile.h"
@implementation XXX_Datautil


+ (NSString *)getPrexifURl
{
    NSString *PrexifURL = [NSString stringWithFormat:@"%@/api/%@/",[XXX_Datautil getdomainname],[XXX_Datautil tengteng_configBiz_id]];
    SaveObject(PrexifURL, @"PREXI");
    return PrexifURL;
}

+ (NSString *)getWebSeverUrl
{
    NSString *webServerurl;
    if ([Current_normalTool isBlankString:[DataUtil objectOfKey:@"dingzhiVersion"]]) {
        webServerurl = [NSString stringWithFormat:@"%@/dist/#",[XXX_Datautil getdomainname]];
    }else{
        NSString *versionStr = [NSString stringWithFormat:@"%@",[DataUtil objectOfKey:@"dingzhiVersion"]];
        webServerurl = [NSString stringWithFormat:@"%@/dist/?version=%@/#",[XXX_Datautil getdomainname],versionStr];
    }
    SaveObject(webServerurl, @"WEBSERVER")
    return webServerurl;
}

+ (NSString *)getdomainname
{
    NSString *server;
    if ([XXX_Datautil tengteng_configenvironment]== 0) {
        server = [UC_Generalconfig share_generalconfig].test_server;
    }else if ([XXX_Datautil tengteng_configenvironment]== 2) {
        server = [UC_Generalconfig share_generalconfig].release_server;
    }else {
        server = [UC_Generalconfig share_generalconfig].formal_sercer;
    }
    SaveObject(server, @"SERVER")
    return server;
}

/// 获取商户ID
+ (NSString *)tengteng_configBiz_id{
    return [Current_normalTool tengteng_confignsuserdefaultobjectforkey:@"biz_id" normalobject:@"1"];
}

/// 获取代码版本
+ (NSString *)tengteng_configcodeversion{
    return [Current_normalTool tengteng_confignsuserdefaultobjectforkey:@"cdv" normalobject:@"369"];
}

/// 获取开发环境
+ (NSInteger)tengteng_configenvironment {
    return [[Current_normalTool tengteng_confignsuserdefaultobjectforkey:@"env" normalobject:@"1"] integerValue];
}





+ (BOOL)dataishave:(id)data {
    if ([data isKindOfClass:[NSString class]]) {
        return NO;
    }else {
        return YES;
    }
}






+ (id)configDic:(NSDictionary *)dic forkey:(NSString *)dickey {
    if ([dic.allKeys containsObject:dickey]) {
        return dic[dickey];
    }else {
        return @"0";
    }
}

+ (BOOL)configDic:(NSDictionary *)dic key:(NSString *)key {
    if ([dic isKindOfClass:[NSDictionary class]]) {
        if ([dic.allKeys containsObject:key]) {
               return YES;
           }else {
               return NO;
           }
    }else {
        return NO;
    }
}

+ (NSString *)getuploadhtml{
    return [NSString stringWithFormat:@"%@/uqWeb/config.xml",[XXX_Datautil getdomainname]];
}





+ (UIFont *)confignormalfontsize:(NSInteger)fontsize {
    return [UIFont fontWithName:@"PingFang-SC-Regular" size:fontsize];
}

+ (UIFont *)confignormalboldfontsize:(NSInteger)fontsiez {
    return [UIFont fontWithName:@"Helvetica-Bold" size:fontsiez];
}





@end
