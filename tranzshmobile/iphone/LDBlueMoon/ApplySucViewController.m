

#import "ApplySucViewController.h"
#import "MyActivityViewController.h"
#import "UIViewExt.h"
@interface ApplySucViewController ()

@end

@implementation ApplySucViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"报名成功";
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //导航栏按钮
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 23, 23)];
    
    [rightButton addTarget:self action:@selector(share)
          forControlEvents:UIControlEventTouchUpInside];
    
    [rightButton  setImage:[UIImage imageNamed:@"share_item.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self initSubViews];
	
}
- (void)initSubViews
{
    self.navigationItem.leftBarButtonItem.customView.hidden = YES;
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, KSCreen_Height-64)];
    scroll.contentSize = CGSizeMake(KSCreen_Width, KSCreen_Height-64);
    scroll.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    [self.view addSubview:scroll];
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, 56)];
    backgroundView.backgroundColor = [UIColor clearColor];
    UIImageView *imageView =
    [[UIImageView alloc]initWithFrame:CGRectMake((KSCreen_Width-177)/2, (56-27)/2, 177, 27)];
    imageView.image = [UIImage imageNamed:@"congra_icon.png"];
    [backgroundView addSubview:imageView];

    [scroll addSubview:backgroundView];

    
    NSArray *array = @[@"课程",@"班级",@"姓名",@"电话",@"邮箱"];
    NSArray *hoders = @[@"手工折纸课",@"精品小班A班",
                        @"Sirius Black",@"15120099909",
                        @"app.tranzvision.com.cn"];
    for (int i = 0; i<5; i++) {
        UIView *cell =
        [[UIView alloc]initWithFrame:CGRectMake(0, backgroundView.bottom+38*i, KSCreen_Width, 38)];
        cell.backgroundColor = [UIColor whiteColor];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(26, 9, 40, 20)];
        lable.font = [UIFont systemFontOfSize:14];
        lable.text = [array objectAtIndex:i];
        lable.backgroundColor = [UIColor clearColor];
        
        UILabel *textField = [[UILabel alloc]initWithFrame:CGRectMake(lable.right+5, 4, 180, 30)];
      
        textField.text =[hoders objectAtIndex:i];
        textField.textColor = [UIColor grayColor];
        textField.font = [UIFont systemFontOfSize:14];
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 37.5, KSCreen_Width, .5)];
        line.backgroundColor =  [UIColor colorWithRed:197/255.0
                                                green:198/255.0
                                                 blue:193/255.0 alpha:1];
        [cell addSubview:line];
        [cell addSubview:lable];
        [cell addSubview:textField];
        [scroll addSubview:cell];
    }
    
    
    UIButton *applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    applyButton.frame = CGRectMake(20,backgroundView.bottom+220, 133, 35);
 
    [applyButton setImage:[UIImage imageNamed:@"checkList_btn.png"]
                 forState:UIControlStateNormal];
    
    UILabel *list = [[UILabel alloc]initWithFrame:CGRectMake(0, 7.5, 133, 20)];
    list.font = [UIFont systemFontOfSize:14];
    list.backgroundColor = [UIColor clearColor];
    list.text = @"查看已报名列表";
    list.textColor = [UIColor whiteColor];
    list.textAlignment = NSTextAlignmentCenter;
    [applyButton addSubview:list];
    
    [applyButton addTarget:self
                    action:@selector(check)
          forControlEvents:UIControlEventTouchUpInside];
  
    

    
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.frame = CGRectMake(applyButton.right+17,backgroundView.bottom+220, 133, 35);
    
    
    [cancleButton setImage:[UIImage imageNamed:@"backDetail_btn.png"] forState:UIControlStateNormal];
    
    UILabel *back = [[UILabel alloc]initWithFrame:CGRectMake(0, 7.5, 133, 20)];
    back.backgroundColor = [UIColor clearColor];
    back.text = @"返回课程详情";
    back.font = [UIFont systemFontOfSize:14];
    back.textColor = [UIColor whiteColor];
    back.textAlignment = NSTextAlignmentCenter;
    [cancleButton addSubview:back];
   
    [cancleButton addTarget:self action:@selector(cancle)
           forControlEvents:UIControlEventTouchUpInside];
 
    
    [scroll addSubview:applyButton];
    [scroll addSubview:cancleButton];
   
}
/*
 * 报名成功 回到课程详情页面
 */

- (void)check{
     MyActivityViewController *moreVctr =[[MyActivityViewController alloc]init];
     moreVctr.style = LBClass;
    [self.navigationController pushViewController:moreVctr animated:YES];
}
- (void)cancle
{
    BaseViewController *viewController =
    (BaseViewController*)[self.navigationController.viewControllers objectAtIndex:1];
    [self.navigationController popToViewController:viewController animated:YES];
}
- (void)share

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
                                    UIView *view = [self.appDelegate.window.rootViewController.view viewWithTag:-123];
                                    
                                    [self.appDelegate.window.rootViewController.view bringSubviewToFront:view];
                                    [view removeFromSuperview];view = nil;
                                    //                                    UIView *addStatusBar = [[UIView alloc] init];
                                    //                                    addStatusBar.tag = -123;
                                    //                                    addStatusBar.frame = CGRectMake(0, 0, 320, 20);
                                    //                                    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
                                    //                                    addStatusBar.backgroundColor = [UIColor blackColor]; //change this to match your navigation bar
                                    //                                    [self.appDelegate.window.rootViewController.view addSubview:addStatusBar];
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
@end
