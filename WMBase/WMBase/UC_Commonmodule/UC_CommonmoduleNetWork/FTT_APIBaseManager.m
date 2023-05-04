//
//  FTT_APIBaseManager.m
//  95128
//
//  Created by 樊腾 on 17/6/9.
//  Copyright © 2017年 FTT. All rights reserved.
//

#import "FTT_APIBaseManager.h"
#ifdef DEBUG
#define FNSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define FNSLog(...)
#endif


NSString *const HttpCaChe = @"HttpRequestCaChe";

@interface FTT_APIBaseManager ()

@property (nonatomic, copy, readwrite) NSString *errorMessage;
@property (nonatomic, readwrite) FTT_APIManagerErrorType errorType;

@property (nonatomic, strong) NSURLSessionTask *task;

@end



@implementation FTT_APIBaseManager


- (instancetype)init {
    self = [super init];
    if (self) {
        self.delegate = nil;
        self.DataSource = nil;
        self.task = nil;
        self.params = nil;
        self.Is_Cache = NO;
        self.errorType = FTT_APIManagerErrorTypeDefault;
        self.responseObject = nil;
    }
    return self;
}


- (void)loadData {
    if (self.DataSource) {
        if ([self.DataSource respondsToSelector:@selector(paramsForApi:)]) {
            self.params = [self.DataSource paramsForApi:self];
        }
    }else {
        self.params = nil;
    }
    
    NSDate *now = [NSDate new];
    NSString *lastTime = [[NSUserDefaults standardUserDefaults]objectForKey:@"lastT"];
    NSString *lastR =  [[NSUserDefaults standardUserDefaults]objectForKey:@"lastR"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *last = [dateFormatter dateFromString:lastTime];
    NSTimeInterval delta = now.timeIntervalSince1970 - last.timeIntervalSince1970;
    NSString *CacheStr = [NSString stringWithFormat:@"%@%@%@",self.requestUrl,self.params,[UC_CommonmoduleNetWorkTool getUserToken]];
    if (![YYReachability reachability].isReachable) {
        
        id cacheData = [PPNetworkCache httpCacheForURL:self.requestUrl parameters:self.params];
        if (cacheData != nil) {
            self.Is_requestHaveCahce = YES;
            self.errorType = FTT_APIManagerErrorTypeCache;
            if ([self.delegate respondsToSelector:@selector(managerCallAPIDidSuccess:)]) {
                self.responseObject = cacheData;
                [self.delegate managerCallAPIDidSuccess:self];
                self.task = nil;
            }
            return;
        }else {
            self.Is_requestHaveCahce = NO;
            if ([self.delegate respondsToSelector:@selector(managerCallAPIDidFailed:)]) {
                  [self.delegate managerCallAPIDidFailed:self];
                  self.task = nil;
                  return;
              }
        }
    }else if ([lastR isEqualToString:CacheStr] && (int)delta < 10) {
        id cacheData = [PPNetworkCache httpCacheForURL:self.requestUrl parameters:self.params];
        if (cacheData != nil) {
            self.errorType =  FTT_APIManagerErrorTypeCache;
            self.Is_requestHaveCahce = YES;
            if ([self.delegate respondsToSelector:@selector(managerCallAPIDidSuccess:)]) {
                self.responseObject = cacheData;
                [self.delegate managerCallAPIDidSuccess:self];
                self.task = nil;
                return;
            }
            
        }
    }else if (self.Is_Cache) {
        id cacheData =[PPNetworkCache httpCacheForURL:self.requestUrl parameters:self.params];
        if (cacheData != nil) {
            self.Is_requestHaveCahce = YES;
            self.errorType = FTT_APIManagerErrorTypeCache;
            if ([self.delegate respondsToSelector:@selector(managerCallAPIDidSuccess:)]) {
                self.responseObject = cacheData;
                [self.delegate managerCallAPIDidSuccess:self];
            }
        }
    }
    [[NSUserDefaults standardUserDefaults] setValue:CacheStr forKey:@"lastR"];
    [[NSUserDefaults standardUserDefaults] setValue:[self tt_loadNewTime:@"yyyyMMddHHmmss"] forKey:@"lastT"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    __weak typeof(self)weakself = self;
    self.task = [[FTT_NetWorkkingManager shareManager]callApiWithUrl:self.requestUrl params:self.params requestType:self.requestType success:^(id responseObject, FTT_APIManagerErrorType errorType) {
        FNSLog(@"-------%@",weakself.requestMark);
        if (weakself.delegate) {
            if (errorType == FTT_APIManagerErrorTypeSuccess) {
                if ([weakself.delegate respondsToSelector:@selector(managerCallAPIDidSuccess:)]) {
                    weakself.responseObject = [UC_CommonmoduleNetWorkTool tt_changeType:responseObject];
                    weakself.errorType = FTT_APIManagerErrorTypeSuccess;
                    id cacheData = [PPNetworkCache httpCacheForURL:self.requestUrl parameters:self.params];;
                    if (cacheData != nil) {
                        if (self.is_updatarequesecache) {
                            self.Is_requestHaveCahce = NO;
                            [weakself.delegate managerCallAPIDidSuccess:weakself];
                        }else {
                            if (!self.Is_Cache) {
                                self.Is_requestHaveCahce = NO;
                                [weakself.delegate managerCallAPIDidSuccess:weakself];
                            }else {
                               self.Is_requestHaveCahce = YES;
                            }
                        }
                    }else {
                        self.Is_requestHaveCahce = NO;
                        [weakself.delegate managerCallAPIDidSuccess:weakself];
                    }
                    FNSLog(@"---------==========----------%@",responseObject);
                    if (self.Is_Cache && [responseObject[@"code"] integerValue] == 0) {
                        [weakself initCache:responseObject url:self.requestUrl parameters:self.params];
                    }
                    weakself.task = nil;
                }
            }else {
                weakself.errorType = errorType;
                if ([weakself.delegate respondsToSelector:@selector(managerCallAPIDidFailed:)]) {
                    [weakself.delegate managerCallAPIDidFailed:weakself];
                    weakself.task = nil;
                }
            }
        }
    } fail:^(id responseObject, FTT_APIManagerErrorType errorType) {
        weakself.errorType = errorType;
        FNSLog(@"%@",responseObject);

        switch (weakself.errorType) {
            case FTT_APIManagerErrorTypeNoNetWork:
                weakself.errorMessage = NSLocalizedString(@"APIManagerErrorTypeNoNetwork", nil);
                break;

            case FTT_APIManagerErrorTypeDefault:
                weakself.errorMessage = NSLocalizedString(@"APIManagerErrorTypeDefault", nil);
                break;

            case FTT_APIManagerErrorTypeTimeout:
                weakself.errorMessage = NSLocalizedString(@"APIManagerErrorTypeTimeout", nil);
                break;

            default:
                weakself.errorMessage = @"";
                break;
        }
        if (weakself.delegate) {
            if ([weakself.delegate respondsToSelector:@selector(managerCallAPIDidFailed:)]) {
                [weakself.delegate managerCallAPIDidFailed:weakself];
                weakself.task = nil;
            }
        }
    }];
}

- (void)LoadCache:(FTT_APIManagerErrorType)type cache:(YYCache*)cache{
    id cacheData = [cache objectForKey:self.requestMark];
    if (cacheData != nil) {
        self.errorType = type;
        if ([self.delegate respondsToSelector:@selector(managerCallAPIDidSuccess:)]) {
            self.responseObject =[NSJSONSerialization JSONObjectWithData:cacheData options:NSJSONReadingMutableLeaves error:nil];
            [self.delegate managerCallAPIDidSuccess:self];
            self.task = nil;
        }
        [[NSUserDefaults standardUserDefaults] setValue:self.requestMark forKey:@"lastR"];
        [[NSUserDefaults standardUserDefaults] setValue:[self tt_loadNewTime:@"yyyyMMddHHmmss"] forKey:@"lastT"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}
/*
 功能：存本地
 备注：无
 */

- (void)initCache:(id)responseObject url:(NSString *)url parameters:(id)params{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;// 关闭网络指示器
    });
    /// 开启异步线程
    dispatch_queue_t queue= dispatch_queue_create("Cache.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSData *data= [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSData *requestData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
        [PPNetworkCache setHttpCache:requestData URL:url parameters:params];
    });
}

- (void)configrequestMark:(NSString *)requestMark {
    
}
#pragma mark -- 处理json格式的字符串中的换行符、回车符
- (NSString *)deleteSpecialCodeWithStr:(NSString *)str {
    NSString *string = [str stringByReplacingOccurrencesOfString:@"\\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\\t" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@")" withString:@""];
    return string;
}


/**
 当前时间转换成字符串

 @param formate 转换的格式 例如@ "yyyyMMddHHmmss"

 @return 返回转换后的时间
 */
- (NSString*)tt_loadNewTime:(NSString *)formate{
    // 获取当前时间，日期
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];;
    return dateString;
}




- (void)dealloc {
    [self cancelAllRequest];
}


- (void)cancelAllRequest {
    if (self.task) {
        [self.task cancel];
        self.task = nil;
    }
}


@end
