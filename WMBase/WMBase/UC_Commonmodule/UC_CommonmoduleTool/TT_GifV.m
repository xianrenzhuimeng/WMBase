//
//  TT_GifV.m
//  XXX
//
//  Created by MacBook Pro on 2019/8/6.
//  Copyright @ 2019 绑耀 All rights reserved.
//

#import "TT_GifV.h"
#import "TT_GeneralProfile.h"
#import "UC_CommonmoduleTool.h"
#import <YYKit/YYKit.h>

@interface TT_GifV ()

@property (nonatomic , strong) YYAnimatedImageView *headerIMG;

@end

@implementation TT_GifV


+ (instancetype)share_tool {
    static TT_GifV *tt = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tt = [[TT_GifV alloc]init];
    });
    return tt;
}


- (void)setupYYImageViewconfigview:(UIView *)view {
    IPhoneXHeigh
    self.frame = CGRectMake(0, securitytop_Y, KScreenWidth, security_H);
    [view addSubview:self];
    Exist(@"img-config") {
          NSDictionary *img_info = TakeOut(@"img-config");
          if (img_info) {
              @weakify(self)
              if (img_info[@"LOADING_GIF"]) {
                 [self.headerIMG setImageWithURL:[NSURL URLWithString:img_info[@"LOADING_GIF"]]
                                  placeholder:SD_LoadImg
                                      options:YYWebImageOptionSetImageWithFadeAnimation
                                      manager:[Create_Tool ImageManager]
                                     progress:nil
                                    transform:nil
                                   completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                     @strongify(self)
                      if (error) {
                          [self configNormal];
                      }
                 }];
              }else {
                  [self configNormal];
              }
          }else {
              [self configNormal];
          }
      }else {
          [self configNormal];
      }
    self.headerIMG.frame = CGRectMake(self.bounds.size.width / 2 - 40, self.height / 2 - 100, 80, 80);
    [self addSubview:self.headerIMG];
}

-(void)setupYYImageView{
    [self setupYYImageViewconfigview:topViewController().view];
}

- (void)configNormal {
    NSMutableArray *imgarr = [NSMutableArray new];
    for (int i = 1; i<= 2; i++) {
        [imgarr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"big_%d.png",i]]];
    }
    UIImage * img = [UIImage animatedImageWithImages:imgarr duration:0.5];
    self.headerIMG.image = img;
}

- (void)dismiss {
    [self removeFromSuperview];
}

- (YYAnimatedImageView *)headerIMG {
    if (!_headerIMG) {
        _headerIMG = [YYAnimatedImageView new];
    }
    return _headerIMG;
}
@end
