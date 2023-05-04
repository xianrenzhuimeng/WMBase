//
//  UC_CommonmoduleNetWorkTool.h
//  AFNetworking
//
//  Created by 樊腾 on 2020/9/10.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UC_CommonmoduleNetWorkTool : NSObject
/** 主要方法 */
/** 类型识别:将所有的NSNull类型转化成@"" */
+(id)tt_changeType:(id)myObj;
//获取版本号
+ (NSString *)getAppVersion;
///获取用户 Token ；如果没有登录返回 @“”
+ (NSString *)getUserToken ;
+ (NSString *)getUser_id ;

//获取当前时间戳
+ (NSString *)tt_getNowTimeTimestamp;
+ (NSString *)tt_getIDFA;
+ (NSString *)tt_getHmacmd5:(NSString *)clearText withSecret:(NSString *)secret;
+ (id)confignsuserdefaultobjectforkey:(NSString *)object normalobject:(NSString *)normal;
+ (NSString *)tt_getCurrentDeviceModel;
+ (NSString *)tt_getOSVersion;
@end

NS_ASSUME_NONNULL_END
