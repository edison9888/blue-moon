//
//  ActivityViewController.h
//  tz_bluemoon_ios_iphone
//
//  Created by IceBoy on 13-12-23.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "BaseViewController.h"
#import "ActivityModel.h"
@interface ActivityDetailViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{

}
@property(nonatomic,strong)ActivityModel *model;
@property(nonatomic,strong)NSString *imageName;

@property(nonatomic,strong)NSArray     *dataSource;

@property(nonatomic,strong)UITableView *tableView;   //显示评论
@property(nonatomic,strong)UIImageView *headerView;
@property(nonatomic,strong)UIButton     *titleLable;  //活动标题
@property(nonatomic,strong)UILabel     *intruceLable;//活动介绍
@property(nonatomic,strong)UIButton     *numLable;    //活动参加人数
@property(nonatomic,strong)UIButton     *addrLable;   //活动地点
@property(nonatomic,strong)UIButton     *hostLabel;   //活动归属者
@property(nonatomic,strong)UILabel     *timeLable;   //活动时间
//@property(nonatomic,strong)UILabel     *



@end
