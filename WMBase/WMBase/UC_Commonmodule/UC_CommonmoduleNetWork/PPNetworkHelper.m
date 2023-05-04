//
//  PPNetworkHelper.m
//  PPNetworkHelper
//
//  Created by AndyPang on 16/8/12.
//  Copyright © 2016年 AndyPang. All rights reserved.
//


#import "PPNetworkHelper.h"
#import "HZY_UploadFile.h"
#ifdef DEBUG
#define PPLog(...) printf("[%s] %s [第%d行]: %s\n", __TIME__ ,__PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define PPLog(...)
#endif

#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

@implementation PPNetworkHelper

static BOOL _isOpenLog;   // 是否已开启日志打印
static NSMutableArray *_allSessionTask;
static AFHTTPSessionManager *_sessionManager;

#pragma mark - 开始监听网络
+ (void)networkStatusWithBlock:(PPNetworkStatus)networkStatus {
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                networkStatus ? networkStatus(PPNetworkStatusUnknown) : nil;
                if (_isOpenLog) PPLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                networkStatus ? networkStatus(PPNetworkStatusNotReachable) : nil;
                if (_isOpenLog) PPLog(@"无网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                networkStatus ? networkStatus(PPNetworkStatusReachableViaWWAN) : nil;
                if (_isOpenLog) PPLog(@"手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                networkStatus ? networkStatus(PPNetworkStatusReachableViaWiFi) : nil;
                if (_isOpenLog) PPLog(@"WIFI");
                break;
        }
    }];

}

+ (BOOL)isNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+ (BOOL)isWWANNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

+ (BOOL)isWiFiNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

+ (void)openLog {
    _isOpenLog = YES;
}

+ (void)closeLog {
    _isOpenLog = NO;
}

+ (void)cancelAllRequest {
    // 锁操作
    @synchronized(self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
        [[self allSessionTask] removeAllObjects];
    }
}

+ (void)cancelRequestWithURL:(NSString *)URL {
    if (!URL) { return; }
    @synchronized (self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task.currentRequest.URL.absoluteString hasPrefix:URL]) {
                [task cancel];
                [[PPNetworkHelper allSessionTask] removeObject:task];
                *stop = YES;
            }
        }];
    }
}

#pragma mark - GET请求无缓存
+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
                  success:(PPHttpRequestSuccess)success
                  failure:(PPHttpRequestFailed)failure {
    return [self GET:URL parameters:parameters responseCache:nil success:success failure:failure];
}

#pragma mark - POST请求无缓存
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
                   success:(PPHttpRequestSuccess)success
                   failure:(PPHttpRequestFailed)failure {
    return [self POST:URL parameters:parameters responseCache:nil success:success failure:failure isSetToken:NO];
}

