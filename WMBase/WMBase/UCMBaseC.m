//
//  UCMBaseC.m
//  WMBase
//
//  Created by 王猛 on 2023/5/4.
//

#import "UCMBaseC.h"

@interface UCMBaseC ()

@end

@implementation UCMBaseC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self ucm_bindvmmodel]; //绑定网络请求
    [self ucm_changedefault];
}
#pragma mark -- 公开方法
-(void)ucm_bindvmmodel{
    
}
-(void)ucm_changedefault{
    
}
#pragma mark - **************** 调用 ****************
- (void)tool_deletenoti {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
