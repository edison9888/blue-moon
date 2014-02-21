//
//  MyClassViewController.h
//  tz_bluemoon_ios_iphone
//
//  Created by IceBoy on 13-12-23.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "BaseViewController.h"

@interface MyClassViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSArray *dataSource;
@end
