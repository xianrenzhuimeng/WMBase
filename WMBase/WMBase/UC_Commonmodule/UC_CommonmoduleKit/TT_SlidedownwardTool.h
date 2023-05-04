//
//  TT_SlidedownwardTool.h
//   
//
//  Created by 樊腾 on 2020/4/9.
//  Copyright © 2020 绑耀. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface TT_SlidedownwardTool : NSObject
/// 缩放
@property (nonatomic , assign) CGFloat config_scale;
/// 截图img
@property (nonatomic , strong) UIImage *screenshot_img;

- (void)tengteng_configSlidedownwardwithController:(UIViewController *)CC scrollv:(UIScrollView *)scrollv;

@end

NS_ASSUME_NONNULL_END
