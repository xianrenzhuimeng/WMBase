//
//  UIViewController+MM_configNet.m
//  marketmanager
//
//  Created by 王猛 on 2021/9/25.
//

#import "UIViewController+MM_configNet.h"
#import "UIViewController+TT_configV.h"
#import "TT_GeneralProfile.h"

@interface UIViewController ()
@property (nonatomic ,strong) NSMutableArray *classVMAry; ///记录当前类绑定的VM 数，放在外边让调用

@property (nonatomic, strong) NSMutableArray *requestAry; ///记录执行了多少次的网络请求
@end

@implementation UIViewController (MM_configNet)


#pragma mark - **************** 公开方法 ****************
/// 设置VM
/// @param vmClass UCMHttpRequestBaseVM
- (void)ucm_setupvm:(Class)vmClass{ //
    if (!self.classVMAry) {
        self.classVMAry = [[NSMutableArray alloc]init];
    }
    UCMHttpRequestBaseVM *VM = [UCMHttpRequestBaseVM setupVMclass:vmClass];
    VM.delegate = self;
    [self.classVMAry addObject:VM];
}
/// 创建Request 对象
/// @param networkname 请求名
/// @param params 参数
/// @param vmClass 请求器
-(void)ucm_confignetworkforname:(NSString *)networkname
                         params:(NSDictionary *)params
                        vmClass:(Class)vmClass{
    [self ucm_confignetworkforname:networkname params:params requestType:YTKRequestMethodPOST netRequsetClass:[UCMHttpRequest class] vmClass:vmClass];
}
- (void)ucm_confignetworkforname:(NSString *)networkname
                          params:(NSDictionary *)params
                     requestType:(YTKRequestMethod)requestType
                 netRequsetClass:(Class)netRequsetClass
                         vmClass:(Class)vmClass{
    UCMHttpRequest *api = [UCMHttpRequest setuprequesetclass:netRequsetClass];
    api.ucm_argument = params;
    api.ucm_requesetmark = networkname;
    api.ucm_requestType = requestType;
    [self tool_confignetworksingleapi:api classVM:vmClass];
    if (TT_ISNullArray(self.requestAry)) {
        self.requestAry = [[NSMutableArray alloc]init];
    }
    [self.requestAry addObject:api];
}
#pragma mark - **************** tool 方法 ****************
/// tool——配置单个可以带带缓存机制的网络请求
- (void)tool_confignetworksingleapi:(UCMHttpRequest *)api classVM:(Class)classStr{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (self.classVMAry.count>0) {
            for (UCMHttpRequestBaseVM *tempVm in self.classVMAry) {
                if ([tempVm isKindOfClass:classStr]) {
                    [tempVm ucm_requestApi:api];
                    return;
                }
            }
        }
    });
}

#pragma mark - **************** BatchReq 网络请求 ****************

-(void )ucm_creatBatchRequst:(NSArray *)networknameAry  params:(NSArray *)paramsAry  vmClass:vmClass{
    NSMutableArray *reqAry = [[NSMutableArray alloc]init];
    for (int i = 0; i<networknameAry.count; i++) {
        UCMHttpRequest *api = [UCMHttpRequest setuprequesetclass:[UCMHttpRequest class]];
        api.ucm_requesetmark = networknameAry[i];
        api.ucm_argument = paramsAry[i];
        api.ucm_requestType = YTKRequestMethodPOST;
      }
    [self tool_configBatchRequestnetworks:reqAry.copy classVM:vmClass];
}


/// 多个网路请求
/// @param requestarr 请求体集合
/// @param classStr VM
- (void)tool_configBatchRequestnetworks:(NSArray *)requestarr classVM:(Class)classStr{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (self.classVMAry.count>0) {
            for (UCMHttpRequestBaseVM *tempVm in self.classVMAry) {
                if ([tempVm isKindOfClass:classStr]) {
                    [tempVm ucm_batchRequestApi:requestarr];
                    return;
                }
            }
        }
    });
}



