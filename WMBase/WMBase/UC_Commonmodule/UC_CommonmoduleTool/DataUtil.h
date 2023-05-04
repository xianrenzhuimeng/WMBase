//
//  DataUtil.h
//  FlowerShow
//
//  Created by sevenga1473 on 16/5/7.
//  Copyright © 2016年 王晗. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataUtil : NSObject


+ (BOOL)storeObjectWithKey:(NSString *)key value:(NSString*)value; //存储字符串
+ (BOOL)storeObjectWithKey:(NSString *)key objectValue:(id)value; //存储对象

+ (id)objectOfKey:(NSString *)key;
+ (id)objectOfKeyArr:(NSString *)key;


#pragma mark -setAvatarPath  用户头像地址
+ (NSString *)avatarPath;
+ (void)setAvatarPath:(NSString *)avatarPath;

#pragma mark -setInviteCode  用户邀请码
+ (NSString *)inviteCode;
+ (void)setInviteCode:(NSString *)inviteCode;

#pragma mark -setmobilePhone  用户手机号码
+ (NSString *)mobilePhone;
+ (void)setMobilePhone:(NSString *)mobilePhone;

#pragma mark - nickName  用户名
+ (NSString *)nickName;
+ (void)setNickName:(NSString *)nickName;

#pragma mark - realName  用户真实姓名
+ (NSString *)realName;
+ (void)setRealName:(NSString *)realName;

#pragma mark - referrerMobile  推荐人手机号
+ (NSString *)referrerMobile;
+ (void)setReferrerMobile:(NSString *)referrerMobile;

#pragma mark - loginToken  用户登录token
+ (NSString *)loginToken;
+ (void)setLoginToken:(NSString *)loginToken;

#pragma mark - loginUid  用户uid
+ (NSString *)loginUid;
+ (void)setLoginUid:(NSString *)loginUid;

#pragma mark -setFirstPageDesignStr  首页装修数据
+ (NSString *)firstPageDesignStr;
+ (void)setFirstPageDesignStr:(NSString *)firstPageDesignStr;

#pragma mark - superEntrancePageDesignStr  超级入口装修数据
+ (NSString *)superEntrancePageDesignStr;
+ (void)setSuperEntrancePageDesignStr:(NSString *)superEntrancePageDesignStr;

#pragma mark -setTabBarDesignStr  tabbar装修数据
+ (NSString *)tabBarDesignStr;
+ (void)setTabBarDesignStr:(NSString *)tabBarDesignStr;

#pragma mark -setMyPageDesignStr  我的页面装修数据
+ (NSString *)myPageDesignStr;
+ (void)setMyPageDesignStr:(NSString *)myPageDesignStr;

#pragma mark -setWxNumStr 储存wxnumstr
+ (NSString *)wxNumStr;
+ (void)setWxNumStr:(NSString *)wxNumStr;

#pragma mark -setAliNumStr 储存alinumstr
+ (NSString *)aliNumStr;
+ (void)setAliNumStr:(NSString *)aliNumStr;

#pragma mark - AllPageBannerStr 储存页面bannersStr
+ (NSString *)pageBannerStr;
+ (void)setPageBannerStr:(NSString *)pageBannerStr;

#pragma mark - BobaoListStr 储存首页头条播报数据
+ (NSString *)bobaoListStr;
+ (void)setBobaoListStr:(NSString *)bobaoListStr;

#pragma mark - WeChatOpenID  微信登录openID
+ (NSString *)weChatOpenID;
+ (void)setWeChatOpenID:(NSString *)weChatOpenID;

#pragma mark - Operator  是否为运营商
+ (NSString *)isOperator;
+ (void)setIsOperator:(NSString *)isOperator;

#pragma mark - globalSearchStr 搜索数据
+ (NSString *)globalSearchStr;
+ (void)setGlobalSearchStr:(NSString *)globalSearchStr;

#pragma mark - SearchIndex  搜索页面选择平台标示
+ (NSString *)searchIndex;
+ (void)setSearchIndex:(NSString *)searchIndex;

#pragma mark - AppIsFirstLaunch  app是否第一次启动
+ (NSString *)appIsFirstLaunch;
+ (void)setAppIsFirstLaunch:(NSString *)appIsFirstLaunch;

#pragma mark - ALiBaiChuanStaus   阿里百川初始化是否成功
+(NSString *)appALiBaiChuanStaus;
+(void)setAppALiBaiChuanStaus:(NSString *)aliBaiChuanStatus;

#pragma mark - FirstPageMainColor  首页主色
+ (NSString *)firstPageMainColor;
+ (void)setFirstPageMainColor:(NSString *)firstPageMainColor;

#pragma mark - FirstPageSecondColor  首页二级色
+ (NSString *)firstPageSecondColor;
+ (void)setFirstPageSecondColor:(NSString *)firstPageSecondColor;

#pragma mark - FirstPageThirdColor  首页三级色
+ (NSString *)firstPageThirdColor;
+ (void)setFirstPageThirdColor:(NSString *)firstPageThirdColor;

#pragma mark - FirstPageChannelStr  首页分类str
+ (NSString *)firstPageChannelStr;
+ (void)setFirstPageChannelStr:(NSString *)firstPageChannelStr;



+ (NSString *)isAppStoreReview;
+ (void)setIsAppStoreReview:(NSString *)isAppStoreReview;


#pragma mark - FirstPageChannelStr  用户信息
+ (NSDictionary *)userinfo;
+ (void)setUserInfo:(NSString *)userinfo;


+ (NSString *)paypassword;
+ (void)setpaypassword:(NSString *)paypassword;


#pragma mark -setAliNameStr 储存aliNamestr

+ (NSString *)aliNameStr;
+(void)setAliNameStr:(NSString *)aliNameStr;
@end
