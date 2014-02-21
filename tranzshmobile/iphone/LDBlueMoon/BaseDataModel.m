//
//  BaseDataModel.m
//  LDBlueMoon
//
//  Created by IceBoy on 14-1-15.
//  Copyright (c) 2014年 tranzvision. All rights reserved.
//

#import "BaseDataModel.h"

@implementation BaseDataModel
-(id)initWithData:(id)data
{
    if (self = [super init]) {
        
    }
    return self;
}
@end

@implementation SchoolModel
-(id)initWithData:(id)data
{
    if (self = [super initWithData:data]) {
        self.logoUrl = @"http://www.xmwebi.com.cn/Uploads/Editor/image/20131230_124238_123.jpg";
        self.name = @"EF英孚教育";
        self.nature = @"语言、音乐、舞蹈";
        self.phoneNum = @"400 - 1188 - 73";
    }
    return self;
}
@end


@implementation ClassModel
-(id)initWithData:(id)data{
    if (self =[super initWithData:data]) {
        self.title    = @"身心合一,无限伸展~阴瑜伽";
        self.time     = @"每周一,三晚上7点";
        self.nowPrice = @"$1500";
//        self.oldPrice = @"$1600";
        self.photoUrl = @"http://10.10.1.202/users/appserver/images/1aa7fd7f4b84a09588f02a3c1d29ae2d?accessToken=b368ab20197e3c8e770f11dd75ae9879d9914fe29b81291f708cc173daae0cac";
        self.addr     = @"静安区";
        self.num      = @"20";
        
        
        self.content  = @"瑜伽起源于印度，距今有五千多年的历史文化被人们称为“世界的瑰宝瑜伽境界瑜伽境界瑜伽发源印度北部的喜马拉雅山麓地带，古印度瑜伽修行者在大自然中修炼身心时，无意中发现各种动物与植物天生具有治疗、放松、睡眠、或保持清醒的方法，患病时能不经任何治疗而自然痊愈。于是古印度瑜伽修行者根据动物的姿势观察、模仿并亲自体验，创立出一系列有益身心的锻炼系统，也就是体位法。这些姿势历经了五千多年的锤炼，瑜伽教给人们的治愈法，让世世代代的人从中获益.关于瑜伽的记载最早出现在《吠陀经》的印度经文中，大约在公元前300年时，瑜伽之祖帕坦伽利在《瑜伽经》中阐明了使身体健康、精神充实的修炼课程，这门课程被其系统化和规范化，构成当代瑜伽修炼的基础。帕坦伽利提出的哲学原理被公认为是通往瑜伽精神境界的里程碑";
        
        self.classStyle = @"Y+瑜伽";
    }
    return self;
}
-(void)dealloc{
    self.time  = nil;
    self.title = nil;
    self.nowPrice = nil;
    self.oldPrice = nil;
    self.photoUrl = nil;
    self.num     = nil;
    self.addr    = nil;
    self.content = nil;
    
}

@end

@implementation TeacherModel
- (id)initWithData:(id)data
{
    if (self = [super initWithData:data]) {
        self.phoneNO  = @"15938765931";
        self.actorUrl = @"http://f.hiphotos.bdimg.com/album/w%3D2048/sign=784d27d40ff41bd5da53eff465e280cb/aec379310a55b319ee97428a42a98226cefc17e6.jpg";
        self.sex     = @"性别: 女";
        self.age     = @"28";
        self.flowers = @"33";
        self.name    = @"姓名: Zero.Li";
        self.className = @"课程: 音乐";
    }
    
    return self;
}
@end
