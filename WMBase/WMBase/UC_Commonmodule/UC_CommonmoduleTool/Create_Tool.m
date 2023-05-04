//
//  Create_Tool.m
//  捕鱼达人
//
//  Created by linlin dang on 2019/3/26.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "Create_Tool.h"
#import "TT_DarkmodeTool.h"

@implementation Create_Tool



+ (YYLabel *)CreateLabel {
    YYLabel *label = [YYLabel new];
    label.displaysAsynchronously = NO;
    label.numberOfLines          = 0;
    label.textVerticalAlignment  = YYTextVerticalAlignmentCenter;
    return label;
}


+ (YYLabel *)CreateLabelforbackgroudcolor {
    YYLabel *label = [Create_Tool CreateLabel];
    label.backgroundColor = [TT_DarkmodeTool TT_normaF7F];
    return label;
}

+ (YYAnimatedImageView *)CreateIMG {
    YYAnimatedImageView *imageview = [YYAnimatedImageView new];
    imageview.backgroundColor = [TT_DarkmodeTool TT_normaF7F];
    imageview.contentMode =  UIViewContentModeScaleAspectFill;
    return imageview;
}

+ (YYLabel *)CreatLabeltextcolor:(UIColor *)textcolor textfont:(UIFont*)textfont{
    YYLabel *label = [YYLabel new];
    label.displaysAsynchronously = NO;
    label.numberOfLines          = 0;
    label.textVerticalAlignment  = YYTextVerticalAlignmentCenter;
    label.textColor              = textcolor;
    label.font                   = textfont;
    return label;
}

+ (YYWebImageManager *)ImageManager {
    static YYWebImageManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[UIApplication sharedApplication].cachesPath stringByAppendingPathComponent:@"TBK.avatar"];
        YYImageCache *cache = [[YYImageCache alloc] initWithPath:path];
        manager = [[YYWebImageManager alloc] initWithCache:cache queue:[YYWebImageManager sharedManager].queue];
        
    });
    return manager;
}

+ (YYWebImageManager *)ImageManagerSS {
    static YYWebImageManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[UIApplication sharedApplication].cachesPath stringByAppendingPathComponent:@"PZ.avatar"];
        YYImageCache *cache = [[YYImageCache alloc] initWithPath:path];
        manager = [[YYWebImageManager alloc] initWithCache:cache queue:[YYWebImageManager sharedManager].queue];
        
    });
    return manager;
}

+ (YYWebImageManager *)avatarImageManager {
    static YYWebImageManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[UIApplication sharedApplication].cachesPath stringByAppendingPathComponent:@"PZ_Field.avatar"];
        YYImageCache *cache = [[YYImageCache alloc] initWithPath:path];
        manager = [[YYWebImageManager alloc] initWithCache:cache queue:[YYWebImageManager sharedManager].queue];
        manager.sharedTransformBlock = ^(UIImage *image, NSURL *url) {
            if (!image) return image;
            return [image imageByRoundCornerRadius:100];
        };
    });
    return manager;
}




@end