#pragma mark - **************** UCM_baseVMprotocol UCM_baseVM 调用 VM protocol ****************
-(void)pro_respnsParseData:(UCMHttpRequestResponse *)response
                   arrData:(NSMutableArray *)arrData
                   showMsg:(BOOL)is_showmsg
                      list:(BOOL)is_list
                    sucess:(BOOL)sucessOrFail
                  has_more:(BOOL)has_more
                      mark:(NSString *)mark
               extend_info:(NSDictionary *)extend_info {
    [self ucm_vcResponseAllData:response Data:arrData is_showmsg:is_showmsg is_list:is_list SucessORfail:sucessOrFail has_more:has_more mark:mark extend_info:extend_info];
}
///batch 网络请求的代理
-(void)pro_batchResponAry:(NSArray <UCMHttpRequestResponse *>*)responseAry success:(BOOL)success modelData:(NSMutableArray *_Nullable)modelAry{
    [self ucm_batchResponseAry:responseAry success:success modelData:modelAry];
}




#pragma mark - **************** 共开方法----拦截的通用数据类 ****************

- (void)ucm_vcResponseAllData:(UCMHttpRequestResponse *)response Data:(NSMutableArray *)Data is_showmsg:(BOOL)is_showmsg is_list:(BOOL)is_list SucessORfail:(BOOL)SucessORfail has_more:(BOOL)has_more mark:(NSString *)mark extend_info:(NSDictionary *)extend_info{
    dispatch_async(dispatch_get_main_queue(), ^{
        ///判断网络请求成功还是失败
        if (SucessORfail) {
            if (is_list) {
                [self ucm_vcReopnseSucessList:Data has_more:has_more mark:mark];
            }else{
                [self ucm_currencyloadresponse:response isshowmsg:is_showmsg success:SucessORfail mark:mark extend_info:extend_info];
            }
        }else{ //网络请求失败
            [self ucm_vcResponstFailInfo:response mark:mark];
        }

    });
}


#pragma mark - **************** 拦截 ****************

-(void)ucm_batchResponseAry:(NSArray <UCMHttpRequestResponse *>*)responseAry success:(BOOL)success modelData:(NSMutableArray *_Nullable)modelAry{
    
}
///当数据为list数组的时候
-(void)ucm_vcReopnseSucessList:(NSMutableArray *)dataAry
                      has_more:(BOOL)has_more
                          mark:(NSString *)mark{
    [self configTabelData:dataAry has_more:has_more];
}
///无数组直接解析
- (void)ucm_currencyloadresponse:(UCMHttpRequestResponse *)response
                       isshowmsg:(BOOL)isshowmsg
                         success:(BOOL)success
                            mark:(NSString *)mark
                     extend_info:(NSDictionary *)extend_info {
}
///网络请求失败回调到VC页面
-(void)ucm_vcResponstFailInfo:(UCMHttpRequestResponse *)response mark:(NSString *)mark{
}

-(void)xxx_AllRequsetStop{
    if (self.requestAry.count>0) {
        for (UCMHttpRequest * req in self.requestAry) {
            [req stop];
        }
        [self.requestAry removeAllObjects];
    }
}






//----------------------  getter setter ------------------------------


- (NSMutableArray *)classVMAry{    //翻译：关联对象，通过本类，获取了一个属性getter方法的sel指针
    return objc_getAssociatedObject(self, @selector(classVMAry));
}

- (void)setClassVMAry:(NSMutableArray *)classVMAry{
    //翻译：关联对象，通过本类，给一个变量的getter方法的sel指针，输入了一个值，并指定内存策略
    objc_setAssociatedObject(self, @selector(classVMAry), classVMAry, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSMutableArray *)requestAry{
    return objc_getAssociatedObject(self, @selector(requestAry));
}
-(void)setRequestAry:(NSMutableArray *)requestAry{
    objc_setAssociatedObject(self, @selector(requestAry), requestAry, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end

