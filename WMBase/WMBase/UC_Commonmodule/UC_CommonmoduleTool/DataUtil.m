//
//  DataUtil.m
//  FlowerShow
//
//  Created by sevenga1473 on 16/5/7.
//  Copyright © 2016年 王晗. All rights reserved.
//


#import "DataUtil.h"
#import "FTT_Helper.h"
#define UserInfo            @"userinfo"
#define Avatar_Path         @"avatarPath"
#define Invite_Code         @"inviteCode"
#define Mobile_Phone         @"mobilePhone"
#define Nick_Name         @"nickName"
#define Real_Name         @"realName"
#define Referrer_Mobile      @"referrerMobile"
#define Login_Token      @"loginToken"
#define Login_Uid      @"loginUid"
#define pay_password   @"pay_password"
#define FirstDesign_Str      @"firstDesignStr"
#define SuperEntranceDesign_Str @"superEntranceDesignStr"
#define TabBarDesign_Str      @"tabbarDesignStr"
#define MyPageDesign_Str      @"myPageDesignStr"
#define WxNum_Str   @"wxNumStr"
#define AliNum_Str   @"aliNumStr"
#define AliName_Str   @"aliNameStr"
#define AllPageBanner_Str   @"pagebannerStr"
#define BobaoListStr   @"BobaoListStr"
#define WechatOpenID    @"wechatOpenID"
#define IsOperator    @"isOperator"
#define GlobalSearchStr    @"GlobalSearchStr"
#define SearchIndex     @"searchIndex"
#define AppIsFirstLaunch    @"AppIsFirstLaunch"
#define FirstPageMainColor  @"FirstPageMainColor"
#define FirstPageSecondColor  @"FirstPageSecondColor"
#define FirstPageThirdColor  @"FirstPageThirdColor"
#define FirstPageChannelStr @"FirstPageChannelStr"
#define ISAppStoreReview    @"isAppstoreReview"
#define IsSuscessALiBaiChuan  @"IsSuscessALiBaiChuan"

@implementation DataUtil

static NSUserDefaults * userDefaults;

+ (NSUserDefaults *) defaults{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        userDefaults = [NSUserDefaults standardUserDefaults];
    });
    return userDefaults;
}


+ (BOOL)storeObjectWithKey:(NSString *)key value:(NSString *)value{
    
    [[self defaults] setObject:value forKey:key];
    
    return [[self defaults] synchronize];
}

+ (BOOL)storeObjectWithKey:(NSString *)key objectValue:(id)value{
    
    [[self defaults] setObject:value forKey:key];
    
    return [[self defaults] synchronize];
}

+ (id)objectOfKeyArr:(NSString *)key{
    
    return [self cleanNilArr:[[self defaults] objectForKey:key]];
}

+ (id)objectOfKey:(NSString *)key{
    
    return [self cleanNil:[[self defaults] objectForKey:key]];
}

#pragma mark - clean nil
+ (NSString *)cleanNil:(NSString *)str{
    
    return ( ( str == nil || str == NULL ) || (NSNull *)str == [NSNull null]) ? @"" : str;
}

+(NSMutableArray *)cleanNilArr:(NSMutableArray *)arr{
    
    NSMutableArray *muarr = [NSMutableArray arrayWithCapacity:0];
    
    return ( ( arr == nil || arr == NULL ) || (NSNull *)arr == [NSNull null]) ? muarr : arr;
}

#pragma mark -avatarPath 用户头像地址
+ (NSString *)avatarPath{
    return [self objectOfKey:Avatar_Path];
}
+ (void)setAvatarPath:(NSString *)avatarPath{
    [self storeObjectWithKey:Avatar_Path value:avatarPath];
}

+ (NSDictionary *)userinfo {
    NSString *dicStr = [self objectOfKey:UserInfo];
    return [FTT_Helper dictionaryWithJsonString:dicStr];
}

+ (void)setUserInfo:(NSString *)userinfo {
    [self storeObjectWithKey:UserInfo objectValue:userinfo];
}
#pragma mark -setInviteCode  用户邀请码
+ (NSString *)inviteCode{
    return [self objectOfKey:Invite_Code];
}
+ (void)setInviteCode:(NSString *)inviteCode{
    [self storeObjectWithKey:Invite_Code value:inviteCode];
}

