//
//  PPNetworkCache.m
//  PPNetworkHelper
//
//  Created by AndyPang on 16/8/12.
//  Copyright © 2016年 AndyPang. All rights reserved.
//

#import "PPNetworkCache.h"
#import "KWLoginedManager.h"



static NSString *const kPPNetworkResponseCache = @"kPPNetworkResponseCache";

@implementation PPNetworkCache


+ (void)initialize {
    _dataCache = [YYCache cacheWithName:kPPNetworkResponseCache];
}

+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters {
    NSString *cacheKey = [self cacheKeyWithURL:[NSString stringWithFormat:@"%@%@%@",URL,[KWLoginedManager.shareInstance getCurrentLoginedUser].user_id
                                                ,[UC_CommonmoduleNetWorkTool getAppVersion]] parameters:parameters];
    //异步缓存,不会阻塞主线程
    [_dataCache removeObjectForKey:cacheKey];
    [_dataCache setObject:httpData forKey:cacheKey withBlock:nil];
}


+ (void)removeObjectForURL:(NSString *)URL parameters:(NSDictionary *)parameters  {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    [_dataCache removeObjectForKey:cacheKey];
}
+ (id)httpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    NSString *cacheKey =  [self cacheKeyWithURL:[NSString stringWithFormat:@"%@%@%@",URL,[UC_CommonmoduleNetWorkTool getUser_id]
                                                 ,[UC_CommonmoduleNetWorkTool getAppVersion]] parameters:parameters];
    id data = [_dataCache objectForKey:cacheKey];
    if ([data isKindOfClass:[NSData class]]) {
        data = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    return data;
}

+ (NSInteger)getAllHttpCacheSize {
    return [_dataCache.diskCache totalCost];
}

+ (void)removeAllHttpCache {
    [_dataCache.diskCache removeAllObjects];
}

+ (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    if(!parameters || parameters.count == 0){return URL;};
    // 将参数字典转换成字符串
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];    
    return [NSString stringWithFormat:@"%@%@",URL,paraString];
}


@end

