//
//  PZ_Animation.m
//  破竹
//
//  Created by 米宅 on 2017/11/16.
//  Copyright © 2017年 米宅. All rights reserved.
//

#import "PZ_Animation.h"

@implementation PZ_Animation
/** 缩放动画 */
+ (void)addScaleAnimationOnView:(UIView *)animationView repeatCount:(float)repeatCount duration:(float)duration{
    //需要实现的帧动画，这里根据需求自定义
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.repeatCount = repeatCount;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:nil];
}

/** 旋转动画 */
+ (void)addRotateAnimationOnView:(UIView *)animationView {
    // 针对旋转动画，需要将旋转轴向屏幕外侧平移，最大图片宽度的一半
    // 否则背景与按钮图片处于同一层次，当按钮图片旋转时，转轴就在背景图上，动画时会有一部分在背景图之下。
    // 动画结束后复位
    animationView.layer.zPosition = 65.f / 2;
    [UIView animateWithDuration:0.32 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        animationView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.70 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            animationView.layer.transform = CATransform3DMakeRotation(2 * M_PI, 0, 1, 0);
        } completion:nil];
    });
}

- (CABasicAnimation *)makeRotation{
    CATransform3D rotationTransform = CATransform3DMakeRotation((360*180.0)/(M_PI), 0, 0, -1);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration  =  0.5;
    animation.autoreverses = NO;
    animation.cumulative = YES;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = 1;
    return animation;
}

/**
 作用： 绕方向轴转
 备注： duration 转一圈的时间 rotation x,y,z轴 小写
 */
+ (void)addcircularAnimationView:(CALayer *)layer duration:(CGFloat)duration rotation:(NSString *)rotation{
    NSString *Str = [NSString stringWithFormat:@"transform.rotation.%@",rotation];
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:Str];
    basicAnimation.fromValue = @(0);
    basicAnimation.toValue = @(M_PI*2);
    basicAnimation.duration = duration;
    basicAnimation.repeatCount = LONG_MAX;
    [layer addAnimation:basicAnimation forKey:@"loadingAnimation"];
}

/** 暂停动画 */
+ (void)pauseAnimation:(CALayer*)layer {
    //1.取出当前时间，转成动画暂停的时间
    CFTimeInterval pauseTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    //2.设置动画的时间偏移量，指定时间偏移量的目的是让动画定格在该时间点的位置
    layer.timeOffset = pauseTime;
    //3.将动画的运行速度设置为0， 默认的运行速度是1.0
    layer.speed = 0;
}

/** 恢复动画 */
+ (void)resumeAnimation:(CALayer *)layer {
    //1.将动画的时间偏移量作为暂停的时间点
    CFTimeInterval pauseTime = layer.timeOffset;
    //2.计算出开始时间
    CFTimeInterval begin = CACurrentMediaTime() - pauseTime;
    [layer setTimeOffset:0];
    [layer setBeginTime:begin];
    layer.speed = 1;
}

+ (void)configCATransition:(CALayer *)layer {
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    [layer addAnimation:transition forKey:kCATransition];
}

+ (void)configPOPCATransition:(CALayer *)layer {
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    [layer addAnimation:transition forKey:kCATransition];
    
}

@end
