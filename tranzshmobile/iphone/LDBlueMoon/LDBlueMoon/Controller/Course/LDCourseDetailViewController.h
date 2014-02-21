//
//  LDCourseDetailViewController.h
//  LDBlueMoon
//
//  Created by Lilac on 13-12-3.
//  Copyright (c) 2013年 tranzvision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDAppDelegate.h"
#import "MBProgressHUD.h"


@interface LDCourseDetailViewController : UIViewController

@property (nonatomic,retain) LDAppDelegate *appDelegate;
@property (nonatomic,retain) UIBarButtonItem *starItem;
@property (nonatomic,retain) UIBarButtonItem *shareItem;

@property (nonatomic,retain) MBProgressHUD *mbProgress;

@end
