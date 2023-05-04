//
//  Create_Tool.h
//  捕鱼达人
//
//  Created by linlin dang on 2019/3/26.
//  Copyright © 2019 FTT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <YYKit/YYKit.h>



NS_ASSUME_NONNULL_BEGIN

@interface Create_Tool : NSObject

+ (YYLabel *)CreateLabel;

+ (YYLabel *)CreateLabelforbackgroudcolor;

+ (YYAnimatedImageView *)CreateIMG;

+ (YYLabel *)CreatLabeltextcolor:(UIColor *)textcolor textfont:(UIFont *)textfont;

+ (YYWebImageManager *)ImageManager;

+ (YYWebImageManager *)ImageManagerSS;

+ (YYWebImageManager *)avatarImageManager;




@end

NS_ASSUME_NONNULL_END
