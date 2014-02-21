
#import "ActivityDetailViewController.h"
#import "UIViewExt.h"



#import "MyActivityViewController.h"
#import "LDMapViewController.h"
#import "HomePageViewController.h"
#import "SchoolDetailViewController.h"
#import "UserTableViewController.h"
#import "MyActivityViewController.h"
#import "LDMyLoginViewController.h"
@interface ActivityDetailViewController ()

@end

@implementation ActivityDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"活动详细";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self initSubViews];

}
-(void)initSubViews
{
    UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
    float height = 0;
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, 200)];
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.contentSize = CGSizeMake(320*3, 200);
    [tableHeaderView addSubview:scrollView];
    
    NSArray *imageNames = @[self.imageName,self.imageName,self.imageName];
    for (int i = 0; i<3; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(320*i, 0, 320, 200)];
        [imageView setImage:[UIImage imageNamed:imageNames[i]]];
        [scrollView addSubview:imageView];
    }
    
    height += 200;
    _headerView = [[UIImageView alloc]initWithFrame:CGRectZero];
    UILabel *titleLable  = [[UILabel alloc]initWithFrame:CGRectMake(10, scrollView.bottom+5, 40, 20)];
    titleLable.text = @"主题:";
    [tableHeaderView addSubview:titleLable];
    UILabel *addrLable  = [[UILabel alloc]initWithFrame:CGRectMake(10, titleLable.bottom+5, 40, 20)];
    addrLable.text = @"地址:";
    [tableHeaderView addSubview:addrLable];
    UILabel *timeLable  = [[UILabel alloc]initWithFrame:CGRectMake(10, addrLable.bottom+5, 40, 20)];
    timeLable.text = @"时间:";
    [tableHeaderView addSubview:timeLable];
    UILabel *numLable  = [[UILabel alloc]initWithFrame:CGRectMake(10, timeLable.bottom+5, 40, 20)];
    numLable.text  = @"人数:";
    [tableHeaderView addSubview:numLable];
    UILabel *hostLabel  = [[UILabel alloc]initWithFrame:CGRectMake(10, numLable.bottom+5, 200, 20)];
    hostLabel.text = @"机构:";
    [tableHeaderView addSubview:hostLabel];
    height += 25*5+10;
    
    
    //活动主题
    _titleLable       = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _titleLable.tag   = 1;
 
    _titleLable.frame = CGRectMake(titleLable.right, scrollView.bottom+5, 200, 20);
    [_titleLable setTitle:self.model.title forState:UIControlStateNormal];
    [_titleLable setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [tableHeaderView addSubview:_titleLable];
  
    //地址
    _addrLable       = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _addrLable.tag   = 2;
    _addrLable.frame = CGRectMake(addrLable.right, _titleLable.bottom+5, 200, 20);
    [_addrLable setTitle:self.model.addr forState:UIControlStateNormal];
    [_addrLable addTarget:self action:@selector(pushTo:) forControlEvents:UIControlEventTouchUpInside];
    [tableHeaderView addSubview:_addrLable];
    
    //时间
    _timeLable               = [[UILabel alloc]initWithFrame:CGRectMake(titleLable.right, _addrLable.bottom+5, 200, 20)];
    _timeLable.text          = self.model.time;
    _timeLable.textAlignment = NSTextAlignmentCenter;
    [tableHeaderView addSubview:_timeLable];
    
    //人数
    _numLable       = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _numLable.tag   = 3;
    _numLable.frame = CGRectMake(titleLable.right, _timeLable.bottom+5, 200, 20);
    [_numLable setTitle:@"0" forState:UIControlStateNormal];
    [_numLable addTarget:self action:@selector(pushTo:) forControlEvents:UIControlEventTouchUpInside];
    [tableHeaderView addSubview:_numLable];
    
    //机构
    _hostLabel       = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _hostLabel.tag   = 4;
    _hostLabel.frame = CGRectMake(titleLable.right, _numLable.bottom+5, 200, 20);
    [_hostLabel setTitle:self.model.host forState:UIControlStateNormal];
    [_hostLabel addTarget:self action:@selector(pushTo:) forControlEvents:UIControlEventTouchUpInside];
    [tableHeaderView addSubview:_hostLabel];
    
    UILabel *itLable  = [[UILabel alloc]initWithFrame:CGRectMake(0, _hostLabel.bottom+5, 320, 20)];
    itLable.backgroundColor = [UIColor colorWithRed:32.0/255 green:178.0/255 blue:170.0/255 alpha:1];
    itLable.text = @"活动详情";
    
    height+=25;
    UILabel *detailLable = [[UILabel alloc]initWithFrame:CGRectZero];
    NSString *detail     = self.model.introduce;
    detailLable.text     = detail;
    detailLable.numberOfLines = 0;
    detailLable.font   = [UIFont systemFontOfSize:15];
    CGSize size        = [detail sizeWithFont:[UIFont systemFontOfSize:17.0] constrainedToSize:CGSizeMake(320, 2000) lineBreakMode:NSLineBreakByCharWrapping];
    detailLable.frame  =  CGRectMake(10, itLable.bottom+5, 300, size.height);
    [tableHeaderView addSubview:detailLable];
    [tableHeaderView addSubview:itLable];
    height += 5+size.height;

  
    //评价列表
    tableHeaderView.frame = CGRectMake(0, 0, KSCreen_Width, height+10);
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, KSCreen_Height-44-20)];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = tableHeaderView;
    [self.view addSubview:_tableView];
    
    NSArray *arr = @[@"返回",@"报名",@"关注",@"分享",@"首页"];
    UISegmentedControl *view = [[UISegmentedControl alloc]initWithItems:arr];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, KSCreen_Height-KNavBar_Height-KStatusBar_Height-KTabBar_Height, KSCreen_Width, KTabBar_Height);
    [view addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:view];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.text = @"评价（0）";
 
    return cell;
}
-(void)pushTo:(UIButton*)sender
{
    int index  = sender.tag ;
    if (index == 1) {
        MyActivityViewController *activity = [[MyActivityViewController alloc]init];
        activity.style = LBActivity;
        
        [self.navigationController pushViewController:activity animated:YES];
        
    }else if (index == 2){
        LDMapViewController *mapVC = [[LDMapViewController alloc]init];
        mapVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mapVC animated:YES];
    }else if (index == 3){
        UserTableViewController *userTableView = [[UserTableViewController alloc]init];
        [self.navigationController pushViewController:userTableView animated:YES];
    }else if (index == 4){
        SchoolDetailViewController *schoolVctr = [[SchoolDetailViewController alloc]init];
        [self.navigationController pushViewController:schoolVctr animated:YES];
        
    }
}
- (void)valueChange:(UISegmentedControl*)seg
{
    int index = seg.selectedSegmentIndex;
    if (!self.appDelegate.login&&(index ==1||index ==2 ||index==3)) {
        LDMyLoginViewController *loginVCtr = [[LDMyLoginViewController alloc]initWithBlock:^(LGModelData *value) {
            
        }];
        UINavigationController *navigationVctr = [[UINavigationController alloc]initWithRootViewController:loginVCtr];
        [self.appDelegate.window.rootViewController presentViewController:navigationVctr animated:YES completion:^{
            
            seg.selectedSegmentIndex = 0;
        }];
        
        return;
    }
    switch (index) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1:
            [self showAlertWithTitle:@"" message:@"报名成功"];
//            self.appDelegate.AplACNum+=1;
            break;
        case 2:
            [self showAlertWithTitle:@"" message:@"关注成功"];
            self.appDelegate.atACNum  += 1;
            self.appDelegate.imageName = self.imageName;
            self.appDelegate.model     = self.model;
           
            break;
        case 3:
            [self  shareItemPressed:nil];
            break;
            
        default:
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
    }
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
                                    UIView *view = [self.appDelegate.window.rootViewController.view viewWithTag:-123];
                                    [self.appDelegate.window.rootViewController.view bringSubviewToFront:view];
                                    [view removeFromSuperview];view = nil;
                                    UIView *addStatusBar = [[UIView alloc] init];
                                    addStatusBar.tag = -123;
                                    addStatusBar.frame = CGRectMake(0, 0, 320, 20);
                                    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
                                    addStatusBar.backgroundColor = [UIColor blackColor]; //change this to match your navigation bar
                                    [self.appDelegate.window.rootViewController.view addSubview:addStatusBar];
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
