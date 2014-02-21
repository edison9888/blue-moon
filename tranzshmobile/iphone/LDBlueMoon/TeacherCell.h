//
//  TeacherCell.h
//  tz_bluemoon_ios_iphone
//
//  Created by IceBoy on 13-12-31.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDataModel.h"
@interface TeacherCell : UITableViewCell
@property(nonatomic,strong)TeacherModel *model;
@property(nonatomic,strong)UILabel *nameLable;     //老师名字
@property(nonatomic,strong)UIImageView *headerView;//老师头像
@property(nonatomic,strong)UILabel *sexLable;      //老师性别
@property(nonatomic,strong)UILabel *classLable;    //课程


@end
