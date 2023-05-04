//
//  TT_BaseC.h
//  破竹
//
//  Created by linlin dang on 2019/3/19.
//  Copyright © 2019 米宅. All rights reserved.
//

#import <UIKit/UIKit.h>
//wm_todo 判断是否绑定网络请求
#import "UIViewController+MM_configNet.h"

#import "TT_BaceProtocol.h"
#import <YYKit/YYKit.h>
#import "UC_CommonmoduleTool.h"
#import "WRNavigationBar.h"
#import "WRCustomNavigationBar.h"



NS_ASSUME_NONNULL_BEGIN

@interface TT_BaseC : UIViewController<TT_BaceProtocol>
@property (nonatomic , assign) BOOL Is_hideJuhuazhuan;

@property (nonatomic , strong) WRCustomNavigationBar *_Nonnull customNavBar;
@property (nonatomic , strong) UIButton *tt_custonBack;
@property (nonatomic ,  copy)  NSString *title;





@end

NS_ASSUME_NONNULL_END
