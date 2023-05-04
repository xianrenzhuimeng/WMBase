//
//  NSString+URL.h
//  破竹
//
//  Created by 米宅 on 2017/12/1.
//  Copyright © 2017年 米宅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (URL)

- (NSString *)urlEncode;

/**
 *  URLEncode
 */
- (NSString *)URLEncodedString;

- (NSString *)changeTelephone:(NSString*)teleStr;

/**
 *  URLDecode
 */
-(NSString *)URLDecodedString;

- (BOOL)isValidUrl;

-(NSString *)base64EncodeString:(NSString *)string;

-(NSString *)base64DecodeString:(NSString *)string;

- (BOOL)isEmpty ;

+ (NSString *)App_Name;
/// 千万级别的转换
- (NSString *)changeAsset:(NSString *)amountStr;

-(NSMutableAttributedString *)setAttributedString:(NSString *)str;
//计算html字符串高度
-(CGFloat )getHTMLHeightByStr:(NSString *)str;

-(NSString *)removeFloatAllZero:(NSString *)string;

//判断是否为整形：

- (BOOL)isPureInt:(NSString*)string;
@end
