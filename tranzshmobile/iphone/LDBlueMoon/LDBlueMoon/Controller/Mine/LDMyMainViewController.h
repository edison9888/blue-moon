//
//  LDMyMainViewController.h
//  SinaLoginDemo
//
//  Created by vimfung on 13-8-18.
//  Copyright (c) 2013年 vimfung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDMyLoginViewController.h"
#import "LDCalendarViewController.h"
#import "LDMyInfoViewController.h"


#import "LDAppDelegate.h"
#import "LDBaseData.h"
#import "LDTempViewController.h"
// HTTP Request
#import "ASIHTTPRequest.h"

@class LDHomeViewController;

@interface LDMyMainViewController : UIViewController<LDThirdPartyLoginDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)LDAppDelegate *appDelegate;
@property(nonatomic,retain)UIWindow *iWindow;

- (NSString *)baseDataFilePath;

@end
