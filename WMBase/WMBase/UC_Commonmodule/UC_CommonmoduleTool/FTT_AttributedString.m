//
//  FTT_AttributedString.m
//  破竹
//
//  Created by linlin dang on 2018/5/10.
//  Copyright © 2018年 米宅. All rights reserved.
//

#import "FTT_AttributedString.h"

@implementation FTT_AttributedString


+ (NSMutableAttributedString *)initFirststr:(NSString *)FirstStr
                              FirstStrColor:(UIColor *)FirstStrColor
                               FirstStrFont:(UIFont *)FirstStrFont
                                  SecondStr:(NSString *)SecondStr
                              SeconStrColor:(UIColor *)SeconStrColor
                              SecondStrFont:(UIFont *)SecondStrFont {
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]init];
    NSMutableAttributedString *FirstAttributeString = [[NSMutableAttributedString alloc]initWithString:FirstStr];
    FirstAttributeString.color = FirstStrColor;
    FirstAttributeString.font  = FirstStrFont;
    
    NSMutableAttributedString *SecondAttributeString = [[NSMutableAttributedString alloc]initWithString:SecondStr];
    SecondAttributeString.color = SeconStrColor;
    SecondAttributeString.font  = SecondStrFont;
    [text appendAttributedString:FirstAttributeString];
    [text appendAttributedString:SecondAttributeString];
    return text;
}


+ (NSMutableAttributedString *)AttributedStringwithIMG_name:(NSString  *)IMG_name
                                                  IMG_Color:(UIColor *)IMG_Color
                                                  IMG_frame:(CGRect)IMG_frame
                                                        Str:(NSString *)Str
                                                 fontintger:(NSInteger)fontintger
                                                  textColor:(UIColor *)textColor
                                                    atIndex:(NSInteger)atindex {
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    UIFont *font = [UIFont fontWithName:@"PingFang-SC-Regular" size:fontintger];
    UIImage *IMG = [[UIImage imageNamed:IMG_name] imageWithColor:IMG_Color];
    NSTextAttachment *attchment = [[NSTextAttachment alloc]init];
    attchment.image  = IMG;
    attchment.bounds = IMG_frame;
    
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:(NSTextAttachment *)(attchment)];
    [text appendString:Str];
    [text insertAttributedString:string atIndex:atindex];
    text.font = font;
    text.color = textColor;
    return text;
}

+ (NSMutableAttributedString *)AttributedStringwithimageatlastIMG_name:(NSString  *)IMG_name
                                                             IMG_Color:(UIColor *)IMG_Color
                                                             IMG_frame:(CGRect)IMG_frame
                                                                   Str:(NSString *)Str
                                                            fontintger:(NSInteger)fontintger
                                                             textColor:(UIColor *)textColor {
    return [FTT_AttributedString AttributedStringwithIMG_name:IMG_name
                                                    IMG_Color:IMG_Color
                                                    IMG_frame:IMG_frame
                                                          Str:Str
                                                   fontintger:fontintger
                                                    textColor:textColor
                                                      atIndex:Str.length];
}


+ (NSMutableAttributedString *)AttributedStringwithimageatfirstIMG_name:(NSString  *)IMG_name
                                                              IMG_Color:(UIColor *)IMG_Color
                                                              IMG_frame:(CGRect)IMG_frame
                                                                    Str:(NSString *)Str
                                                             fontintger:(NSInteger)fontintger
                                                              textColor:(UIColor *)textColor {
    return [FTT_AttributedString AttributedStringwithIMG_name:IMG_name
                                             IMG_Color:IMG_Color
                                             IMG_frame:IMG_frame
                                                   Str:Str
                                            fontintger:fontintger
                                             textColor:textColor
                                               atIndex:0];
}

@end
