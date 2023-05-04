//
//  TT_BaseV.h
//  破竹
//
//  Created by linlin dang on 2019/3/19.
//  Copyright © 2019 米宅. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@protocol TT_basevDelegate <NSObject>

@optional

- (void)tengteng_configrefreshframe;

- (void)tengteng_configtaptype:(NSInteger)num data:(id)data;

@end

@interface TT_BaseV : UIView
/// 通用的触发事件
@property (nonatomic , copy) void(^ViewtapClose)(NSInteger num, id data);
/// 通用数据
@property (nonatomic , strong) id view_generalData;

@property (nonatomic , weak) id <TT_basevDelegate> basedelegate;

@property (nonatomic , assign ,readonly) CGFloat V_screnW;

@property (nonatomic , assign ,readonly) CGFloat V_screnH;


/// 绑定V 与 VM
- (void)tt_bindViewModel;
/// 添加子view 到 主view
- (void)tt_setupViews;
// 设置子控件的Frame
- (void)tt_setupViewsFrame;
/// 子控件回调
- (void)tt_configClose;
/// 设置默认事件
- (void)tt_configDefault;

- (void)tt_confignewdata:(id)data;

- (void)tt_updateSubviewFramses;
/// 回调通用方法
- (void)generaltriggermethodType:(NSInteger)type data:(id)data;

@end

NS_ASSUME_NONNULL_END
