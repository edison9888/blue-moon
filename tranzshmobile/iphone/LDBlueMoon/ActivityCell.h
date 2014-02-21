//
//  BaseModelCell.h
//  tz_bluemoon_ios_iphone
//
//  Created by IceBoy on 13-12-23.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"
@interface ActivityCell : UITableViewCell
@property(nonatomic,retain)ActivityModel *model;
@property(nonatomic,strong)UILabel *activityName;  //活动名称
@property(nonatomic,strong)UILabel *activityAddr;  //活动地址
//@property(nonatomic,strong)UILabel *activityTheme;
@property(nonatomic,strong)UILabel *activityTime;  //活动时间
@property(nonatomic,strong)UILabel *activityHost;  //活动归属机构
@property(nonatomic,strong)UILabel *activityPn;    //活动人数

@property(nonatomic,strong)UIImageView *schoolLogo;//归属机构 logo


@end
