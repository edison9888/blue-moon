//
//  LDBaseData.h
//  LDBlueMoon
//
//  Created by Lilac on 13-11-27.
//  Copyright (c) 2013年 tranzvision. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kBaseDataFileName       @"BaseDataArchive"
#define kBaseDataKey            @"LDBaseData"

#define kBaseDataAccountKey     @"Account"
#define kBaseDataPasswordKey    @"Password"
//#define kBaseDataRememberKey    @"Remember"
#define kBaseDataLoginStatusKey @"Status"

#define kBaseDataTsNameKey      @"TsName"
#define kBaseDataTsClassKey     @"TsClass"
#define kBaseDataTsNumberKey    @"TsNumber"
#define kBaseDataTsIconKey      @"TsIcon"
#define kBaseDataTsNicknameKey  @"TsNickName"


@interface LDBaseData : NSObject<NSCoding, NSCopying>

@property (nonatomic, retain) NSString *account;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, assign) NSNumber *login;

@property (nonatomic, retain) NSString *tsName;
@property (nonatomic, retain) NSString *tsClass;
@property (nonatomic, retain) NSString *tsNumber;
@property (nonatomic, retain) NSString *tsNickname;
@property (nonatomic, retain) NSString *tsIconURL;

@property (nonatomic, assign) BOOL rememberPassword;

@end
