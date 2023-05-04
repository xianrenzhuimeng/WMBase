//
//  PZ_BaseVM.h
//  破竹
//
//  Created by linlin dang on 2018/9/5.
//  Copyright © 2018年 米宅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTT_APIBaseManager.h"
@interface TT_BaseVM : NSObject <FTT_APIManagerApiCallBackDelegate,FTT_APIManagerParamSourceDelegate>

@property (nonatomic , strong) NSMutableDictionary *DIC;

@property (nonatomic , strong) FTT_APIBaseManager *API_manager;

@property (nonatomic , copy) void(^New_Close)(id allData , NSMutableArray *Data , BOOL SucessORfail , BOOL has_more, NSString *mark);
@property (nonatomic , copy) void(^login_Close)(NSInteger type);
+ (instancetype)setupVMclass:(Class)VMclass;

/// 测试数据回调
- (void)testloadDataResuletBlock:(void(^)(NSMutableArray *Data , BOOL SucessORfail , BOOL has_more))resulteBlock;

/// 可同时进行多个网络请求
- (void)loadDataNetWorkWithAnswersParams:(NSMutableDictionary *)Params
                             networkName:(NSString *)networkName
                            networkClass:(Class)networkClass
                            ResuletBlcok:(void(^)(id allData ,NSMutableArray *Data , BOOL SucessORfail , BOOL has_more , NSString *mark))resulteBlock;


- (void)loadDataNetWorkWithAnswersParams:(NSMutableDictionary *)Params
                             networkName:(NSString *)networkName
                             networkMark:(NSString *)networkMark
                            networkClass:(Class)networkClass
                            ResuletBlcok:(void(^)(id allData ,NSMutableArray *Data , BOOL SucessORfail , BOOL has_more , NSString *mark))resulteBlock;


/// 数据转换
- (void)dataConversion:(FTT_APIBaseManager *)Manager;


- (void)chongxindenglu;
- (void)chongbangding;

- (NSMutableArray *)configtextData;

- (void)Generalmethod:(FTT_APIBaseManager *)Manager;

- (void)configAllData:(id)AllData Data:(NSMutableArray *)Data success:(BOOL)success Mark:(NSString *)Mark;

- (void)tengteng_confignromalformethod:(FTT_APIBaseManager *)Manager ;

- (void)ElasticGeneralmethod:(FTT_APIBaseManager *)Manager;

- (void)cancerlAllnet;
@end
