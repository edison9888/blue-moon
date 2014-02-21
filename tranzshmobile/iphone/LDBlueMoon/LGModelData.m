//
//  LGModelData.m
//  tz_bluemoon_ios_iphone
//
//  Created by IceBoy on 13-12-23.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "LGModelData.h"
__strong static LGModelData *loginModel = nil;
@implementation LGModelData

// 这里使用的是ARC下的单例模式
+ (id)shareDataOfLogin
{
    // dispatch_once不仅意味着代码仅会被运行一次，而且还是线程安全的
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        loginModel = [[super allocWithZone:NULL] init];
    });
    return loginModel;
}

+ (id)allocWithZone:(NSZone *)zone
{
    
/* 这段代码无法使用, 那么我们如何解决alloc方式呢？
     dispatch_once(&pred, ^{
     singleton = [super allocWithZone:zone];
     return singleton;
     });
*/
    return [self shareDataOfLogin];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}
@end
