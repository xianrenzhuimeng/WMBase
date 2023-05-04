

//
//  Msg_BackNormalFooter.m
//  XXX
//
//  Created by 王猛 on 2019/9/10.
//  Copyright © 2019 bykj. All rights reserved.
//

#import "Msg_BackNormalFooter.h"

@implementation Msg_BackNormalFooter
- (void)prepare
{
    [super prepare];
    self.stateLabel.font = [UIFont systemFontOfSize:12.0];
    self.stateLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    [self setTitle:@"加载中…" forState:MJRefreshStateRefreshing];
    [self setTitle:@"拉到我的底线了~" forState:MJRefreshStateNoMoreData];
}
@end
