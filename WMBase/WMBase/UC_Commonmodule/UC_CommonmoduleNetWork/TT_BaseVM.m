//
//  PZ_BaseVM.m
//  破竹
//
//  Created by linlin dang on 2018/9/5.
//  Copyright © 2018年 米宅. All rights reserved.
//

#import "TT_BaseVM.h"
@interface TT_BaseVM ()

@property (nonatomic , strong) NSMutableArray *NetworkArray;

@property (nonatomic , strong) NSMutableArray *NetworkClassArray;

@end

@implementation TT_BaseVM


+ (instancetype)setupVMclass:(Class)VMclass {
    return [[VMclass alloc]init];
}


- (void)testloadDataResuletBlock:(void (^)(NSMutableArray *, BOOL, BOOL))resulteBlock {
    resulteBlock([self configtextData],YES,YES);
}

- (NSMutableArray *)configtextData {
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i < 10 ; i++) {
        [arr addObject:@"TT"];
    }
    return arr;
}

- (void)loadDataNetWorkWithAnswersParams:(NSMutableDictionary *)Params
                             networkName:(NSString *)networkName
                            networkClass:(Class)networkClass
                            ResuletBlcok:(void(^)(id allData ,NSMutableArray *Data , BOOL SucessORfail , BOOL has_more , NSString *mark))resulteBlock {
    [self loadDataNetWorkWithAnswersParams:Params
                               networkName:networkName
                               networkMark:networkName
                              networkClass:networkClass
                              ResuletBlcok:resulteBlock];
}



- (void)loadDataNetWorkWithAnswersParams:(NSMutableDictionary *)Params
                             networkName:(NSString *)networkName
                             networkMark:(NSString *)networkMark
                            networkClass:(Class)networkClass
                            ResuletBlcok:(void(^)(id allData ,NSMutableArray *Data , BOOL SucessORfail , BOOL has_more , NSString *mark))resulteBlock {
    
    self.DIC = Params;
    self.New_Close = resulteBlock;
    FTT_APIBaseManager *API = [[networkClass alloc]init];;
    [API configrequestMark:networkMark];
    API.DataSource = self;
    API.delegate   = self;
    API.requestMark = networkMark;
    [API loadData];
}



+ (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    if(!parameters || parameters.count == 0){return URL;};
    // 将参数字典转换成字符串
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"%@%@",URL,paraString];
}


- (void)configNetwork:(NSString *)networkName {
    [self.API_manager configrequestMark:networkName];
     self.API_manager.DataSource = self;
     self.API_manager.delegate   = self;
    [self.API_manager loadData];
}

- (void)managerCallAPIDidFailed:(FTT_APIBaseManager *)Manager {
    if (self.New_Close) {
        self.New_Close(Manager, nil, NO, NO, Manager.requestMark);
    }
}
- (void)managerCallAPIDidSuccess:(FTT_APIBaseManager *)Manager {
    if ([Manager.responseObject[@"code"] integerValue] == 0) {
        [self dataConversion:Manager];
    }else if ([Manager.responseObject[@"code"] integerValue] == 403) {
        [self chongxindenglu];
    }else if ([Manager.responseObject[@"code"] integerValue] == 412)
    {
        [self chongbangding];
    }
    else {
        if (self.New_Close) {
            self.New_Close(Manager, nil, NO, NO, Manager.requestMark);;
        }
    }
}
-(void)alertViewWithTitle
{
    
}

- (void)chongbangding {
    
}
- (NSDictionary *)paramsForApi:(FTT_APIBaseManager *)Manager {
    return self.DIC;
}

- (void)dataConversion:(FTT_APIBaseManager *)Manager {
    
}

- (void)configAllData:(id)AllData Data:(NSMutableArray *)Data success:(BOOL)success Mark:(NSString *)Mark {
    BOOL hasmore = YES;
    if (Data) {
        if (Data.count == 0 || Data.count < 10) {
            hasmore = NO;
        }
    }else {
        hasmore = NO;
    }
   
    if (self.New_Close) {
        self.New_Close(AllData, Data, success, hasmore, Mark);
    }
}

- (void)ElasticGeneralmethod:(FTT_APIBaseManager *)Manager {
    if (self.New_Close) {
        self.New_Close(Manager.responseObject, nil, YES, NO, Manager.requestMark);
    }
}

- (void)tengteng_confignromalformethod:(FTT_APIBaseManager *)Manager {
    
}
- (void)Generalmethod:(FTT_APIBaseManager *)Manager {
    if (self.New_Close) {
        self.New_Close(Manager, nil, YES, NO, Manager.requestMark);
    }
}

- (void)chongxindenglu {
    
}


- (void)cancerlAllnet {
    for (FTT_APIBaseManager *api in self.NetworkArray ) {
        [api cancelAllRequest];
    }
}


- (NSMutableDictionary *)DIC {
    if (!_DIC) {
        _DIC = [NSMutableDictionary new];
    }
    return _DIC;
}

- (NSMutableArray *)NetworkArray {
    if (!_NetworkArray) {
        _NetworkArray = [NSMutableArray new];
    }
    return _NetworkArray;
}

- (NSMutableArray *)NetworkClassArray {
    if (!_NetworkClassArray) {
        _NetworkClassArray = [NSMutableArray new];
    }
    return _NetworkClassArray;
}
@end