#pragma mark - GET请求自动缓存
+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
            responseCache:(PPHttpRequestCache)responseCache
                  success:(PPHttpRequestSuccess)success
                  failure:(PPHttpRequestFailed)failure {
    //读取缓存
    responseCache!=nil ? responseCache([PPNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    
    _sessionManager = [HZY_UploadFile configsessionManager];
    NSURLSessionTask *sessionTask = [_sessionManager GET:URL
                                              parameters:parameters
                                                 headers:nil
                                                progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         

        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *allHeaders = response.allHeaderFields;
        NSLog(@"header:%@",allHeaders);
        NSLog(@"response:%@",responseObject);

        responseObject = [UC_CommonmoduleNetWorkTool tt_changeType:responseObject];
        if (_isOpenLog) {PPLog(@"URL = %@",URL);}
        if (_isOpenLog) {PPLog(@"responseObject = %@",responseObject);}
        if ([responseObject[@"code"] integerValue] == 401) return;
        success ? success(responseObject) : nil;
        if ([responseObject[@"code"] integerValue] ==0) {
           //对数据进行异步缓存
           responseCache!=nil ? [PPNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        }
        [[self allSessionTask] removeObject:task];
      
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (_isOpenLog) {PPLog(@"error = %@",error);}
        [[PPNetworkHelper allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
        
    }];
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    return sessionTask;
}

#pragma mark - POST请求自动缓存

+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
            responseCache:(PPHttpRequestCache)responseCache
                  success:(PPHttpRequestSuccess)success
                  failure:(PPHttpRequestFailed)failure
               isSetToken:(BOOL)isSetToken {
    responseCache!=nil ? responseCache([PPNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    
    _sessionManager = [HZY_UploadFile configsessionManager];
    // 打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    NSURLSessionTask *sessionTask = [_sessionManager GET:URL
                                              parameters:parameters
                                                 headers:nil
                                                progress:nil
                                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        responseObject = [UC_CommonmoduleNetWorkTool tt_changeType:responseObject];
        if (_isOpenLog) {PPLog(@"URL = %@",URL);}
        if (_isOpenLog) {PPLog(@"header = %@",task.currentRequest.allHTTPHeaderFields);}
        if (_isOpenLog) {PPLog(@"responseObject = %@",responseObject);}
        
        if ([responseObject[@"code"] integerValue] == 401) {
            NSLog(@"数据格式不合法");
            return;
        }
        
        if ([responseObject[@"code"] integerValue] ==0) {
             responseCache!=nil ? [PPNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        }
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (_isOpenLog) {PPLog(@"error = %@",error);}
        [[PPNetworkHelper allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
    
}


+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
             responseCache:(PPHttpRequestCache)responseCache
                   success:(PPHttpRequestSuccess)success
                   failure:(PPHttpRequestFailed)failure
                isSetToken:(BOOL)isSetToken{
    //读取缓存
    responseCache!=nil ? responseCache([PPNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    // 打开状态栏的等待菊花
    _sessionManager = [HZY_UploadFile configsessionManager];
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL
                                               parameters:parameters
                                                  headers:nil
                                                 progress:nil
                                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        responseObject = [UC_CommonmoduleNetWorkTool tt_changeType:responseObject];
        if (_isOpenLog) {PPLog(@"URL = %@ ,\n params = %@",URL,parameters);}
//        if (_isOpenLog) {PPLog(@"header = %@",task.currentRequest.allHTTPHeaderFields);}
        if (_isOpenLog) {PPLog(@"responseObject = %@",responseObject);}
        //对数据进行异步缓存
        if (((NSNumber *)responseObject[@"code"]).integerValue ==200) {
            responseCache !=nil ? [PPNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        }
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (_isOpenLog) {PPLog(@"URL = %@ ,\n params = %@",URL,parameters);}
        if (_isOpenLog) {PPLog(@"error = %@",error);}
        [[PPNetworkHelper allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
        NSLog(@"%@",error);
    }];
    // 添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    return sessionTask;
}

#pragma mark - 上传文件
+ (NSURLSessionTask *)uploadFileWithURL:(NSString *)URL
                             parameters:(id)parameters
                                   name:(NSString *)name
                               filePath:(NSString *)filePath
                               progress:(PPHttpProgress)progress
                                success:(PPHttpRequestSuccess)success
                                failure:(PPHttpRequestFailed)failure {

    NSURLSessionTask *sessionTask = [_sessionManager POST:URL
                                               parameters:parameters
                                                  headers:nil
                                constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSError *error = nil;
        [formData appendPartWithFileURL:[NSURL URLWithString:filePath] name:name error:&error];
        (failure && error) ? failure(error) : nil;
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (_isOpenLog) {PPLog(@"responseObject = %@",responseObject);}
        [[PPNetworkHelper allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (_isOpenLog) {PPLog(@"error = %@",error);}
        [[PPNetworkHelper allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
        
    }];
    // 添加sessionTask到数组
    sessionTask ? [[PPNetworkHelper allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark - 上传多张图片
+ (NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                               parameters:(id)parameters
                                     name:(NSString *)name
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                               imageScale:(CGFloat)imageScale
                                imageType:(NSString *)imageType
                                 progress:(PPHttpProgress)progress
                                  success:(PPHttpRequestSuccess)success
                                  failure:(PPHttpRequestFailed)failure {
    
    AFHTTPSessionManager *  sessionManager = [AFHTTPSessionManager manager];
    sessionManager.requestSerializer.timeoutInterval = 15.f;
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*",@"image/jpeg",@"image/jpg",@"image/png" ,nil];

    NSURLSessionTask *sessionTask = [sessionManager POST:URL
                                              parameters:parameters
                                                 headers:nil
                               constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSUInteger i = 0; i < images.count; i++) {
                   // 图片经过等比压缩后得到的二进制文件
                   NSData *imageData = UIImageJPEGRepresentation(images[i], imageScale ?: 1.f);
                   // 默认图片的文件名, 若fileNames为nil就使用
                   
                   NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                   formatter.dateFormat = @"yyyyMMddHHmmss";
                   NSString *str = [formatter stringFromDate:[NSDate date]];
                   NSString *imageFileName = NSStringFormat(@"%@%ld.%@",str,i,imageType?:@"jpg");
                   
                   [formData appendPartWithFileData:imageData
                                               name:name
                                           fileName:fileNames ? NSStringFormat(@"%@.%@",fileNames[i],imageType?:@"jpg") : imageFileName
                                           mimeType:NSStringFormat(@"image/%@",imageType ?: @"jpg")];
               }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (_isOpenLog) {PPLog(@"responseObject = %@",responseObject);}
        [[PPNetworkHelper allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (_isOpenLog) {PPLog(@"error = %@",error);}
        [[PPNetworkHelper allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
        
    }];
                                     
    // 添加sessionTask到数组
    sessionTask ? [[PPNetworkHelper allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark - 下载文件
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(PPHttpProgress)progress
                              success:(void(^)(NSString *))success
                              failure:(PPHttpRequestFailed)failure {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    __block NSURLSessionDownloadTask *downloadTask = [_sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        [[PPNetworkHelper allSessionTask] removeObject:downloadTask];
        if(failure && error) {failure(error) ; return ;};
        success ? success(filePath.absoluteString /** NSURL->NSString*/) : nil;
        
    }];
    //开始下载
    [downloadTask resume];
    // 添加sessionTask到数组
    downloadTask ? [[PPNetworkHelper allSessionTask] addObject:downloadTask] : nil ;
    
    return downloadTask;
}

/**
 存储着所有的请求task数组
 */
+ (NSMutableArray *)allSessionTask {
    if (!_allSessionTask) {
        _allSessionTask = [[NSMutableArray alloc] init];
    }
    return _allSessionTask;
}

#pragma mark - 初始化AFHTTPSessionManager相关属性
/**
 开始监测网络状态
 */
+ (void)load {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}
/**
 *  所有的HTTP请求共享一个AFHTTPSessionManager
 *  原理参考地址:http://www.jianshu.com/p/5969bbb4af9f
 */
+ (void)initialize {
    _sessionManager = [AFHTTPSessionManager manager];
    _sessionManager.requestSerializer.timeoutInterval = 15.f;
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*",@"image/jpeg",@"image/jpg",@"image/png" ,nil];
    // 打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

#pragma mark - 重置AFHTTPSessionManager相关属性

+ (void)setAFHTTPSessionManagerProperty:(void (^)(AFHTTPSessionManager *))sessionManager {
    sessionManager ? sessionManager(_sessionManager) : nil;
}

+ (void)setRequestSerializer:(PPRequestSerializer)requestSerializer {
    _sessionManager.requestSerializer = requestSerializer==PPRequestSerializerHTTP ? [AFHTTPRequestSerializer serializer] : [AFJSONRequestSerializer serializer];
}

+ (void)setResponseSerializer:(PPResponseSerializer)responseSerializer {
    _sessionManager.responseSerializer = responseSerializer==PPResponseSerializerHTTP ? [AFHTTPResponseSerializer serializer] : [AFJSONResponseSerializer serializer];
}

+ (void)setRequestTimeoutInterval:(NSTimeInterval)time {
    _sessionManager.requestSerializer.timeoutInterval = time;
}

+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [_sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}

+ (void)openNetworkActivityIndicator:(BOOL)open {
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:open];
}

+ (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName {
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    // 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 如果需要验证自建证书(无效证书)，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    // 是否需要验证域名，默认为YES;
    securityPolicy.validatesDomainName = validatesDomainName;
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];
    
    [_sessionManager setSecurityPolicy:securityPolicy];
}

@end


#pragma mark - NSDictionary,NSArray的分类
/*
 ************************************************************************************
 *新建NSDictionary与NSArray的分类, 控制台打印json数据中的中文
 ************************************************************************************
 */

#ifdef DEBUG
@implementation NSArray (PP)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    [strM appendString:@")"];
    
    return strM;
}

@end

@implementation NSDictionary (PP)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}
@end
#endif

