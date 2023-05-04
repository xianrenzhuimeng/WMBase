//
//  HZY_UploadFile.h
//  火之夜
//
//  Created by linlin dang on 2019/5/8.
//  Copyright © 2019 FTT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "PPNetworkCache.h"
@interface HZY_UploadFile : NSObject

+ (void)GET:(NSString *_Nullable)URL
 parameters:(id _Nullable )parameters
      cache:(void(^_Nullable)(id _Nullable responseObject))cache
compleSuccess:(void(^_Nullable)(id _Nullable responseObject))Success
       fail:(void(^_Nullable)(NSError * _Nullable error))fail;

+ (void)POST:(NSString *_Nullable)URL
  parameters:(id _Nullable )parameters
       cache:(void(^_Nonnull)(id _Nullable responseObject))cache
compleSuccess:(void(^_Nonnull)(id  _Nullable responseObject))Success
        fail:(void(^_Nonnull)(NSError * _Nullable error))fail;

+ (AFHTTPSessionManager *_Nullable)configsessionManager;

+ (void)PostJsonForURL:(NSString *_Nullable)URL
            parameters:(id _Nullable )parameters
         compleSuccess:(void(^_Nullable)(id  _Nullable responseObject))Success
                  fail:(void(^_Nullable)(NSError * _Nullable error))fail;
@end

