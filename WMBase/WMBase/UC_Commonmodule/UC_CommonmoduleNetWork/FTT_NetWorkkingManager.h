//
//  FTT_NetWorkkingManager.h
//  95128
//
//  Created by 樊腾 on 17/6/9.
//  Copyright © 2017年 FTT. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifdef DEBUG

#define FNSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define FNSLog(...)
#endif
/*
 网络请求类型
 */
typedef NS_ENUM(NSInteger, FTT_APIManagerRequestType) {
    FTT_APIManagerRequestTypeGET = 0,                   // Get
    FTT_APIManagerRequestTypePOST,                      // POST
    FTT_APIManagerRequestTypeUpload,                    // 上传
    FTT_APIManagerRequestTypeDownload ,                  // 下载
    FTT_APIManagerRequestTypeDELECT
    
};

typedef NS_ENUM(NSInteger, FTT_APIManagerErrorType) {
    FTT_APIManagerErrorTypeDefault = 0,       //没有产生过API请求，这个是manager的默认状态。
    FTT_APIManagerErrorTypeSuccess,           //API请求成功且返回数据正确，此时manager的数据是可以直接拿来使用的。
    FTT_APIManagerErrorTypeNoContent,         //API请求成功但返回数据不正确。如果回调数据验证函数返回值为NO，manager的状态就会是这个。
    FTT_APIManagerErrorTypeParamsError,       //参数错误，此时manager不会调用API，因为参数验证是在调用API之前做的。
    FTT_APIManagerErrorTypeTimeout,           //请求超时。ERApiProxy设置的是20秒超时，具体超时时间的设置请自己去看ERApiProxy的相关代码。
    FTT_APIManagerErrorTypeNoNetWork,         //网络不通。在调用API之前会判断一下当前网络是否通畅，这个也是在调用API之前验证的，和上面超时的状态是有区别的。
    FTT_APIManagerErrorTypeInvalidURL,        // 请求失败， 无效的URL
    
    FTT_APIManagerErrorTypeCache,
    
    
};

typedef void(^FTT_Callback)(id responseObject, FTT_APIManagerErrorType errorType);

@interface FTT_NetWorkkingManager : NSObject

+ (instancetype)shareManager;

- (void)configHeadertoken:(NSString *)token;

- (NSURLSessionDataTask *)callApiWithUrl:(NSString *)url params:(NSDictionary *)params requestType:(FTT_APIManagerRequestType)requestType success:(FTT_Callback)success fail:(FTT_Callback)fail;




@end
