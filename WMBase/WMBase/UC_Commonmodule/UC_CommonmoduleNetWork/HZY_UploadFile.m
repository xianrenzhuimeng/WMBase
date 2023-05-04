//
//  HZY_UploadFile.m
//  火之夜
//
//  Created by linlin dang on 2019/5/8.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "HZY_UploadFile.h"


@interface HZY_UploadFile ()

/**
 通用会话管理器
 */
@property (nonatomic , strong) AFHTTPSessionManager *sessionManager;

@end

@implementation HZY_UploadFile



+ (void)GET:(NSString *)URL
 parameters:(id)parameters
      cache:(void(^)(id _Nullable responseObject))cache
compleSuccess:(void(^)(id  _Nullable responseObject))Success
       fail:(void(^)(NSError * _Nullable error))fail {
  
    cache !=nil ? cache([PPNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    AFHTTPSessionManager *manage = [HZY_UploadFile configsessionManager];
    //设置响应序列化器，解析Json对象
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*",@"image/jpeg",@"image/jpg",@"image/png",@"application/x-javascript",nil];
    manage.responseSerializer = responseSerializer;
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manage GET:URL
     parameters:parameters
        headers:nil
       progress:nil
        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (Success) {
            NSString *responseStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            Success(responseStr);
        }
        //对数据进行异步缓存
        cache !=nil ? [PPNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}





+ (void)POST:(NSString *)URL
  parameters:(id)parameters
       cache:(void(^)(id _Nullable responseObject))cache
compleSuccess:(void(^)(id  _Nullable responseObject))Success
        fail:(void(^)(NSError * _Nullable error))fail {
    cache !=nil ? cache([PPNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    AFHTTPSessionManager *mannager = [HZY_UploadFile configsessionManager];
    [mannager POST:URL
        parameters:parameters
           headers:nil
          progress:nil
           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (Success) {
            Success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}


+ (AFHTTPSessionManager *)configsessionManager {
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc]init];
    sessionManager.requestSerializer.timeoutInterval = 20;
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    // 设置安全策略
    if (![[UC_CommonmoduleNetWorkTool getUserToken] isEqualToString:@""]) {
        [sessionManager.requestSerializer setValue:[UC_CommonmoduleNetWorkTool getUserToken] forHTTPHeaderField:@"token"];
    }
    NSString *token = [sessionManager.requestSerializer valueForHTTPHeaderField:@"token"];
    NSString *now_time = [UC_CommonmoduleNetWorkTool tt_getNowTimeTimestamp];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*",@"image/jpeg",@"image/jpg",@"image/png",@"application/x-javascript",nil];
    sessionManager.responseSerializer = responseSerializer;
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [sessionManager.requestSerializer setValue:app_Version forHTTPHeaderField:@"version"];
    [sessionManager.requestSerializer setValue:[UC_CommonmoduleNetWorkTool tt_getCurrentDeviceModel] forHTTPHeaderField:@"device"];
    [sessionManager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"system"];
    [sessionManager.requestSerializer setValue:[UC_CommonmoduleNetWorkTool tt_getOSVersion] forHTTPHeaderField:@"systemVersion"];
    [sessionManager.requestSerializer setValue:[UC_CommonmoduleNetWorkTool tt_getIDFA] forHTTPHeaderField:@"deviceId"];
    [sessionManager.requestSerializer setValue:now_time forHTTPHeaderField:@"x-t"];
    sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    return sessionManager;  
}


+ (void)PostJsonForURL:(NSString *)URL parameters:(id)parameters compleSuccess:(void(^)(id  _Nullable responseObject))Success fail:(void(^)(NSError * _Nullable error))fail{
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *request =[[AFJSONRequestSerializer serializer]requestWithMethod:@"POST" URLString:URL parameters:parameters error:nil];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"%@",responseObject);
        if (error) {
            if (fail) {
                fail(error);
            }
        }else {
            if (Success) {
                Success(responseObject);
            }
        }
    }];
    
    [task resume];
}




@end
