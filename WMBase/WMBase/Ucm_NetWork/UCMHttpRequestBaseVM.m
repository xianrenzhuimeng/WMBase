//
//  UCMHttpRequestBaseVM.m
//  UCMHttpRequest
//
//  Created by 王猛 on 2021/9/25.
//

#import "UCMHttpRequestBaseVM.h"
#import "UCMHttpRequestNetworkManager.h"

@implementation UCMHttpRequestBaseVM

+ (instancetype)setupVMclass:(Class)VMclass {
    return [[VMclass alloc]init];
}


- (void)ucm_requestApi:(UCMHttpRequest *)api {
    api.ignoreCache = YES;
    if ([api loadCacheWithError:nil]) {
        UCMHttpRequestResponse *res = [self ucm_configreponse:api cache:YES];
        res.ucm_updatetype = api.ucm_updatetype;
        if (res.ucm_success) {
            [self ucm_configresponseInterceptor:res callback:nil];
        }
    }else {
        api.ucm_updatetype = 1;
    }
    [self ucm_requestApi:api callback:^(UCMHttpRequestResponse * _Nonnull response) {
    }];
}


#pragma mark - **************** 网络请求 ****************

- (void)ucm_requestApi:(UCMHttpRequest *)api callback:(void(^)(UCMHttpRequestResponse *response))callback {
    __weak __typeof(self)weakSelf = self;
    __block NSInteger updatessss = api.ucm_updatetype;

    NSLog(@"====-=-=-==-=-=-=-=--%ld",(long)updatessss);
    [api ucm_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        UCMHttpRequestResponse *response = [UCMHttpRequestResponse ucm_responseWithRequest:request];
        id dic = response.ucm_responseObject;
        response.ucm_updatetype = api.ucm_updatetype;
        NSLog(@"%@ ------ %@",request,dic);
        if (updatessss == 0) { //只更新本地数据，不回调到应用内
            return;
        }
        
        if (response.ucm_serverResponseStatusCode == 200){
            response.ucm_success = YES;
            [weakSelf ucm_configresponseInterceptor:response callback:callback];
            return;
        }else{
            response.ucm_success = NO;
            [weakSelf ucm_configresponseInterceptor:response callback:callback];
        }

    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"%@ --",request);
        UCMHttpRequestResponse *response = [UCMHttpRequestResponse ucm_responseWithRequest:request];
        if (![[UCMHttpRequestNetworkManager ucm_netManager] ucm_getNetworkStatus] ) {
            response.nonetwork = 1;
        }else {
            response.nonetwork = 0;
        }
        response.ucm_success = NO;
        [weakSelf ucm_configresponseInterceptor:response callback:callback];
    }];
}

- (void)ucm_configresponseInterceptor:(UCMHttpRequestResponse *)response callback:(nullable void(^)(UCMHttpRequestResponse *response))callback{
    // 回调至最上面，可以直接调用block
    if (callback) {
        callback(response);
    }
    // 处理结果，回调给控制器的分类
    if (response.ucm_success) {
        [self ucm_confignormalnetworksuccesswithresponse:response];
    }else {
        [self ucm_confignormalnetworkfailwithresponse:response];
    }
}


- (void)ucm_confignormalnetworksuccesswithresponse:(UCMHttpRequestResponse *)response {
    [self ucm_configNewsRepose:response data:[NSMutableArray array] is_showmsg:NO is_list:NO success:YES has_more:NO mark:response.ucm_responseMark extend_info:@{}];
}

- (void)ucm_confignormalnetworkfailwithresponse:(UCMHttpRequestResponse *)response {
    NSInteger type = 1;
    if (response.nonetwork == 1) {
        type = 3;
    }
    [self ucm_configNewsRepose:response data:[NSMutableArray array] is_showmsg:NO is_list:NO success:NO has_more:NO mark:response.ucm_responseMark extend_info:@{@"netfail":@(type)}];
}


///调用会传的方法
- (void)ucm_configNewsRepose:(UCMHttpRequestResponse *)response
                  is_showmsg:(BOOL)is_showmsg
                     success:(BOOL)success
                        mark:(NSString *)mark
                 extend_info:(NSDictionary *)extend_info{
    [self ucm_configNewsRepose:response data:[NSMutableArray new] is_showmsg:is_showmsg is_list:NO success:success has_more:NO mark:mark extend_info:extend_info];
}


