//
//  LDAppDelegate.h
//  LDBlueMoon
//
//  Created by Lilac on 13-11-6.
//  Copyright (c) 2013年 tranzvision. All rights reserved.
//

#import "WBApi.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "Reachability.h"
#import "MainViewController.h"
#import "APIKey.h"
#import <MAMapKit/MAMapKit.h>
#import "PPRevealSideViewController.h"
#import "AGViewDelegate.h"
@class ActivityModel;
@class LDHomeViewController;

@class AKTabBarController;


typedef NS_ENUM(NSInteger, LBNetworkState){
    LB2G3G ,
    LBWifi,
    LBNoInternet
};  //网络状态
typedef NS_ENUM(NSInteger, LBAuthorState){
    LBQQ ,
    LBWeiBo,
    LBRenRen
};

@interface LDAppDelegate : UIResponder <UIApplicationDelegate>
{
    AKTabBarController *tabBarController;
    LDHomeViewController *homeViewController;
    NSInteger loginStatus;
    
    AGViewDelegate *viewDelegate;
    Reachability *reachability;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) AKTabBarController *tabBarController;
@property (nonatomic, assign) NSInteger loginStatus; // 0:非登出状态且未登录(正常状态) 1:登出状态 2:登录成功

@property (nonatomic, readonly) AGViewDelegate *viewDelegate;
@property (nonatomic, retain) Reachability *reachability;

@property (nonatomic, strong) MainViewController *mainViewController;//标签控制器
@property (nonatomic, strong) PPRevealSideViewController *_revealSideViewController;
@property (nonatomic, retain) NSMutableDictionary *shareDic;

@property (nonatomic,assign)BOOL login; //标记登陆、、李冰


#warning -MARK -\/\/\/\/\\\/\/\\\\\\\\/\/\/\----------/***********************/
//测试用
@property (nonatomic,assign)int atACNum;
@property (nonatomic,assign)int atCLNum;
@property (nonatomic,assign)int AplACNum;
@property (nonatomic,assign)int AplClNum;
@property (nonatomic,strong)NSString* imageName;
@property (nonatomic,assign)int  numat;

@property (nonatomic,strong)ActivityModel *model;
@end
