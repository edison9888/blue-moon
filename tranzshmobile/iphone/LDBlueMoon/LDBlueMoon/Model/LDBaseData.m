//
//  LDBaseData.m
//  LDBlueMoon
//
//  Created by Lilac on 13-11-27.
//  Copyright (c) 2013年 tranzvision. All rights reserved.
//

#import "LDBaseData.h"

@implementation LDBaseData

@synthesize account;
@synthesize password;
@synthesize login;

@synthesize tsName;
@synthesize tsClass;
@synthesize tsNumber;
@synthesize tsNickname;
@synthesize tsIconURL;

@synthesize rememberPassword;


#pragma mark -
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:self.account forKey:kBaseDataAccountKey];
	[aCoder encodeObject:self.password forKey:kBaseDataPasswordKey];
    [aCoder encodeObject:self.login forKey:kBaseDataLoginStatusKey];
    
    [aCoder encodeObject:self.tsName forKey:kBaseDataTsNameKey];
	[aCoder encodeObject:self.tsClass forKey:kBaseDataTsClassKey];
    [aCoder encodeObject:self.tsNumber forKey:kBaseDataTsNumberKey];
    [aCoder encodeObject:self.tsNickname forKey:kBaseDataTsNicknameKey];
    [aCoder encodeObject:self.tsIconURL forKey:kBaseDataTsIconKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super init])) {
		self.account = [aDecoder decodeObjectForKey:kBaseDataAccountKey];
		self.password = [aDecoder decodeObjectForKey:kBaseDataPasswordKey];
        self.login = [aDecoder decodeObjectForKey:kBaseDataLoginStatusKey];
        
        self.tsName = [aDecoder decodeObjectForKey:kBaseDataTsNameKey];
        self.tsClass = [aDecoder decodeObjectForKey:kBaseDataTsClassKey];
        self.tsNumber = [aDecoder decodeObjectForKey:kBaseDataTsNumberKey];
        self.tsNickname = [aDecoder decodeObjectForKey:kBaseDataTsNicknameKey];
        self.tsIconURL = [aDecoder decodeObjectForKey:kBaseDataTsIconKey];
	}
	return self;
}

#pragma mark -
#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone
{
	LDBaseData *copyBaseData = [[[self class] allocWithZone:zone] init];
	copyBaseData.account = [self.account copyWithZone:zone];
	copyBaseData.password = [self.password copyWithZone:zone];
    copyBaseData.login = [self.login copyWithZone:zone];

    copyBaseData.tsName = [self.tsName copyWithZone:zone];
	copyBaseData.tsClass = [self.tsClass copyWithZone:zone];
	copyBaseData.tsNumber = [self.tsNumber copyWithZone:zone];
    copyBaseData.tsNickname = [self.tsNickname copyWithZone:zone];
    copyBaseData.tsIconURL = [self.tsIconURL copyWithZone:zone];
    
	return copyBaseData;
}


@end
