
//
//  TT_MongoliaV.m
//   
//
//  Created by 樊腾 on 2020/3/17.
//  Copyright © 2020 绑耀. All rights reserved.
//

#import "TT_MongoliaV.h"
#import "TT_GeneralProfile.h"
#import "SYBJ_ColorS.h"
@implementation TT_MongoliaV


- (void)tt_setupViews {
    self.backgroundColor = [self configbackgroundcolor];
}


- (UIColor *)configbackgroundcolor {
    if (@available(iOS 13.0, *)) {
        UIColor * color = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection){
          if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight){
              return  [UIColor clearColor];
          }else if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark){
              return [Col_000 colorWithAlphaComponent:0.45];
          }
            return [UIColor clearColor];
        }];
        return color;
    }else {
        return [UIColor clearColor];
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *v = [super hitTest:point withEvent:event];
    if (v == self) {
        return nil;
    }
    return v;
}
@end
