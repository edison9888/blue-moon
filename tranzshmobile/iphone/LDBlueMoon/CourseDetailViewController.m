
#import "CourseDetailViewController.h"
#import "SchoolDetailViewController.h"
#import "UIViewExt.h"
#import "BaseDataModel.h"
#import "LDMyLoginViewController.h"
#import "UIImageView+WebCache.h"
#import "BaseNavigationController.h"
#import "AddrMapViewController.h"
#import "TeacherViewController.h"
#import "ClassTableViewController.h"

#define HG_Mid 8
@interface CourseDetailViewController ()

@end

@implementation CourseDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"课程主页";
        self.imageName = @"http://10.10.1.202/users/appserver/images/1aa7fd7f4b84a09588f02a3c1d29ae2d?t[]=resize%3Awidth%3D280&accessToken=7f6e380304473a288ba126a7146fc8093cdd6738d4cf3e4cf1c650112e6d4f73";
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
 

  
    NSTimer *timer   =  [NSTimer scheduledTimerWithTimeInterval:1113.0 target:self selector:@selector(changeOffset:) userInfo:nil repeats:YES];
     self.myTimer    = timer;
     self.model      = [[ClassModel alloc]initWithData:nil];
    [self initSubViews];
    [self loadData];
  
	
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.myTimer invalidate];
}
-(void)initSubViews{

    //导航栏按钮
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 23, 23)];
    [rightButton addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton  setImage:[UIImage imageNamed:@"more_item.png"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    
//表头视图
    UIView *header    = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, KSCreen_Height)];
    self.headr_BGView = header;
    
    
//滚动控件
    UIScrollView *hscroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, 200)];
    self.headerScroll = hscroll;
    
    self.headerScroll.bounces       = NO;
    self.headerScroll.pagingEnabled = YES;
    self.headerScroll.delegate      = self;
    self.headerScroll.showsHorizontalScrollIndicator = NO;
    self.headerScroll.showsVerticalScrollIndicator   = NO;
    self.headerScroll.contentSize = CGSizeMake(KSCreen_Width*4, 200);
