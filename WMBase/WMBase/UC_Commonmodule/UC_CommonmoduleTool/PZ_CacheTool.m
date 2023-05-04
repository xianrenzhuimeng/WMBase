//
//  PZ_CacheTool.m
//  破竹
//
//  Created by linlin dang on 2018/5/30.
//  Copyright © 2018年 米宅. All rights reserved.
//

#import "PZ_CacheTool.h"
#import "Current_normalTool.h"
#import "PPNetworkCache.h"
#import <SDWebImage/SDWebImage.h>
#import "FTT_HudTool.h"
@implementation PZ_CacheTool


+ (YYCache *)CreateNetWorkCacheName:(NSString *)Name {
    YYCache *cache = [[YYCache alloc]initWithName:Name];
    cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
    [cache.memoryCache setCostLimit:50];
    return cache;
}

+ (instancetype)share_CacheTool {
    static PZ_CacheTool *CC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CC = [[PZ_CacheTool alloc]init];
    });
    return CC;
}



+ (id)getCache:(NSString *)CacheStr {
    return [PZ_CacheTool getCache:CacheStr CacheName:@"HttpRequestCaChe"];
}

+ (id)getCache:(NSString *)CacheStr CacheName:(NSString *)CacheName{
    YYCache *cache = [PZ_CacheTool CreateNetWorkCacheName:CacheName];
    id cacheData = [cache objectForKey:CacheStr];
    id data ;
    if (cacheData != nil) {
        data = [NSJSONSerialization JSONObjectWithData:cacheData options:NSJSONReadingMutableLeaves error:nil];
        return data;
    }else {
        return nil;
    }
}

- (void)initCache:(id)responseObject cacheKey:(NSString *)cacheKey {
    [self initCache:responseObject cache:[PZ_CacheTool CreateNetWorkCacheName:@"HttpRequestCaChe"] cacheKey:cacheKey];
}

/*
 功能：存本地
 备注：无
 */
- (void)initCache:(id)responseObject cache:(YYCache*)cache cacheKey:(NSString *)cacheKey{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;// 关闭网络指示器
    });
    NSData *data= [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
    NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //dataString = [self deleteSpecialCodeWithStr:dataString];
    NSData *requestData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [cache setObject:requestData forKey:cacheKey];
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



+ (void)loadAllCacheSize:(void(^)(NSString *str))CacheSize{
    
    __block NSInteger totalBytes = 0;
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    YYCache *cache = [YYCache cacheWithName:@"kPPNetworkResponseCache"];
    [cache.diskCache totalCostWithBlock:^(NSInteger bytes) {
        totalBytes += bytes;
        NSLog(@"HttpRequestCaChe =========%ld",bytes);
        dispatch_group_leave(group);
    }];
    
    long SDSize = [[SDImageCache sharedImageCache] totalDiskCount];
    totalBytes += SDSize;
    NSLog(@"%ld",SDSize);
    totalBytes += [PPNetworkCache getAllHttpCacheSize];
//    dispatch_group_leave(group);
    // 其他缓存计算处理....
    __weak typeof(self) weakSelf = self;
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (!weakSelf) return ;
        // 计算完成 转换单位
        double convertedValue = totalBytes;
        int multiplyFactor = 0;
        NSArray *unitArray = @[@"B",@"KB",@"MB",@"GB",@"TB",@"PB", @"EB", @"ZB", @"YB"];
        while (convertedValue > 1024) {
            convertedValue /= 1024;
            multiplyFactor++;
        }
        NSString *cacheSize = [NSString stringWithFormat:@"%4.2f %@", convertedValue, unitArray[multiplyFactor]];
        CacheSize(cacheSize);
    });

}


+ (void)clearAllCache {
    YYCache *cache = [YYCache cacheWithName:@"kPPNetworkResponseCache"];
    [Current_normalTool clearHTMLCache];
    [cache removeAllObjectsWithBlock:^{
        NSLog(@"===========清理完成============");
    }];
}

+ (void)clearAllCacheView:(UIView *)view CacheSuccess:(void (^)(void))CacheSuccess {
    [[FTT_HudTool share_FTT_HudTool] CreateMBProgressHUDModeIndeterminateForVeiw:view];
    dispatch_group_t group = dispatch_group_create();
    // 清理资讯详情缓存
    dispatch_group_enter(group);
    YYCache *cache = [YYCache cacheWithName:@"kPPNetworkResponseCache"];
    [cache removeAllObjectsWithBlock:^{
        dispatch_group_leave(group);
    }];
    // 其他缓存清理处理....
    __weak typeof(self) weakSelf = self;
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (!weakSelf) return ;
        [[FTT_HudTool share_FTT_HudTool]CreateHUD:@"清理完成" AndView:view AndMode:MBProgressHUDModeText AndImage:nil AndAfterDelay:1 AndBack:nil];
        CacheSuccess();
    });
}

@end
