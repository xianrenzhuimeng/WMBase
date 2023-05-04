//
//  UC_Generalconfig.h
//  AFNetworking
//
//  Created by 樊腾 on 2020/9/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UC_Generalconfig : NSObject
/// 商户ID
@property (nonatomic , strong) NSString *biz_id;
/// 测试服
@property (nonatomic , strong) NSString *test_server;
/// 发布服
@property (nonatomic , strong) NSString *release_server;
/// 正式服
@property (nonatomic , strong) NSString *formal_sercer;
/// 开发环境
@property (nonatomic , assign) NSInteger environment;

+ (instancetype)share_generalconfig;
@end

NS_ASSUME_NONNULL_END