//页码控制器
    UIPageControl *pageC = [[UIPageControl alloc]initWithFrame:CGRectMake(110, 160, 100, 40)];
    pageC.numberOfPages  = 4;
    pageC.currentPage    = 0;
    pageC.pageIndicatorTintColor = [UIColor grayColor];
    pageC.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.headr_BGView addSubview:pageC];
    self.pageControl = pageC;
   //图片
    NSArray *images = @[self.imageName,self.imageName,self.imageName,self.imageName];
    for (int i = 0; i<4; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*320,0, KSCreen_Width, 200)];
        [imageView setImageWithURL:[NSURL URLWithString:images[i]]];
        [self.headerScroll addSubview:imageView];
        
    }
    
    [self.headr_BGView addSubview:self.headerScroll];
    //标题
    
    self.titleLable = [self  creatLableWithFrame:CGRectMake(10, self.headerScroll.bottom+10, 300, 24)
                                            Size:24
                                       TextColor:[UIColor blackColor]];
    [self.headr_BGView addSubview:self.titleLable];
    
    //副标题
    
    self.natureLable = [self creatLableWithFrame:CGRectMake(10, self.titleLable.bottom+5, 200, 20)
                                            Size:14
                                       TextColor:[UIColor grayColor]];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.natureLable.bottom+5, 320, .5)];
    lineView.backgroundColor =  [UIColor colorWithRed:197/255.0 green:198/255.0 blue:193/255.0 alpha:1];
    self.natureLable.text    = @"金牌教师亲自指导";
    [self.headr_BGView addSubview:self.natureLable];
    [self.headr_BGView addSubview:lineView];
    //人民币符号;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, lineView.bottom+14, 26, 26)];
    imageView.image = [UIImage imageNamed:@"￥1.png"];
    [self.headr_BGView addSubview:imageView];
    
    //价格
    self.nowPriceLable      = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right, lineView.bottom+5, 150, 40)];
    self.nowPriceLable.textColor = ThemeColor;
    self.nowPriceLable.backgroundColor = [UIColor clearColor];
    self.nowPriceLable.font            = [UIFont fontWithName:@"TimesNewRomanPS-BoldItalicMT" size:30];
    self.nowPriceLable.text = @"199";
    [self.headr_BGView addSubview:self.nowPriceLable];
    
    //报名
    UIButton *applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    applyButton.frame = CGRectMake(self.nowPriceLable.right+20, lineView.bottom+5, 100, 40);
    [applyButton setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
    [applyButton addTarget:self action:@selector(pushtoApplyPage) forControlEvents:UIControlEventTouchUpInside];
    [applyButton setImage:[UIImage imageNamed:@"signup_btn.png"] forState:UIControlStateNormal];
    [self.headr_BGView addSubview:applyButton];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
    [applyButton addSubview:lable];
    lable.textColor       = [UIColor whiteColor];
    lable.backgroundColor = [UIColor clearColor];
    lable.text = @"马上报名";
    lable.font = [UIFont systemFontOfSize:14];
    lable.textAlignment = NSTextAlignmentCenter;
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, self.nowPriceLable.bottom+5, 320, .5)];
    lineView2.backgroundColor =  [UIColor colorWithRed:197/255.0 green:198/255.0 blue:193/255.0 alpha:1];
    
    [self.headr_BGView addSubview:lineView2];
    //介绍
    NSString *detailContent = @"重点小学金牌教师绝密教案首次披露～！ 重点中学升学率高达90%～！重点小学金牌教师绝密教案首次披露～！ 重点中学升学率高达90%～！重点小学金牌教师绝密教案首次披露～！ 重点中学升学率高达90%～！";
    
    CGSize size = [detailContent sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(320, 2000) lineBreakMode:NSLineBreakByCharWrapping];

    
    self.detailLable = [ self creatLableWithFrame:CGRectMake(10, lineView2.bottom+5, KSCreen_Width-20, size.height) Size:14 TextColor:[UIColor grayColor]];
    self.detailLable.text = detailContent;
    self.detailLable.numberOfLines = 0;
    
    [self.headr_BGView addSubview:self.detailLable];
    
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moreButton.frame = CGRectMake(self.nowPriceLable.right+20, self.detailLable.bottom+5, 100, 20);

    moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [moreButton setAdjustsImageWhenHighlighted:NO];
    
    [moreButton setTitle:@"更多图文详情" forState:UIControlStateNormal];
    [moreButton setTitle:@"更多图文详情" forState:UIControlStateHighlighted];
    
    [moreButton setTitleColor:ThemeColor forState:UIControlStateNormal];
    [moreButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];


    
    [self.headr_BGView addSubview:moreButton];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, moreButton.bottom+5, KSCreen_Width, .5)];
    lineView3.backgroundColor = [UIColor colorWithRed:197/255.0 green:198/255.0 blue:193/255.0 alpha:1];
    [self.headr_BGView addSubview:lineView3];
    
    UIView *footer_BGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, 60)];
    UIView *lineView4 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, .5)];
    lineView4.backgroundColor =  [UIColor colorWithRed:197/255.0 green:198/255.0 blue:193/255.0 alpha:1];
    [footer_BGView addSubview:lineView4];
    
    
    //
    for (int i = 0; i<4; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10+(3+23)*i, 13, 23, 23)];
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView setImage:[UIImage imageNamed:@"course_star.png"]];
        if (i==3) {
            [imageView setImage:[UIImage imageNamed:@"halfstar.png"]];
       
        }
        [footer_BGView addSubview:imageView];
        
    }
    //
    UIView *lineView5 = [[UIView alloc]initWithFrame:CGRectMake(0, 50, KSCreen_Width, .5)];
    lineView5.backgroundColor = [UIColor colorWithRed:197/255.0 green:198/255.0 blue:193/255.0 alpha:1];
    [footer_BGView addSubview:lineView5];
    //
    UIImageView *identifierView = [[UIImageView alloc]initWithFrame:CGRectMake(KSCreen_Width - 14-10, 13, 14, 24)];
    identifierView.clipsToBounds = YES;
    identifierView.contentMode = UIViewContentModeScaleAspectFit;
    identifierView.image = [UIImage imageNamed:@"icon_cell_rightArrow.png"];
    [footer_BGView addSubview:identifierView];
    //
    UILabel *scoreLable = [[UILabel alloc]initWithFrame:CGRectMake(118+5, 15, 40, 20)];
    scoreLable.text = @"4.5分";
    scoreLable.textColor = [UIColor orangeColor];
    scoreLable.font = [UIFont systemFontOfSize:FitSize];
    [footer_BGView addSubview:scoreLable];
    //
    UILabel *numLable = [[UILabel alloc]initWithFrame:CGRectMake(scoreLable.right, 15, 90 , 20)];
    numLable.textColor = [UIColor grayColor];
    numLable.font = [UIFont systemFontOfSize:FitSize];
    numLable.textAlignment = NSTextAlignmentRight;
    numLable.text = @"77人评分";
    [footer_BGView addSubview:numLable];
    
    

