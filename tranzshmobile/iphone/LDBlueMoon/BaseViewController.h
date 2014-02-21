//
//  BaseViewController.h
//  tz_bluemoon_ios_iphone
//
//  Created by IceBoy on 13-12-20.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDAppDelegate.h"
#import "MBProgressHUD.h"
@interface BaseViewController : UIViewController<UINavigationControllerDelegate>{
    MBProgressHUD *_progressHUD;
}
- (LDAppDelegate*)appDelegate;
- (void)showBackButtonItem;
- (void)showAlertWithTitle:(NSString*)title message:(NSString*)message;
- (void)showNoNetWork;
- (void)showHUDWithTitle:(NSString*)title;
- (void)removeHUD;
- (void)popNavigation;
@end
