
#import "PersonPageViewController.h"
#import "UIImageView+WebCache.h"
#import "MyCouponViewController.h"
#import "MyActivityViewController.h"
#import "AuditionViewController.h"
#import "MyCalenderViewController.h"
#import "MyClassViewController.h"
#import "AttentionViewController.h"
#import "NotificationViewController.h"
#import "PersonalDataViewController.h"
#import "HomePageViewController.h"
#import "BaseNavigationController.h"
#import "LoginViewController.h"
#import "HttpRequest.h"
#define URL_Actor @"http://bluemoon/user/uploadavatar"
#define URL_Test @"http://c.hiphotos.baidu.com/image/w%3D2048/sign=9bb13131233fb80e0cd166d702e92e2e/0823dd54564e92584b51bbee9e82d158ccbf4e4c.jpg"

#import "UIViewExt.h"

#import "LDMyLoginViewController.h"



@interface PersonPageViewController ()

@end

@implementation PersonPageViewController


- (NSString *)tabImageName
{
	return @"icon_tabbar_mine";
}

- (NSString *)tabTitle
{
    
	return self.title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我的";
        //self.appDelegate.login = YES;
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(login:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    LGModelData *model = [LGModelData shareDataOfLogin];
    self.loginModel = model;
    
    [self initSubItems];
	
}
-(void)initSubItems{
    [self creatImageFilePath];
    NSArray *bt_names = @[@"关注",@"课程",@"日历",@"动态",@"优惠",@"通知"];
    self.dataSource   = bt_names;
//头
    _headerView                 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, 200)];
    _headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pro.png"]];
    _header.backgroundColor     = [UIColor blackColor];
    UIImageView *actorView      = [[UIImageView alloc]initWithFrame:CGRectMake(30, 80+15+50,60,60)];
    //判断是否登陆，如果登陆就。。。。。。
    if (!self.appDelegate.login) {
        actorView.image = [UIImage imageNamed:@"user_header_placeholder.png"];
    }else{
        [actorView setImageWithURL:[NSURL URLWithString:self.loginModel.actorUrl]];
    }
 
    actorView.userInteractionEnabled = YES;
    self.header  = actorView;
    
    UIButton *loginbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginbtn.tag = 303;
    [loginbtn setTitle:@"马上登陆" forState:UIControlStateNormal];
    [loginbtn setTitleColor:[UIColor colorWithRed:32/255.0 green:178/255.0 blue:170/255.0 alpha:1] forState:UIControlStateNormal];
    loginbtn.size = CGSizeMake(80, 30);
    loginbtn.center = _headerView.center;
    [loginbtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:loginbtn];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(loginbtn.left-40, loginbtn.top-30,200,20)];
    lable.text = @"您还木有登陆哦~";
    lable.tag = 202;
    lable.backgroundColor = [UIColor clearColor];
    lable.font = [UIFont systemFontOfSize:14];
    lable.textColor = [UIColor grayColor];
    [_headerView addSubview:lable];
    if (self.appDelegate.login) {
        loginbtn.hidden = YES;
        lable.hidden =YES;
    }
    //头像添加触摸事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeActorImage)];
    tapGesture.numberOfTapsRequired = 1;
    [self.header addGestureRecognizer:tapGesture];
   
    
    UILabel *nick  = [[UILabel alloc]initWithFrame:CGRectMake(100, 100+50, 200, 21)];
    self.nickLable = nick;
    nick.backgroundColor = [UIColor clearColor];
    nick.text = self.loginModel.nickName;
    
    UILabel *age  = [[UILabel alloc]initWithFrame:CGRectMake(100, 45+130, 200, 21)];
    age.backgroundColor = [UIColor clearColor];
    self.ageLable = age;
    self.ageLable.text = self.loginModel.age;
    
    UIButton *more = [UIButton buttonWithType:UIButtonTypeCustom];
    more.frame = CGRectMake(300, 35+130, 10, 10);
    [more setTitle:@"更多" forState:UIControlStateNormal];
    [more addTarget:self action:@selector(changeMyData) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:more];
    [_headerView addSubview:age];
    [_headerView addSubview:nick];
    [_headerView addSubview:actorView];
    [self.view addSubview:_headerView];
