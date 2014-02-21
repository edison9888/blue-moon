//
//  TeacherViewController.h
//  LDBlueMoon
//
//  Created by IceBoy on 14-1-14.
//  Copyright (c) 2014年 tranzvision. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseDataModel.h"
@interface TeacherViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong)TeacherModel *model;
@property(nonatomic, strong)UIImageView  *headerView;
@property(nonatomic, strong)UILabel      *nameLable;
@property(nonatomic, strong)UILabel      *sexLable;
@property(nonatomic, strong)UILabel      *ageLable;
@property(nonatomic, strong)UILabel      *introduceLable;
@property(nonatomic, strong)UITableView  *tableView;
@property(nonatomic, strong)NSArray      *dataSource;




@end