//布局完成 ？有待修改（间隔 加  高度  ）
    float height = 200+10+24+5+20+5+2+5+40+20+5+5+size.height+5+5;
    header.height = height;
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, -KSCreen_Height, KSCreen_Width, KSCreen_Height)];
    backgroundView.backgroundColor = [UIColor colorWithRed:197/255.0 green:198/255.0 blue:193/255.0 alpha:1];
    
    
    UITableView *tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, KSCreen_Height-KNavBar_Height-KStatusBar_Height)];
    tableView.delegate      = self;
    tableView.dataSource    = self;
    [tableView addSubview:backgroundView];
 
   
    self.tableView = tableView;
    self.tableView.tableHeaderView = self.headr_BGView;
    [self.headr_BGView addSubview:pageC];
    self.tableView.tableFooterView = footer_BGView;
    [self.view addSubview:self.tableView];


    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
}
-(void)loadData
{
    
    self.titleLable.text    = self.detailModel.title;
    
    self.timeLable.text     = self.detailModel.time;
    
    self.addrLable.text     = self.model.addr;
    
    self.model_id = [self.detailModel.model_id intValue];
   

   
    
}
#pragma mark- Button  Action
-(void)pushToSchoolPage:(UIButton*)sender
{
    SchoolDetailViewController *istViewController = [[SchoolDetailViewController alloc]init];
    [self.navigationController pushViewController:istViewController animated:YES];
    
}

-(void)changeOffset:(NSTimer*)timer
{
    static int index = 1;
    if (index >3) {
        index = 0;
    }
    self.headerScroll.contentOffset = CGPointMake(KSCreen_Width*index, 0);
    index ++;
    
}

