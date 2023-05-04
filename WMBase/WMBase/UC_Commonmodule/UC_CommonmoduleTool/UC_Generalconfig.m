//
//  UC_Generalconfig.m
//  AFNetworking
//
//  Created by 樊腾 on 2020/9/7.
//

#import "UC_Generalconfig.h"

@implementation UC_Generalconfig
+ (instancetype)share_generalconfig {
    static UC_Generalconfig *gc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gc = [[UC_Generalconfig alloc]init];
    });
    return gc;
}
@end
