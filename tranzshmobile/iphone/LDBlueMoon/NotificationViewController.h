//
//  NotificationViewController.h
//  tz_bluemoon_ios_iphone
//
//  Created by IceBoy on 13-12-23.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "BaseViewController.h"

@interface NotificationViewController : BaseViewController<UIAlertViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)NSArray *dataSource;
@property(nonatomic,retain)UITableView  *tabelView;

@end
