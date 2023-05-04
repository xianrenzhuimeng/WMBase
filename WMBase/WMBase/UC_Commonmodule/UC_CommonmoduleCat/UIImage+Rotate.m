//
//  UIImage+Rotate.m
//  FTT_AuxiliaryTools
//
//  Created by 樊腾 on 17/6/8.
//  Copyright © 2017年 FTT. All rights reserved.
//

#import "UIImage+Rotate.h"
/** 颜色宏 */
#define KColor(r,g,b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]

/** 转换角度 */
#define degreesToRadians(x) (M_PI*(x)/180.0)

@implementation UIImage (Rotate)

/**
 设置图片方向(逆时针)

 @param Angle 角度
 @return 转换后的图片
 */
- (UIImage*)imageRotatedByAngle:(CGFloat)Angle {

    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    CGSize rotatedSize;
    rotatedSize.width = width;
    rotatedSize.height = height;
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    CGContextRotateCTM(bitmap, Angle * M_PI / 180); //* M_PI / 180
    CGContextRotateCTM(bitmap, M_PI);
    CGContextScaleCTM(bitmap, -1.0, 1.0);
    CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width/2, -rotatedSize.height/2, rotatedSize.width, rotatedSize.height), self.CGImage);
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


/**
 图片转换方向

 @param degrees 度数
 @return 转换后的图片
 */
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees {
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    // 我们的绘图空间的旋转视图的包含框的大小
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,width,height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(degreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    // 创建位图上下文
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    CGContextRotateCTM(bitmap, degrees * M_PI / 180); //* M_PI / 180
    CGContextRotateCTM(bitmap, M_PI);
    CGContextScaleCTM(bitmap, -1.0, 1.0);
    CGContextDrawImage(bitmap, CGRectMake(-width / 2, -height / 2, width, height), [self CGImage]);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/** 设置图片 */
+ (UIImage *)pz_reSizeImage:(UIImage *)image imageframe:(CGRect)imageframe {
    UIGraphicsBeginImageContext(CGSizeMake(imageframe.size.width, imageframe.size.height));
    [image drawInRect:imageframe];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [reSizeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


/// 设置图片的颜色
- (UIImage *)imageWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)imageWithRadius:(CGFloat)radius rectSize:(CGSize)rectSize{
    CGRect rect = CGRectMake(0, 0, rectSize.width, rectSize.height);
    UIGraphicsBeginImageContextWithOptions(rectSize, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(),[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



- (UIImage *)imageWithCornerRadius:(CGFloat)radius {
    CGRect rect = (CGRect){0.f, 0.f, self.size};
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}


- (UIImage *)imageWithbyRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii {
    CGRect rect = (CGRect){0.f, 0.f, self.size};
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}


/// 组件化加载image
+ (instancetype)wy_imgWithName:(NSString *)name bundle:(NSString *)bundleName targetClass:(Class)targetClass{
    NSInteger scale = [[UIScreen mainScreen] scale];
    NSBundle *curB = [NSBundle bundleForClass:targetClass];
    NSString *imgName = [NSString stringWithFormat:@"%@@%zdx.png", name,scale];
    NSString *dir = [NSString stringWithFormat:@"%@.bundle",bundleName];
    NSString *path = [curB pathForResource:imgName ofType:nil inDirectory:dir];
    return path?[UIImage imageWithContentsOfFile:path]:nil;
}
@end
