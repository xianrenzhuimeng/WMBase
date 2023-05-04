//
//  TT_BaseC.m
//  破竹
//
//  Created by linlin dang on 2019/3/19.
//  Copyright © 2019 米宅. All rights reserved.
//

#import "TT_BaseC.h"

#import "TT_GeneralProfile.h"


@interface TT_BaseC ()


@end

@implementation TT_BaseC
@synthesize title = _title;

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self wr_setNavBarBackgroundAlpha:0];
    self.view.backgroundColor = [UIColor whiteColor];
    [self tt_layoutNavigation];
    [self tt_addSubviews];
    [self tt_bindViewModel];
    [self tt_changeDefauleConfiguration];
    [self configureViewFromLocalisation];
}


//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    [self.navigationController setNavigationBarHidden:true];
//
//}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 生命周期

#pragma mark 回调协议

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
  
}

#pragma mark 界面跳转

- (void)JumpController:(UIViewController *)Contrl {
    [self.navigationController pushViewController:Contrl animated:YES];
}


#pragma mark 触发方法
-(void)configureViewFromLocalisation
{
    
}

#pragma mark 公开方法

/// 绑定 V（VC）与VM
- (void)tt_bindViewModel {
}

/// 添加控件
- (void)tt_addSubviews {
    
}

/// 初次获取数据
- (void)tt_getNewDate {
    
}

/// 回调
- (void)tt_allClose {
    
}

- (void)tt_addNoti {
    
}

- (void)tt_addnavgarItme {
    
}

- (void)tt_changeDefauleConfiguration {
    
}



- (void)tt_deletNoti {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

/// 设置navation
- (void)tt_layoutNavigation {
    if (@available(iOS 15.0, *)) {
        [UITableView appearance].sectionHeaderTopPadding = 0;
    }
    [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
}

- (void)tengteng_confignavBarBar {
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
    [self.view addSubview:self.customNavBar];
    if (self.navigationController.viewControllers.count > 1) {
        self.customNavBar.leftButton.hidden = NO;
        [self.customNavBar.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    }
}


-(void)tengteng_addCartBtn{
    self.customNavBar.rightButton.hidden = YES;
    NSInteger top = IPHONEX ? 44 : 20;
    NSInteger margin = 10;
    NSInteger buttonHeight = 44;
    NSInteger buttonWidth = 44;
//    [XXX_Tabber shareInstance].xxx_barCartBtn.frame = CGRectMake(kScreenWidth - buttonWidth - margin, top, buttonWidth, buttonHeight);
//    [self.customNavBar addSubview:[XXX_Tabber shareInstance].xxx_barCartBtn];
}

-(void)setTitle:(NSString *)title {
    _title = title;
    self.customNavBar.hidden = NO;
    self.customNavBar.title = title;
}


// 右滑返回事件
- (void)tengteng_configdidMoveToParentV {
    
}


/// 配置键盘消失
- (void)tengteng_configkeyboardendEditing {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}




/** 返回按钮触发事件 */
- (void)BackBarButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didMoveToParentViewController:(UIViewController*)parent{
    [super didMoveToParentViewController:parent];
    if(!parent){
        [self tengteng_configdidMoveToParentV];
        NSLog(@"离开页面");
    }
}

#pragma mark 存取方法


- (WRCustomNavigationBar *)customNavBar {
    if (!_customNavBar) {
        _customNavBar = [WRCustomNavigationBar CustomNavigationBar];
        [_customNavBar wr_setBottomLineHidden:YES];
        _customNavBar.titleLabelFont = [UIFont fontWithName:Rob_Medium size:20];
        _customNavBar.titleLabelColor = [UIColor blackColor];
        _customNavBar.barBackgroundColor = [UIColor colorWithHexString:@"#FFF8F9"];
    }
    return _customNavBar;
}





@end
