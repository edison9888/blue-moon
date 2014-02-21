//
//  LDMyMainViewController.m
//  SinaLoginDemo
//
//  Created by vimfung on 13-8-18.
//  Copyright (c) 2013年 vimfung. All rights reserved.
//

#import "LDMyMainViewController.h"
#import "LDAppDelegate.h"



@interface LDMyMainViewController ()

@property (nonatomic,retain) UIButton *loginBtn;
@property (nonatomic,retain) UITableView *mainTableView;
@property (nonatomic,retain) NSArray *mainArray;
@property (nonatomic,retain) LDCalendarViewController *calendarViewController;

@end

@implementation LDMyMainViewController
@synthesize nameLabel;
@synthesize iconImageView;
@synthesize appDelegate;

@synthesize loginBtn;
@synthesize mainTableView;
@synthesize mainArray;
@synthesize calendarViewController;


- (NSString *)tabImageName
{
	return @"image-2";
}

- (NSString *)tabTitle
{
	return self.title;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"我的";
        // Custom initialization
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(loginButtonClickHandler)];
//        [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];

        appDelegate = [[UIApplication sharedApplication] delegate];

        loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 50, 100, 20)];
        [loginBtn setBackgroundColor:[UIColor grayColor]];
        [loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
        [loginBtn addTarget:self action:@selector(loginButtonClickHandler) forControlEvents:UIControlEventTouchUpInside];
        
        
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 200, 20)];
        nameLabel.text = @"当前用户为：";
        iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(230, 40, 50, 50)];
        
        
        mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 398) style:UITableViewStylePlain];
        mainArray = [[NSArray alloc]initWithObjects:@"我的课程安排",@"我的私教",@"已报名的活动",@"我教授的课程",nil];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = TRUE;

	// Do any additional setup after loading the view.
    
    mainTableView.delegate = self;
    mainTableView.dataSource = self;

    [self.view addSubview:mainTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    LDAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    if (appDelegate.loginStatus == 2) {
    
        NSString *filePath = [self baseDataFilePath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            
            // 使用归档方法持久化
            NSData *data = [[NSMutableData alloc] initWithContentsOfFile:[self baseDataFilePath]];
            NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
            
            LDBaseData *baseData = [unarchiver decodeObjectForKey:kBaseDataKey];
            [unarchiver finishDecoding];
            
//            NSLog(@"%@ %@ %d", baseData.tsNickname, baseData.tsIconURL,baseData.login);
            
            self.nameLabel.text = baseData.tsNickname;
            self.nameLabel.hidden = NO;
            self.iconImageView.hidden = NO;
            self.loginBtn.hidden = YES;
            [self setImageWithURL:[NSURL URLWithString:baseData.tsIconURL]];
            
            [self.mainTableView reloadData];
        }
    }
    else if(appDelegate.loginStatus == 0){
        NSString *filePath = [self baseDataFilePath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            
            // 使用归档方法持久化
            NSData *data = [[NSMutableData alloc] initWithContentsOfFile:[self baseDataFilePath]];
            NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
            
            LDBaseData *baseData = [unarchiver decodeObjectForKey:kBaseDataKey];
            [unarchiver finishDecoding];
            
            NSLog(@"%@ %@ %@", baseData.tsNickname, baseData.tsIconURL,baseData.login);
            
            if ([baseData.login integerValue] == 2) {
                self.nameLabel.text = baseData.tsNickname;
                self.nameLabel.hidden = NO;
                self.iconImageView.hidden = NO;
                self.loginBtn.hidden = YES;
                appDelegate.loginStatus = [baseData.login integerValue];
                [self setImageWithURL:[NSURL URLWithString:baseData.tsIconURL]];
            }
            [self.mainTableView reloadData];
        }else{
            self.nameLabel.hidden = YES;
            self.iconImageView.hidden = YES;
            self.loginBtn.hidden = NO;
        }
    }
    else{
        
        self.nameLabel.hidden = YES;
        self.iconImageView.hidden = YES;
        self.loginBtn.hidden = NO;
        [self.mainTableView reloadData];
    }
}
// End.

// Lilac: fix tabbar hidden bug. (1220)
// 在第一层添加如下两个方法，在第N(N!=1)层只添加ViewDidAppear
-(void)viewDidAppear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = NO;
}
// Lilac: end.(1220)

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginButtonClickHandler
{
    UIWindow* window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    window.backgroundColor = [UIColor clearColor];
    window.rootViewController = [[LDTempViewController alloc] init];
    self.iWindow = window;
    [window makeKeyAndVisible];
    
    LDMyLoginViewController *loginViewController = [[LDMyLoginViewController alloc]init];
    loginViewController.delegate = self;
    loginViewController.window = self.iWindow;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginViewController];
    
    [self.iWindow.rootViewController presentViewController:nav animated:YES completion:NULL];
}

#pragma mark Achive Methods

- (NSString *)baseDataFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:kBaseDataFileName];
}

#pragma mark LDThirdPartyLoginDelegate

-(void)getThirdPartyLoginInfo:(id<ISSUserInfo>) userInfo
{
    nameLabel.text = [NSString stringWithFormat:@"%@",[userInfo nickname]];
    
    NSLog(@"~~~~userInfo:%@,%@",[userInfo nickname],[userInfo icon]);
    
    [self setImageWithURL:[NSURL URLWithString:[userInfo icon]]];

}

- (void)setImageWithURL:(NSURL *)url
{
    ASIHTTPRequest *requestForIcon = [ASIHTTPRequest requestWithURL:url];
    [requestForIcon setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    
    [requestForIcon setDelegate:self];
    [requestForIcon setDidFinishSelector:@selector(requestForUserIconFinished:)];

    [requestForIcon startAsynchronous];
}

-(void)requestForUserIconFinished:(ASIHTTPRequest *)request
{
    if (request.responseStatusCode > 400) {
        
        NSLog(@"请求服务器时发生错误，错误代码：%d", request.responseStatusCode);
    }
	else if (request.responseStatusCode == 200) {
        iconImageView.image = [UIImage imageWithData:request.responseData];
    }
}


#pragma mark UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 4;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
//    LDAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {

        if (appDelegate.loginStatus == 2) {
            
            [cell.contentView addSubview:nameLabel];
            [cell.contentView addSubview:iconImageView];
        }
        else{
            [cell.contentView addSubview: loginBtn];
        }

        cell.accessoryType = UITableViewCellAccessoryNone;

    }
    else if(indexPath.section == 1)
    {
        cell.contentView.backgroundColor = [UIColor grayColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else{
        cell.textLabel.text = [mainArray objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100.0;
    }else if(indexPath.section == 1){
        return 50.0;
    }else{
        return 40.0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
//        LDAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
        if (self.appDelegate.loginStatus == 2) {
            LDMyInfoViewController *myinfoViewController = [[LDMyInfoViewController alloc]init];
            [myinfoViewController setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:myinfoViewController animated:NO];
        }
        else{
            
        }

    }
    if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
                calendarViewController = [[LDCalendarViewController alloc]init];
                [calendarViewController setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:calendarViewController animated:YES];
                break;
            case 1:
                
                break;
            case 2:
                
                break;
            case 3:
                
                break;
            default:
                break;
        }
    }

}

@end
