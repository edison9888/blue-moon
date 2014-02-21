//
//  LDCourseDetailViewController.m
//  LDBlueMoon
//
//  Created by Lilac on 13-12-3.
//  Copyright (c) 2013年 tranzvision. All rights reserved.
//

#import "LDCourseDetailViewController.h"

@interface LDCourseDetailViewController ()

@end

@implementation LDCourseDetailViewController
@synthesize appDelegate;
@synthesize starItem;
@synthesize shareItem;
@synthesize mbProgress;


- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.title = @"课程详情";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    starItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"star.png"] style:UIBarButtonItemStylePlain target:self action:@selector(starItemPressed)];
    shareItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share.png"] style:UIBarButtonItemStylePlain target:self action:@selector(shareItemPressed:)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:starItem,shareItem, nil];
}

-(void)starItemPressed
{
    mbProgress = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:mbProgress];
	
	// The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
//	mbProgress.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
	
    // Set custom view mode
    mbProgress.mode = MBProgressHUDModeCustomView;
	
//    mbProgress.delegate = self;
    mbProgress.labelText = @"收藏成功";
	
    [mbProgress show:YES];
	[mbProgress hide:YES afterDelay:3];
}

-(void)shareItemPressed:(id)sender
{
    [self shareWithTitle:@"这家店不错哦，一起去吧！"
              andContent:@"每一个不曾起舞的日子，都是对过往生命的辜负。你在等待什么呢？"
                  andUrl:[NSURL URLWithString:@"www.dahzima.com"]];
}

- (void)shareWithTitle:(NSString *)title
            andContent:(NSString *)content
                andUrl:(NSString *)url

{
#define IMAGE_NAME @"sharesdk_img"
#define IMAGE_EXT @"jpg"
    
#define CONTENT @"ShareSDK不仅集成简单、支持如QQ好友、微信、新浪微博、腾讯微博等所有社交平台，而且还有强大的统计分析管理后台，实时了解用户、信息流、回流率、传播效应等数据，详情见官网http://sharesdk.cn @ShareSDK"
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"Icon-72@2x" ofType:@"png"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:@""
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:title
                                                  url:url
                                          description:@""
                                            mediaType:SSPublishContentMediaTypeNews];
    
    
    id<ISSShareOptions> shareOptions = [ShareSDK defaultShareOptionsWithTitle:@"内容分享"
                                                              oneKeyShareList:[ShareSDK getShareListWithType:
                                                                               ShareTypeSinaWeibo, /**< 新浪微博 */
                                                                               ShareTypeMail, /**< 邮件分享 */
                                                                               ShareTypeSMS, /**< 短信分享 */
                                                                               ShareTypeWeixiSession , /**< 微信好友 */
                                                                               ShareTypeWeixiTimeline, /**< 微信朋友圈 */ nil]
                                                               qqButtonHidden:YES
                                                        wxSessionButtonHidden:NO
                                                       wxTimelineButtonHidden:NO
                                                         showKeyboardOnAppear:NO
                                                            shareViewDelegate:nil
                                                          friendsViewDelegate:nil
                                                        picViewerViewDelegate:nil];
    
    id<ISSContainer> container = [ShareSDK container];
//    [container setIPhoneContainerWithViewController:shareItem];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:[ShareSDK getShareListWithType:
                                    ShareTypeSinaWeibo, /**< 新浪微博 */
                                    ShareTypeMail, /**< 邮件分享 */
                                    ShareTypeSMS, /**< 短信分享 */
                                    ShareTypeWeixiSession , /**< 微信好友 */
                                    ShareTypeWeixiTimeline, /**< 微信朋友圈 */ nil]
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:shareOptions
                            result:^(ShareType type, SSPublishContentState state, id<ISSStatusInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
                                    UIView *view = [appDelegate.window.rootViewController.view viewWithTag:-123];
                                    [appDelegate.window.rootViewController.view bringSubviewToFront:view];
                                    [view removeFromSuperview];view = nil;
                                    UIView *addStatusBar = [[UIView alloc] init];
                                    addStatusBar.tag = -123;
                                    addStatusBar.frame = CGRectMake(0, 0, 320, 20);
                                    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
                                    addStatusBar.backgroundColor = [UIColor blackColor]; //change this to match your navigation bar
                                    [appDelegate.window.rootViewController.view addSubview:addStatusBar];
                                }
                                
                                if (state == SSPublishContentStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作成功！"
                                                                                    message:@""
                                                                                   delegate:self
                                                                          cancelButtonTitle:@"确定"
                                                                          otherButtonTitles:nil, nil];
                                    [alert show];
                                }
                                else if (state == SSPublishContentStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                    
                                    if ([error errorCode] == -18001) {
                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"尚未设置邮件帐号"
                                                                                        message:@"请在您的设备的邮箱应用中设置邮件账号"
                                                                                       delegate:self
                                                                              cancelButtonTitle:@"确定"
                                                                              otherButtonTitles:nil, nil];
                                        [alert show];
                                    }
                                    else if ([error errorCode] == -19001) {
                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"暂不支持短信分享"
                                                                                        message:@"请先激活您的iMessage账号"
                                                                                       delegate:self
                                                                              cancelButtonTitle:@"确定"
                                                                              otherButtonTitles:nil, nil];
                                        [alert show];
                                    }
                                    else if ([error errorCode] == 21332) {
                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"尚未授权微博账号"
                                                                                        message:@"请先登录微博进行授权"
                                                                                       delegate:self
                                                                              cancelButtonTitle:@"确定"
                                                                              otherButtonTitles:nil, nil];
                                        [alert show];
                                    }
                                    else if ([error errorCode] == -22003) {
                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"尚未安装微信"
                                                                                        message:@"请先安装微信应用程序"
                                                                                       delegate:self
                                                                              cancelButtonTitle:@"确定"
                                                                              otherButtonTitles:nil, nil];
                                        [alert show];
                                    }
                                }
                            }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
