//
//  WKProcessPool+SharedProcessPool.h
//  XXX
//
//  Created by 王猛 on 2019/9/19.
//  Copyright © 2019 绑耀. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKProcessPool (SharedProcessPool)
+(WKProcessPool*)sharedProcessPool;
@end

NS_ASSUME_NONNULL_END