#pragma mark -setmobilePhone  用户手机号码
+ (NSString *)mobilePhone{
    return [self objectOfKey:Mobile_Phone];
}
+ (void)setMobilePhone:(NSString *)mobilePhone{
    [self storeObjectWithKey:Mobile_Phone value:mobilePhone];
}

#pragma mark - nickName  用户名
+ (NSString *)nickName{
    return [self objectOfKey:Nick_Name];
}
+ (void)setNickName:(NSString *)nickName{
    [self storeObjectWithKey:Nick_Name value:nickName];
}

#pragma mark - realName  用户真实姓名
+ (NSString *)realName{
    return [self objectOfKey:Real_Name];
}
+ (void)setRealName:(NSString *)realName{
    [self storeObjectWithKey:Real_Name value:realName];
}

#pragma mark - referrerMobile  推荐人手机号
+ (NSString *)referrerMobile{
    return [self objectOfKey:Referrer_Mobile];
}
+ (void)setReferrerMobile:(NSString *)referrerMobile{
    [self storeObjectWithKey:Referrer_Mobile value:referrerMobile];
}

#pragma mark - loginToken  用户登录token
+ (NSString *)loginToken{
    return [self objectOfKey:Login_Token];
}
+ (void)setLoginToken:(NSString *)loginToken{
    [self storeObjectWithKey:Login_Token value:loginToken];
}

#pragma mark - loginUid  用户uid
+ (NSString *)loginUid{
    return [self objectOfKey:Login_Uid];
}
+ (void)setLoginUid:(NSString *)loginUid{
    [self storeObjectWithKey:Login_Uid value:loginUid];
}


+ (NSString *)paypassword {
    return [self objectOfKey:pay_password];
}

+ (void)setpaypassword:(NSString *)paypassword {
    [self storeObjectWithKey:pay_password value:paypassword];
}

#pragma mark -setFirstPageDesignStr  首页装修数据
+ (NSString *)firstPageDesignStr{
    return [self objectOfKey:FirstDesign_Str];
}
+ (void)setFirstPageDesignStr:(NSString *)firstPageDesignStr{
    [self storeObjectWithKey:FirstDesign_Str value:firstPageDesignStr];
}

#pragma mark - superEntrancePageDesignStr  超级入口装修数据
+ (NSString *)superEntrancePageDesignStr {
    return [self objectOfKey:SuperEntranceDesign_Str];
}
+ (void)setSuperEntrancePageDesignStr:(NSString *)superEntrancePageDesignStr {
    [self storeObjectWithKey:SuperEntranceDesign_Str value:superEntrancePageDesignStr];
}

#pragma mark -setTabBarDesignStr  tabbar装修数据
+ (NSString *)tabBarDesignStr{
    return [self objectOfKey:TabBarDesign_Str];
}
+ (void)setTabBarDesignStr:(NSString *)tabBarDesignStr{
    [self storeObjectWithKey:TabBarDesign_Str value:tabBarDesignStr];
}

#pragma mark -setMyPageDesignStr  我的页面装修数据
+ (NSString *)myPageDesignStr{
    return [self objectOfKey:MyPageDesign_Str];
}
+ (void)setMyPageDesignStr:(NSString *)myPageDesignStr{
    [self storeObjectWithKey:MyPageDesign_Str value:myPageDesignStr];
}

#pragma mark -setWxNumStr 储存wxnumstr
+ (NSString *)wxNumStr{
    return [self objectOfKey:WxNum_Str];
}
+ (void)setWxNumStr:(NSString *)wxNumStr{
    [self storeObjectWithKey:WxNum_Str value:wxNumStr];
}

#pragma mark -setAliNumStr 储存alinumstr
+ (NSString *)aliNumStr{
    return [self objectOfKey:AliNum_Str];
}
+ (void)setAliNumStr:(NSString *)aliNumStr{
    [self storeObjectWithKey:AliNum_Str value:aliNumStr];
}

#pragma mark -setAliNameStr 储存aliNamestr

+ (NSString *)aliNameStr {
    return [self objectOfKey:AliName_Str];
}

+(void)setAliNameStr:(NSString *)aliNameStr {
    [self storeObjectWithKey:AliName_Str value:aliNameStr];
    
}

