//
//  XXX_ToolWKData.m
//  XXX
//
//  Created by 王猛 on 2019/9/18.
//  Copyright © 2019 绑耀. All rights reserved.
//

#import "XXX_ToolWKData.h"

@implementation XXX_ToolWKData
+ (instancetype)share_XXX_ToolWKData{
    static XXX_ToolWKData *MW = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        MW = [[XXX_ToolWKData alloc]init];
    });
    return MW;
}



@end
