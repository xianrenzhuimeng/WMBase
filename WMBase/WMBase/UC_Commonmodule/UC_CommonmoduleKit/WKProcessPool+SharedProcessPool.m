//
//  WKProcessPool+SharedProcessPool.m
//  XXX
//
//  Created by 王猛 on 2019/9/19.
//  Copyright © 2019 绑耀. All rights reserved.
//

#import "WKProcessPool+SharedProcessPool.h"

@implementation WKProcessPool (SharedProcessPool)
+(WKProcessPool*)sharedProcessPool {
    static WKProcessPool *SharedProcessPool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SharedProcessPool = [[WKProcessPool alloc] init];
    });
    return SharedProcessPool;
}
@end