#pragma mark - AllPageBannerStr 储存页面bannersStr
+ (NSString *)pageBannerStr{
    return [self objectOfKey:AllPageBanner_Str];
}
+ (void)setPageBannerStr:(NSString *)pageBannerStr{
    [self storeObjectWithKey:AllPageBanner_Str value:pageBannerStr];
}

#pragma mark - BobaoListStr 储存首页头条播报数据
+ (NSString *)bobaoListStr{
    return [self objectOfKey:BobaoListStr];
}
+ (void)setBobaoListStr:(NSString *)bobaoListStr{
    [self storeObjectWithKey:BobaoListStr value:bobaoListStr];
}

#pragma mark - WeChatOpenID  微信登录openID
+ (NSString *)weChatOpenID{
    
    return [self objectOfKey:WechatOpenID];
}
+ (void)setWeChatOpenID:(NSString *)weChatOpenID{
    
    [self storeObjectWithKey:WechatOpenID value:weChatOpenID];
}

#pragma mark - Operator  是否为运营商
+ (NSString *)isOperator{
    
    return [self objectOfKey:IsOperator];
}
+ (void)setIsOperator:(NSString *)isOperator{
    
    [self storeObjectWithKey:IsOperator value:isOperator];
}

#pragma mark - globalSearchStr 搜索数据
+ (NSString *)globalSearchStr{
    
    return [self objectOfKey:GlobalSearchStr];
}
+ (void)setGlobalSearchStr:(NSString *)globalSearchStr{
    
    [self storeObjectWithKey:GlobalSearchStr value:globalSearchStr];
}

#pragma mark - SearchIndex  搜索页面选择平台标示
+ (NSString *)searchIndex{
    
    return [self objectOfKey:SearchIndex];
}
+ (void)setSearchIndex:(NSString *)searchIndex{
    
    [self storeObjectWithKey:SearchIndex value:searchIndex];
}

#pragma mark - AppIsFirstLaunch  app是否第一次启动
+ (NSString *)appIsFirstLaunch{
    
    return [self objectOfKey:AppIsFirstLaunch];
}
+ (void)setAppIsFirstLaunch:(NSString *)appIsFirstLaunch{
    
    [self storeObjectWithKey:AppIsFirstLaunch value:appIsFirstLaunch];
}


+(NSString *)appALiBaiChuanStaus
{
    return [self objectOfKey:IsSuscessALiBaiChuan];
}

+(void )setAppALiBaiChuanStaus:(NSString *)aliBaiChuanStr
{
    [self storeObjectWithKey:IsSuscessALiBaiChuan value:aliBaiChuanStr];

}


#pragma mark - FirstPageMainColor  首页主色
+ (NSString *)firstPageMainColor{
    
    return [self objectOfKey:FirstPageMainColor];
}
+ (void)setFirstPageMainColor:(NSString *)firstPageMainColor{
    
    [self storeObjectWithKey:FirstPageMainColor value:firstPageMainColor];
}

#pragma mark - FirstPageSecondColor  首页二级色
+ (NSString *)firstPageSecondColor{
    
    return [self objectOfKey:FirstPageSecondColor];
}
+ (void)setFirstPageSecondColor:(NSString *)firstPageSecondColor{
    
    [self storeObjectWithKey:FirstPageSecondColor value:firstPageSecondColor];
}

#pragma mark - FirstPageThirdColor  首页三级色
+ (NSString *)firstPageThirdColor{
    
    return [self objectOfKey:FirstPageThirdColor];
}
+ (void)setFirstPageThirdColor:(NSString *)firstPageThirdColor{
    
    [self storeObjectWithKey:FirstPageThirdColor value:firstPageThirdColor];
}

#pragma mark - FirstPageChannelStr  首页分类str
+ (NSString *)firstPageChannelStr{
    
    return [self objectOfKey:FirstPageChannelStr];
}
+ (void)setFirstPageChannelStr:(NSString *)firstPageChannelStr{
    
    [self storeObjectWithKey:FirstPageChannelStr value:firstPageChannelStr];
}

#pragma mark - Is_AppstoreReview  是否审核专用
+ (NSString *)isAppStoreReview{
    
    return [self objectOfKey:ISAppStoreReview];
}
+ (void)setIsAppStoreReview:(NSString *)isAppStoreReview{
    
    [self storeObjectWithKey:ISAppStoreReview value:isAppStoreReview];
}

@end
