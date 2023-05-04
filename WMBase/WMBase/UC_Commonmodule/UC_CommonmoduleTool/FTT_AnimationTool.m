//
//  FTT_AnimationTool.m
//  FTT_LoadAnimation
//
//  Created by linlin dang on 2018/5/19.
//  Copyright © 2018年 FTT. All rights reserved.
//

#import "FTT_AnimationTool.h"
#import <UIKit/UIKit.h>
@implementation FTT_AnimationTool


+ (void)addcircularAnimationlayer:(id)layer
                         duration:(float)duration
                         rotation:(NSString *)rotation {
    [FTT_AnimationTool addcircularAnimationlayer:layer
                                  duration:duration
                                  rotation:rotation
                               repeatCount:LONG_MAX
                              autoreverses:NO
                                 fromValue:@(0)
                                   toValue:@(M_PI * 2)];
}

/// 暂停动画
+ (void)pasuseAnimation:(CALayer *)layer {
    CFTimeInterval pauseTime = CACurrentMediaTime();
    /// 设置速度为0，t停止动画
    layer.speed = 0;
    /// 保存暂停时间，便于恢复
    layer.timeOffset = pauseTime;
}

/// 恢复动画
+ (void)resumeAnimation:(CALayer *)layer {
    /// 获取暂停时保存的时间
    CFTimeInterval pauseTime = layer.timeOffset;
    /// 设置速度
    layer.speed = 1.0;
    /// 清除开始时间
    layer.beginTime = 0.0;
    /// 计算开始时间
    CFTimeInterval beginTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pauseTime;
    /// 重设开始时间
    layer.beginTime = beginTime;
    
}


+ (void)addcircularAnimationlayer:(id)layer
                         duration:(float)duration
                         rotation:(NSString *)rotation
                      repeatCount:(NSInteger)repeatCount
                     autoreverses:(BOOL)autoreverses
                        fromValue:(id)fromValue
                          toValue:(id)toValue {
    [layer addAnimation:[FTT_AnimationTool configAnimationduration:duration
                                                          rotation:rotation
                                                       repeatCount:repeatCount
                                                      autoreverses:autoreverses
                                                         fromValue:fromValue
                                                           toValue:toValue]
                 forKey:@"animation"];
}

+ (CABasicAnimation *)configAnimationduration:(float)duration
                                     rotation:(NSString *)rotation
                                  repeatCount:(NSInteger)repeatCount
                                 autoreverses:(BOOL)autoreverses
                                    fromValue:(id)fromValue
                                      toValue:(id)toValue {
    
    NSString *Rotation            = rotation;
    CABasicAnimation *animation   = [CABasicAnimation animationWithKeyPath:Rotation];
    animation.fromValue           = fromValue;
    animation.toValue             = toValue;
    animation.duration            = duration;
    animation.repeatCount         = repeatCount;
    animation.autoreverses        = autoreverses;
    animation.removedOnCompletion = NO;
    animation.fillMode            = kCAFillModeForwards;
    return animation;
}


+ (void)addCATransitiontype:(CATransitionType)type
                   duration:(CGFloat)duration
                      layer:(id)layer{
    CATransition *transition = [CATransition animation];
    transition.duration = duration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    transition.type = type;
    [layer addAnimation:transition forKey:@"transition"];
}


@end