-(void)pushtoApplyPage
{
    ClassTableViewController *classTableVctr = [[ClassTableViewController alloc]init];
    [self.navigationController pushViewController:classTableVctr animated:YES];
}
#pragma mark- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 50;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        UIImageView *logoView  = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
        logoView.clipsToBounds = YES;
        logoView.layer.cornerRadius = 4;
        logoView.layer.masksToBounds = YES;
        logoView.contentMode   = UIViewContentModeScaleAspectFit;
        logoView.tag = 101;
        UIImageView *identifier  = [[UIImageView alloc]initWithFrame:CGRectMake(KSCreen_Width-14-10, 13, 14, 24)];
        identifier.clipsToBounds = YES;
        identifier.contentMode   = UIViewContentModeScaleAspectFit;
        identifier.image = [UIImage imageNamed:@"icon_cell_rightArrow.png"];
        
        UILabel *detailLable = [[UILabel alloc]initWithFrame:CGRectMake(logoView.right+5, 15, 150, 20)];
        detailLable.backgroundColor = [UIColor clearColor];
        detailLable.font = [UIFont systemFontOfSize:14];
        detailLable.tag  = 102;
        [cell.contentView addSubview:detailLable];
        [cell.contentView addSubview:logoView];
        [cell.contentView addSubview:identifier];
        
        
        
    }
    UIImageView *logoView = (UIImageView*)[cell.contentView viewWithTag:101];
    UILabel *detailLabe   = (UILabel*)[cell.contentView viewWithTag:102];
    if (indexPath.row == 0) {
        logoView.top    = 15;
        logoView.left   = 20;
        logoView.width  = 20;
        logoView.height = 20;
        logoView.image  = [UIImage imageNamed:@"location_btn.png"];
        detailLabe.text = @"上海市,安远路518号";
    }else if (indexPath.row == 1){
        logoView.image  = [UIImage imageNamed:@"actor.png"];
        detailLabe.text = @"格兰芬多学院";
    }else{
        logoView.image  = [UIImage imageNamed:@"actor.png"];
        detailLabe.text = @"麦格教授";
    }
    

    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        AddrMapViewController *mapViewVctr = [[AddrMapViewController alloc]init];
        [self.navigationController pushViewController:mapViewVctr animated:YES];
        mapViewVctr = nil;
        
    }else if (indexPath.row == 1){
        [self pushToSchoolPage:nil];
        
    }else{
        TeacherViewController *teacherVctr = [[TeacherViewController alloc]init];
        [self.navigationController pushViewController:teacherVctr animated:YES];
        
    }
    
    
}
#pragma mark- UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isMemberOfClass:[UIScrollView class]]) {
        int num = scrollView.contentOffset.x/KSCreen_Width;
       
        self.pageControl.currentPage = num;
    }else if([scrollView  isMemberOfClass:[UITableView class]]){

    }
    
}

#pragma mark- Tools Method
-(UILabel*)creatLableWithFrame:(CGRect)frame Size:(CGFloat)size TextColor:(UIColor*)color
{
    UILabel *lable  = [[UILabel alloc]initWithFrame:frame];
    lable.font      = [UIFont systemFontOfSize:size];
    lable.backgroundColor = [UIColor clearColor];
   
    lable.textColor = color;
    return lable ;
}
#pragma -mark ButtonAction--
- (void)changeItem:(UISegmentedControl*)sender
{
    int  index = sender.selectedSegmentIndex;
    if ((index == 1|| index == 2|| index == 3)&&self.appDelegate.login ==NO) {
        LDMyLoginViewController *loginVctr = [[LDMyLoginViewController alloc]initWithBlock:^(LGModelData *value) {
            NSLog(@"%@",value);
        }];
        BaseNavigationController *navCtr = [[BaseNavigationController alloc]initWithRootViewController:loginVctr];
        [self.appDelegate.window.rootViewController presentViewController:navCtr animated:YES completion:^{
            sender.selectedSegmentIndex = 0;
        }];
        return;
    }
    if (index == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (index == 1){
        [self showAlertWithTitle:nil message:@"关注成功"];
        self.appDelegate.atCLNum +=1;
        self.appDelegate.numat = self.model_id;
    }else if (index == 2){
        [self showAlertWithTitle:nil message:@"报名成功"];
        self.appDelegate.AplClNum +=1;
    }else if (index == 3){
        [self shareItemPressed:sender];
    }else if (index == 4){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
-(void) moreAction:(UIButton*)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"关注课程" otherButtonTitles:@"分享给朋友圈", nil];
    [sheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
        UIAlertView *alet = [[UIAlertView alloc]initWithTitle:@"" message:@"关注成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alet show];
        
    }else if (buttonIndex ==1){
        
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
          [self shareItemPressed:nil];
    }
  
}
- (void)shareItemPressed:(id)sender
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
