//
//  UIViewController+MM_configNet.h
//  marketmanager
//
//  Created by 王猛 on 2021/9/25.
//

#import <UIKit/UIKit.h>
#import "UCMHttpRequest.h"
#import "UCMHttpRequestBaseVM.h"


NS_ASSUME_NONNULL_BEGIN
///VM 调用Requset
@interface UIViewController (MM_configNet) <UCM_baseVMprotocol>
/// 设置VM
/// @param vmClass UCMHttpRequestBaseVM （可以分多次绑定多个VM元素）
- (void)ucm_setupvm:(Class)vmClass;

#pragma mark - **************** request 网络请求 ****************

///  单个网络请求
/// 默认 POST 和 UCMHttpRequest
/// @param networkname 请求名
/// @param params 参数
/// @param vmClass 请求器
-(void)ucm_confignetworkforname:(NSString *)networkname
                         params:(NSDictionary *)params
                        vmClass:(Class)vmClass;
/// 单个网络请求
/// @param networkname 请求名
/// @param params 参数
/// @requestType 请求类型
/// @param netRequsetClass  UCMHttpRequest请求器
/// vmClass 请求器
- (void)ucm_confignetworkforname:(NSString *)networkname
                          params:(NSDictionary *)params
                     requestType:(YTKRequestMethod)requestType
                     netRequsetClass:(Class)netRequsetClass
                         vmClass:(Class)vmClass;


#pragma mark - **************** protocal respone网络结果拦截 ****************
/// 拦截通用数据回调
/// @param allData 所有的数据信息
/// @param Data 数组
/// @param is_showmsg 是否显示
/// @param is_list 是否数组
/// @param SucessORfail 成功
/// @param has_more 加载更多
/// @param mark 数据请求
/// @param extend_info VM 中的附加传递信息
- (void)ucm_vcResponseAllData:(UCMHttpRequestResponse *)allData
                         Data:(NSMutableArray *)Data
                   is_showmsg:(BOOL)is_showmsg
                      is_list:(BOOL)is_list
                 SucessORfail:(BOOL)SucessORfail
                     has_more:(BOOL)has_more
                         mark:(NSString *)mark
                  extend_info:(NSDictionary *)extend_info;

///当数据为list列表的时候
-(void)ucm_vcReopnseSucessList:(NSMutableArray *)dataAry
                      has_more:(BOOL)has_more
                          mark:(NSString *)mark;
///无数组直接解析

-(void)ucm_currencyloadresponse:(UCMHttpRequestResponse *)response
                      isshowmsg:(BOOL)isshowmsg
                        success:(BOOL)success
                           mark:(NSString *)mark
                    extend_info:(NSDictionary *)extend_info;


/// 网路请求失败的回调
/// @param response 返回数据
/// @param mark 标示
-(void)ucm_vcResponstFailInfo:(UCMHttpRequestResponse *)response mark:(NSString *)mark;

#pragma mark - **************** TooL ****************
///强制取消当前页面的所有网络请求
-(void)xxx_AllRequsetStop;


@end

NS_ASSUME_NONNULL_END