- (void)ucm_configNewsRepose:(UCMHttpRequestResponse *)response
                        data:(NSMutableArray *_Nullable)data
                     success:(BOOL)success
                    has_more:(BOOL)has_more
                        mark:(NSString *)mark
                 extend_info:(NSDictionary *)extend_info{
    if (data.count == 0 ) {
        has_more = NO;
    }
    [self ucm_configNewsRepose:response data:data is_showmsg:NO is_list:YES success:success has_more:has_more mark:mark extend_info:extend_info];
}

#pragma mark **************** 传输给VC 监听的方法 ****************

- (void)ucm_configNewsRepose:(UCMHttpRequestResponse *)response
                        data:(NSMutableArray *_Nullable)data
                  is_showmsg:(BOOL)is_showmsg
                     is_list:(BOOL)is_list
                     success:(BOOL)success
                    has_more:(BOOL)has_more
                        mark:(NSString *)mark
                 extend_info:(NSDictionary *)extend_info{
    if ([self.delegate respondsToSelector:@selector(pro_respnsParseData:arrData:showMsg:list:sucess:has_more:mark:extend_info:)]) {
        [self.delegate pro_respnsParseData:response arrData:data showMsg:is_showmsg list:is_list sucess:success has_more:has_more mark:mark extend_info:extend_info];
    }
}


#pragma mark - ****************  Requeset批处理网络请求 ****************
- (void)ucm_batchrequsetsforapis:(NSArray *)apis comple:(void(^)(BOOL success,id object))complete{
    self.complete = complete;
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:apis];
    batchRequest.delegate = self;
    [batchRequest start];
}

///  Tell the delegate that the batch request has finished successfully/
///
///  @param batchRequest The corresponding batch request.
- (void)batchRequestFinished:(YTKBatchRequest *)batchRequest {
     NSArray *requests = batchRequest.requestArray;
    if (self.complete) {
        NSMutableArray *arr = [self ucm_zhuanghuanresponse:requests];
        NSLog(@"sdadasdasdsadasdsadsadasdasdasdasdasd");
        self.complete(YES,arr);
    }
}

///  Tell the delegate that the batch request has failed.
///
///  @param batchRequest The corresponding batch request.
- (void)batchRequestFailed:(YTKBatchRequest *)batchRequest {
    NSArray *requests = batchRequest.requestArray;
    for (UCMHttpRequest *request in requests) {
        UCMHttpRequestResponse *resp =  [self ucm_configreponse:request];
        NSLog(@"%@",resp.ucm_responseObject);
    }
    if (self.complete) {
        self.complete(NO, batchRequest);
    }
}



//TODO:tool 私有方法
- (NSMutableArray *)ucm_zhuanghuanresponse:(NSArray *)arr {
    NSMutableArray *responses = [NSMutableArray new];
    for (UCMHttpRequest *request in arr) {
        UCMHttpRequestResponse *resp =  [self ucm_configreponse:request];
        [responses addObject:resp];
    }
    return responses;
}

- (UCMHttpRequestResponse *)ucm_configreponse:(UCMHttpRequest *)request {
    return [self ucm_configreponse:request cache:NO];
}

- (UCMHttpRequestResponse *)ucm_configreponse:(UCMHttpRequest *)request cache:(BOOL)cache{
    UCMHttpRequestResponse *response ;
    if (cache) {
        response = [UCMHttpRequestResponse ucm_cacheresponseWithRequest:request];
    }else {
        response =  [UCMHttpRequestResponse ucm_responseWithRequest:request];
    }
    id dic = response.ucm_responseObject;
    if (response.ucm_serverResponseStatusCode == 500) {
    }else if(response.ucm_serverResponseStatusCode == 401){
        response.ucm_success = NO;
    }else if (response.ucm_serverResponseStatusCode == 200) {
        response.ucm_success = YES;
    }else if ([dic isKindOfClass:[NSArray class]] || [dic isKindOfClass:[NSDictionary class]]) {
        response.ucm_responseObject = dic;
        response.ucm_success = YES;
    }
    return response;
}
@end
