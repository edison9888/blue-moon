//
//  LGModelData.h
//  tz_bluemoon_ios_iphone
//
//  Created by IceBoy on 13-12-23.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGModelData : NSObject
@property(nonatomic,retain)NSString *nickName;
@property(nonatomic,retain)NSString *actorUrl;
@property(nonatomic,retain)NSString *age;
@property(nonatomic,retain)NSString *mail;
@property(nonatomic,retain)NSString *addr;
@property(nonatomic,retain)NSString *phoneNo;
@property(nonatomic,retain)NSString *sex;
@property(nonatomic,strong)NSString *idNum;
+(id)shareDataOfLogin;
@end
