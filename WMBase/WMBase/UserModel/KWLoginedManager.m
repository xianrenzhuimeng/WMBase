//
//  KWLoginedManager.m
//  westkissMob
//
//  Created by 王猛 on 2022/9/5.
//

#import "KWLoginedManager.h"
#import "TT_GeneralProfile.h"

#import "DataUtil.h"
#import <MJExtension/MJExtension.h>

/// 加密用户字符串  加密信息有错误暂时取消
static NSString *const ksaveLoginedUserAeskey = @"ksaveLoginedUser_aes_007_&_key";

/// 保存登录的用户信息
static NSString *const ksaveLoginedUserJsonkey = @"ksaveLoginedUserJsonkey";

@implementation KWLoginedManager
static  KWLoginedManager *singleClass = nil;

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleClass = [[KWLoginedManager alloc]init];
    });
    return singleClass;
}

#pragma mark 1. 保存用户细信息
-(void)saveLoginedUserJsonDictionary:(NSDictionary *)userJsonDic {
    [DataUtil storeObjectWithKey:ksaveLoginedUserJsonkey objectValue:userJsonDic];
    KWLoginedManager.shareInstance.userModel = [KWLoginedUserModel mj_objectWithKeyValues:userJsonDic];
}

#pragma mark 2. 读取用户信息
-(KWLoginedUserModel *)getCurrentLoginedUser {
    if(isValid(KWLoginedManager.shareInstance.userModel)){
        return KWLoginedManager.shareInstance.userModel;
    }
    NSDictionary *jsonDic = [DataUtil objectOfKey:ksaveLoginedUserJsonkey];
    KWLoginedManager.shareInstance.userModel =  [KWLoginedUserModel mj_objectWithKeyValues:jsonDic];
    return   KWLoginedManager.shareInstance.userModel;
}
-(NSDictionary *)getLoginedUserJsonDictionary {
    NSDictionary *jsonDic = [DataUtil objectOfKey:ksaveLoginedUserJsonkey];
    return jsonDic;
}

#pragma mark 3.清空用户信息
-(void)clearLoginedUser {
    KWLoginedUserModel *user = nil;
    KWLoginedManager.shareInstance.userModel = user;
    [DataUtil storeObjectWithKey:ksaveLoginedUserJsonkey objectValue:@""];
}

@end
