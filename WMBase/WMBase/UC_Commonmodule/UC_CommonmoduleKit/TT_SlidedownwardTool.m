
//
//  TT_SlidedownwardTool.m
//   
//
//  Created by 樊腾 on 2020/4/9.
//  Copyright © 2020 绑耀. All rights reserved.
//

#import "TT_SlidedownwardTool.h"


@interface TT_SlidedownwardTool ()

@property (nonatomic , strong) UIViewController *CC;

@property (nonatomic , strong) UIScrollView *scrollV;

@property (nonatomic , assign) CGFloat startpointx;

@property (nonatomic , assign) CGFloat startpointy;

@property (nonatomic , assign) BOOL isHorizontal;

@property (nonatomic , assign) CGFloat scale;

@property (nonatomic , strong) UIVisualEffectView *effectView;

@property (nonatomic , strong) UIImageView *imageV;

@end

@implementation TT_SlidedownwardTool


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.config_scale = 0.7;
    }
    return self;
}

- (void)tengteng_configSlidedownwardwithController:(UIViewController *)CC scrollv:(UIScrollView *)scrollv{
    
    self.CC = CC;
    self.scrollV = scrollv;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self
                                                                         action:@selector(tappan:)];
    [self.scrollV addGestureRecognizer:pan];
}



- (void)tappan:(UIPanGestureRecognizer *)pan {
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            [self tengteng_configRecognizerstatebegan:pan];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self tengteng_configRecoginerStateChanger:pan];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [self tengteng_configrecognizerStateEnded:pan];
        }
            break;
        default:
            break;
    }
}


/// 滑动将要开始
- (void)tengteng_configRecognizerstatebegan:(UIPanGestureRecognizer *)pan {
    CGPoint currentPoint = [pan locationInView:self.scrollV];
    self.startpointx = currentPoint.x;
    self.startpointy = currentPoint.y;
    if (self.startpointy > 30) {
        self.isHorizontal = NO;
    }else {
        self.isHorizontal = YES;
    }
}


- (void)tengteng_configRecoginerStateChanger:(UIPanGestureRecognizer *)pan {
    CGFloat width = self.scrollV.frame.size.width;
    CGPoint currentPoint = [pan locationInView:self.scrollV];
    if (self.isHorizontal) {
        if ((currentPoint.x - self.startpointx) > (currentPoint.y - self.startpointy)) {
            self.scale = (width - (currentPoint.x - self.startpointx)) / width;
        }else {
            self.scale = (width - (currentPoint.y - self.startpointy)) / width;
        }
    }else {
        self.scale = (width - (currentPoint.y - self.startpointy)) / width;
    }
    if (self.scale > 1.0) {
        self.scale = 1;
    }else if (self.scale < self.config_scale) {
        self.scale = self.config_scale;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.CC.navigationController popViewControllerAnimated:YES];
        });
    }
    
    if (self.scrollV.contentOffset.y <= 0) {
        self.scrollV.transform = CGAffineTransformMakeScale(self.scale, self.scale);
        self.scrollV.layer.cornerRadius = 15 * (1 - self.scale) * 5 * 1;
        self.scrollV.layer.masksToBounds = YES;
        
//        self.CC.view.transform = CGAffineTransformMakeScale(self.scale, self.scale);
//        self.CC.view.layer.cornerRadius = 15 * (1 - self.scale) * 5 * 1;
//        self.CC.view.layer.masksToBounds = YES;
    }
    if (self.scale < 0.95) {
        self.scrollV.scrollEnabled = NO;
    }else {
        self.scrollV.scrollEnabled = YES;
    }
}

- (void)tengteng_configrecognizerStateEnded:(UIPanGestureRecognizer *)pan {
    self.scale = 1;
    self.scrollV.scrollEnabled = YES;
    if (self.scale > self.config_scale) {
        [UIView animateWithDuration:0.5 animations:^{
            
            self.scrollV.layer.cornerRadius = 0;
            self.scrollV.transform = CGAffineTransformMakeScale(1, 1);
            
            
//            self.CC.view.layer.cornerRadius = 0;
//            self.CC.view.transform = CGAffineTransformMakeScale(1, 1);
        }];
    }
}



- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc]init];
        _imageV.frame = [UIScreen mainScreen].bounds;
    }
    return _imageV;
}


@end