//button 
    for (int i = 0; i<2; i++) {
        for (int j = 0; j<3; j++) {
            static int index = 0;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(20+(80+30)*j, _headerView.bottom+10+(60+30)*i, 60, 60);
            button.layer.cornerRadius = 30;
            button.backgroundColor    = [UIColor colorWithRed:0/255 green:220.0/255 blue:161.0/255 alpha:1];
            button.highlighted = YES;
            //[button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button setTitle:self.dataSource[index] forState:UIControlStateNormal];
            button.tag = index+1;
            [button addTarget:self action:@selector(pushToDetail:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
            index ++;
        }
    }
 
    
}

- (void)creatImageFilePath{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [path objectAtIndex:0];
    //指定新建文件夹路径
    NSString *imageDocPath = [documentPath stringByAppendingPathComponent:@"ImageFile"];
    //创建ImageFile文件夹
    [[NSFileManager defaultManager] createDirectoryAtPath:imageDocPath withIntermediateDirectories:YES attributes:nil error:nil];
    //保存图片的路径
    self.imagePath = imageDocPath;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.hidesBottomBarWhenPushed = NO;
    if (self.appDelegate.login) {
        UIButton *button = (UIButton*)[_headerView viewWithTag:303];
        
        UILabel *lable  = (UILabel*)[_headerView viewWithTag:202];
        [button removeFromSuperview];
        [lable removeFromSuperview];
    }
}

#pragma UIActivity Delegate Method
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [self takePhoto];
    }else if(buttonIndex == 1){
        [self localPhoto];
    }else{
        [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
    }
}
#pragma TargetAction Method
//本地图库
- (void)localPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为图片库
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self.appDelegate.window.rootViewController presentViewController:picker animated:YES completion:NULL];
    
}
//照相
- (void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        //资源类型为照相机
        picker.sourceType = sourceType;
        [self.appDelegate.window.rootViewController presentViewController:picker animated:YES completion:NULL];
        
    }else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"未检测到摄像头" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
        
    }
}
//响应点击头像
- (void)changeActorImage
{
    if (self.appDelegate.login == NO) {
        [self login:nil];
        return;
    }
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从手机相册中选取", nil];
    [sheet showInView:self.view];
    
}
//更多个人信息
- (void)changeMyData
{
    if (!self.appDelegate.login) {
        [self login:nil];
        return;
    }
    PersonalDataViewController *myDataController = [[PersonalDataViewController alloc]init];
    [self.navigationController pushViewController:myDataController animated:YES];
    
}
#pragma mark- Buttonaction:
- (void)pushToDetail:(UIButton*)sender
{
    int button_tag = sender.tag;
    //判断是否登陆
    if (!self.appDelegate.login) {
        [self login:nil];
        return;
    }
    
    
    if (button_tag == 1) {
        HomePageViewController *myVctr = [[HomePageViewController alloc]init];
        myVctr.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myVctr animated:YES];
        
    }else if (button_tag == 2){
        MyActivityViewController *myVctr = [[MyActivityViewController alloc]init];
        [self.navigationController pushViewController:myVctr animated:YES];
        
    }else if (button_tag == 3){
        MyCalenderViewController *myVctr = [[MyCalenderViewController alloc]init];
        [self.navigationController pushViewController:myVctr animated:YES];
        
    }else if (button_tag == 4){
        AttentionViewController *myVctr = [[AttentionViewController alloc]init];
        [self.navigationController pushViewController:myVctr animated:YES];
        
    }else if (button_tag == 5){
        MyCouponViewController *myVctr = [[MyCouponViewController alloc]init];
        [self.navigationController pushViewController:myVctr animated:YES];
    
    }else if (button_tag == 6){
        NotificationViewController *myVctr = [[NotificationViewController alloc]init];
        [self.navigationController pushViewController:myVctr animated:YES];
        
    }

    
}
#pragma  UIImagePickerControllerDelegate Method

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
    {
       
    
        NSData *imageData = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 1.0);
        [self.header setImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
        
        NSString *baseurl = URL_Actor;
        NSURL *url = [NSURL URLWithString:baseurl];
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
        [urlRequest setHTTPMethod: @"POST"];

        [urlRequest setHTTPBody:imageData];
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
           
            
         //  NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
         
            
        }];

        [self.appDelegate.window.rootViewController dismissViewControllerAnimated:YES completion:NULL];
}
#pragma mark 从文档目录下获取Documents路径
- (NSString *)documentFolderPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}
//登陆
-(void)login:(id)sender
{

    if (self.appDelegate.login) {
        return;
    }
    
    LDMyLoginViewController *loginVC = [[LDMyLoginViewController alloc]initWithBlock:^(LGModelData *value) {
    
        self.nickLable.text = value.nickName;
        self.ageLable.text  = value.age;
        [self.header setImageWithURL:[NSURL URLWithString:value.actorUrl]];

        UIButton *button = (UIButton*)[_headerView viewWithTag:303];
        UILabel *lable  = (UILabel*)[_headerView viewWithTag:202];
        [button removeFromSuperview];
        [lable removeFromSuperview];
        
    }];
    BaseNavigationController *loginNav = [[BaseNavigationController alloc]initWithRootViewController:loginVC];
    [self.appDelegate.window.rootViewController presentViewController:loginNav animated:YES completion:NULL];
}

@end
