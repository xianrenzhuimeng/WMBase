//
//  TT_ViewAppearOrdisappear.h
//  破竹
//
//  Created by linlin dang on 2019/3/19.
//  Copyright © 2019 米宅. All rights reserved.
//

#import "TT_BaseV.h"

NS_ASSUME_NONNULL_BEGIN

@interface TT_ViewAppearOrdisappear : TT_BaseV
/// 添加自定义控件
- (void)configCustomcontrols:(UIView *)CustomV;
- (void)show;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
