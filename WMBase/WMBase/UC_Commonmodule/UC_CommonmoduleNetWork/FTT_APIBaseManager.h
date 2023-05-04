//
//  FTT_APIBaseManager.h
//  95128
//
//  Created by 樊腾 on 17/6/9.
//  Copyright © 2017年 FTT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FTT_NetWorkkingManager.h"
#import "UC_CommonmoduleNetWorkTool.h"
#import "PPNetworkCache.h"
@class FTT_APIBaseManager;

@protocol FTT_APIManagerParamSourceDelegate <NSObject>

@required

/**
 获取调用API所需的数据
 */
- (NSDictionary *)paramsForApi:(FTT_APIBaseManager *)Manager;

@end

/*
 成功和失败的回调
 */
@protocol FTT_APIManagerApiCallBackDelegate <NSObject>

@required

- (void)managerCallAPIDidSuccess:(FTT_APIBaseManager *)Manager;
- (void)managerCallAPIDidFailed:(FTT_APIBaseManager *)Manager;

@end

@interface FTT_APIBaseManager : NSObject

/****************************************入参*********************************************************/
/**
 *  网络请求requestUrl (可拼接参数，但不建议)
 *  不建议拼接请求参数，请求参数建议通过 FTT_APIManagerParamSourceDelegate 赋值
 *  如果拼接了参数，同样的参数在FTT_APIManagerParamSourceDelegate也赋值了，则会取FTT_APIManagerParamSourceDelegate里的值
 */
@property (nonatomic , strong) NSString *requestUrl;

/**
 网络请求类型
 */
@property (nonatomic , assign) FTT_APIManagerRequestType requestType;

/**
 数据回调
 */
@property (nonatomic , weak) id<FTT_APIManagerParamSourceDelegate> DataSource;

/**
 请求结果回调
 */
@property (nonatomic , weak) id<FTT_APIManagerApiCallBackDelegate> delegate;

/**
 同一个VC中, 区分相同类的请求manager
 */
@property (nonatomic , strong) NSString *requestMark;

/**
 失败的原因描述
 */
@property (nonatomic , copy, readonly) NSString *errorMesage;

@property (nonatomic , assign) BOOL Is_Cache;

@property (nonatomic , readonly) FTT_APIManagerErrorType errorType;

@property (nonatomic, strong) NSDictionary *params;;

/**
 后台返回数据
 */
@property (nonatomic , strong) id responseObject;

@property (nonatomic , assign) BOOL Is_requestHaveCahce;
/// 是否更新数据
@property (nonatomic , assign) BOOL is_updatarequesecache;

/// 配置请求信息
- (void)configrequestMark:(NSString *)requestMark;

/**
 使用loadData这个方法来请求数据,这个方法会通过Datasource 来获取参数,这使得参数的生成逻辑位于controller中的固定位置
 */
- (void)loadData;

/**
 取消网络请求
 */
- (void)cancelAllRequest;
@end
