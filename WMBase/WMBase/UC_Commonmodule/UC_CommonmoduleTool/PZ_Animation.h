//
//  PZ_Animation.h
//  破竹
//
//  Created by 米宅 on 2017/11/16.
//  Copyright © 2017年 米宅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PZ_Animation : NSObject

/** 缩放动画 */
+ (void)addScaleAnimationOnView:(UIView *)animationView repeatCount:(float)repeatCount duration:(float)duration;
/** 旋转动画 */
+ (void)addRotateAnimationOnView:(UIView *)animationView;
/**
 作用： 绕方向轴转
 备注： duration 转一圈的时间 rotation x,y,z轴 小写
 */
+ (void)addcircularAnimationView:(CALayer *)layer duration:(CGFloat)duration rotation:(NSString *)rotation;
/** 暂停动画 */
+ (void)pauseAnimation:(CALayer*)layer;
/** 恢复动画 */
+ (void)resumeAnimation:(CALayer *)layer;

+ (void)configCATransition:(CALayer *)layer;

+ (void)configPOPCATransition:(CALayer *)layer;
@end
