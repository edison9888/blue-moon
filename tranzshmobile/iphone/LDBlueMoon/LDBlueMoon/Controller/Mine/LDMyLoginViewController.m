

#import "LDAppDelegate.h"
#import "WeiboSDK.h"
#import "LDMyMainViewController.h"
#import "LDMyLoginViewController.h"
#import "LDRegisterViewController.h"

#import "UITextField+AKNumericFormatter.h"
#import "AKNumericFormatter.h"
#import "LGModelData.h"
#import "HttpRequest.h"
@interface LDMyLoginViewController ()

@property TencentOAuth *_tencentOAuth;

@property (nonatomic,strong) UITextField *userTextField;
@property (nonatomic,strong) UITextField *pwdTextField;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) NSString *userStr;
@property (nonatomic,strong) NSString *pwdStr;

@end

@implementation LDMyLoginViewController
@synthesize userTextField;
@synthesize pwdTextField;
@synthesize loginBtn;
@synthesize delegate;
@synthesize mbProgress;
@synthesize appDelegate;


-(id)initWithBlock:(MyBlock)block
{
    self = [super init];
    if (self) {
        self.valueBlock = block;
        self.userTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, 280, 50)];
        self.pwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 148, 280, 50)];
        self.loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(60, 220, 200, 40)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"登录";

    self.view.backgroundColor = [UIColor whiteColor];
    appDelegate = [[UIApplication sharedApplication]delegate];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancleLoginPressed)];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStyleBordered target:self action:@selector(registPressed)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];


    self.userTextField.placeholder = @"手机号";
    self.userTextField.text = @"lceboy@163.com";
    self.userTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.userTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.userTextField.borderStyle = UITextBorderStyleBezel;
    self.userTextField.textAlignment = NSTextAlignmentLeft;
    self.userTextField.textColor = [UIColor darkGrayColor];
    self.userTextField.font = [UIFont boldSystemFontOfSize:17.0f];
    self.userTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.userTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.userTextField.delegate = self;
//    self.userTextField.numericFormatter = [AKNumericFormatter formatterWithMask:@"*** **** ****" placeholderCharacter:'*'];

    [self.view addSubview:userTextField];
    
    
    self.pwdTextField.placeholder = @"密码";

    self.pwdTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.pwdTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.pwdTextField.borderStyle = UITextBorderStyleBezel;
    self.pwdTextField.textAlignment = NSTextAlignmentLeft;
    self.pwdTextField.textColor = [UIColor darkGrayColor];
    self.pwdTextField.font = [UIFont boldSystemFontOfSize:17.0f];
    self.pwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pwdTextField.secureTextEntry = YES;
    self.pwdTextField.delegate = self;
    
    [self.view addSubview:pwdTextField];
    
    
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateSelected];
    self.loginBtn.backgroundColor = [UIColor lightGrayColor];
    [self.loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginBtn];
    
    
    UILabel *thirdLoginLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 300, 300, 30)];
    thirdLoginLabel.text = @"———第三方登录——————";
    [self.view addSubview:thirdLoginLabel];
    
    UIButton *wbButton = [[UIButton alloc]initWithFrame:CGRectMake(25, 335, 58, 58)];
    [wbButton setImage:[UIImage imageNamed:@"weibo_icon.png"] forState:UIControlStateNormal];
    [wbButton addTarget:self action:@selector(wbButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:wbButton];
    
    UIButton *qqButton = [[UIButton alloc]initWithFrame:CGRectMake(25 + 58 + 5, 335, 58, 58)];
    [qqButton setImage:[UIImage imageNamed:@"qq_icon.png"] forState:UIControlStateNormal];
    [qqButton addTarget:self action:@selector(qqButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:qqButton];
    
    UIButton *rrButton = [[UIButton alloc]initWithFrame:CGRectMake(25 + 58 + 5 + 58 + 5, 335, 58, 58)];
    [rrButton setImage:[UIImage imageNamed:@"renren_icon.png"] forState:UIControlStateNormal];
    [rrButton addTarget:self action:@selector(rrButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:rrButton];
    
    /* Lilac: Stored.
    NSNotificationCenter *notifCenter = [NSNotificationCenter defaultCenter];
    [notifCenter addObserver:self selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [notifCenter addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    */
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (appDelegate.loginStatus == 0) {
        
        NSString *filePath = [self baseDataFilePath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            
            // 使用归档方法持久化
            NSData *data = [[NSMutableData alloc] initWithContentsOfFile:[self baseDataFilePath]];
            NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
            
            LDBaseData *baseData = [unarchiver decodeObjectForKey:kBaseDataKey];
            [unarchiver finishDecoding];
            
            
            NSLog(@"%@ %@", baseData.account, baseData.password);
            
            if (baseData.rememberPassword == YES) {
                
//                self.nameLabel.text = baseData.account;
                
                //                [self requestForLoginPBC];
            }
            
        }
    }
    else if (appDelegate.loginStatus == 1) {
        
        // 使用归档方法持久化
        NSData *data = [[NSMutableData alloc] initWithContentsOfFile:[self baseDataFilePath]];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
        LDBaseData *baseData = [unarchiver decodeObjectForKey:kBaseDataKey];
        [unarchiver finishDecoding];
        
        // 登出时记录登出状态到本地, 下次登录不显示密码 start
        LDBaseData *logoutBaseData = [[LDBaseData alloc] init];
        
        logoutBaseData.account = baseData.account;
        logoutBaseData.password = baseData.password;
        logoutBaseData.rememberPassword = NO;
        
        logoutBaseData.tsName = baseData.tsName;
        logoutBaseData.tsClass = baseData.tsClass;
        logoutBaseData.tsNumber = baseData.tsNumber;
        
        NSMutableData *logoutData = [[NSMutableData alloc] init];
        NSKeyedArchiver *logoutArchiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:logoutData];
        
        [logoutArchiver encodeObject:logoutBaseData forKey:kBaseDataKey];
        [logoutArchiver finishEncoding];
        
        [logoutData writeToFile:[self baseDataFilePath] atomically:YES];
        //                BOOL success = [data writeToFile:[self baseDataFilePath] atomically:YES];
        //                success == YES ? NSLog(@"Success!") : NSLog(@"Failed!");
        
        // 登出时记录登出状态到本地, 下次登录不显示密码 end
        
//        self.nameLabel.text = baseData.account;
        
    }
}


-(void)loginBtnPressed:(id)sender
{
    [UIView beginAnimations:@"keyboardDisappear" context:NULL];
    
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    
    [UIView commitAnimations];
    [UIView setAnimationsEnabled:YES];
    
    if (mbProgress) {
        [mbProgress removeFromSuperview];
        self.mbProgress = nil;
    }
    
    mbProgress = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:mbProgress];
    [self.view bringSubviewToFront:mbProgress];
    //    mbProgress.delegate = self;
    mbProgress.labelText = @"登录中";
    [mbProgress show:YES];
    
    [self passwordCheck];
    
//    appDelegate.loginStatus = 2;
//    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)registPressed
{
    LDRegisterViewController *registerViewController = [[LDRegisterViewController alloc]init];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

-(void)cancleLoginPressed
{
    [self dismissViewControllerAnimated:YES completion:^{
        UIWindow* window = self.window;
        NSMutableArray* winArray = (NSMutableArray*)[[UIApplication sharedApplication] windows];
        [winArray removeObject:window];
        window.hidden = YES;
        
        NSMutableArray* nextArray = (NSMutableArray*)[[UIApplication sharedApplication] windows];
        UIWindow* win = nextArray[0];
        [win makeKeyWindow];
    }];
}

-(void)wbButtonPressed:(id)sender
{
//    LDAppDelegate *appDelegate = (LDAppDelegate *)[UIApplication sharedApplication].delegate;
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleModal
                                                          viewDelegate:nil
                                               authManagerViewDelegate:appDelegate.viewDelegate];

    //在授权页面中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                    nil]];

//    [ShareSDK ssoEnabled:YES];
    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo
                      authOptions:nil
                           result:^(BOOL result, id<ISSUserInfo> userInfo, id<ICMErrorInfo> error) {
                               if (result)
                               {
                                   if (userInfo) {
                                       
                                       appDelegate.loginStatus = 2;
                                       [self.delegate getThirdPartyLoginInfo:userInfo];
                                       
                                       [self saveLoginProfile:userInfo];
                                       [self dismissViewControllerAnimated:YES completion:^{
                                           UIWindow* window = self.window;
                                           NSMutableArray* winArray = (NSMutableArray*)[[UIApplication sharedApplication] windows];
                                           [winArray removeObject:window];
                                           window.hidden = YES;
                                           
                                           NSMutableArray* nextArray = (NSMutableArray*)[[UIApplication sharedApplication] windows];
                                           UIWindow* win = nextArray[0];
                                           [win makeKeyWindow];
                                       }];
                                       
                                   }
                               }

                           }];

}

-(void)saveLoginProfile:(id<ISSUserInfo>)userInfo
{
    NSString *filePath = [self baseDataFilePath];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {

        // 使用归档方法持久化
        LDBaseData *loginBaseData = [[LDBaseData alloc] init];
        loginBaseData.tsNickname = [userInfo nickname];
        loginBaseData.tsIconURL = [userInfo icon];
        loginBaseData.login = [NSNumber numberWithInteger:2];

        NSMutableData *loginData = [[NSMutableData alloc] init];
        NSKeyedArchiver *loginArchiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:loginData];
        
        [loginArchiver encodeObject:loginBaseData forKey:kBaseDataKey];
        [loginArchiver finishEncoding];
    
        [loginData writeToFile:filePath atomically:YES];
    
    NSLog(@"login data: %@, %@",loginBaseData.tsNickname,loginBaseData.login);

//    }
}

-(void)qqButtonPressed:(id)sender
{
//    LDAppDelegate *appDelegate = (LDAppDelegate *)[UIApplication sharedApplication].delegate;

    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleModal
                                                          viewDelegate:nil
                                               authManagerViewDelegate:appDelegate.viewDelegate];
    
    //在授权页面中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                    nil]];
    
    [ShareSDK getUserInfoWithType:ShareTypeQQSpace
                      authOptions:authOptions
                           result:^(BOOL result, id<ISSUserInfo> userInfo, id<ICMErrorInfo> error) {
                               if (result)
                               {
                                   appDelegate.loginStatus = 2;
                                   [self.delegate getThirdPartyLoginInfo:userInfo];
                                   [self dismissViewControllerAnimated:YES completion:NULL];
                               }
                               
                           }];

}

-(void)rrButtonPressed:(id)sender
{
//    LDAppDelegate *appDelegate = (LDAppDelegate *)[UIApplication sharedApplication].delegate;
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleModal
                                                          viewDelegate:nil
                                               authManagerViewDelegate:appDelegate.viewDelegate];
    
    //在授权页面中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                    nil]];
    
    [ShareSDK getUserInfoWithType:ShareTypeRenren
                      authOptions:authOptions
                           result:^(BOOL result, id<ISSUserInfo> userInfo, id<ICMErrorInfo> error) {
                               if (result)
                               {
                                   appDelegate.loginStatus = 2;
                                   [self.delegate getThirdPartyLoginInfo:userInfo];
                                   [self dismissViewControllerAnimated:YES completion:NULL];
                               }
                               
                           }];
    
}

#pragma mark -
#pragma mark Achive Methods

- (NSString *)baseDataFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:kBaseDataFileName];
}

#pragma mark net working

-(void)passwordCheck
{
    if ([appDelegate.reachability isReachable] == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"没有连接网络"
                                                        message:@"请检查网络后重新登录"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        
        [alert show];
        
        if (mbProgress) {
            [mbProgress removeFromSuperview];
            self.mbProgress = nil;
        }
    }
    else {
        //[self requestForLogin];
        [self loginAction];
    }
}
-(void)loginAction
{
//    //[self showHUDWithTitle:@"登录中"];
    [HttpRequest  LoginWithID:self.userTextField.text PassWord:self.pwdTextField.text Code:nil Finsh:^(id result) {
        [self performSelector:@selector(loginSucess:) withObject:result afterDelay:2];
    }];
     //[self performSelector:@selector(loginSucess:) withObject:nil afterDelay:2];
    
}
- (void)loginSucess:(id)result
{
    if (mbProgress) {
        [mbProgress removeFromSuperview];
        self.mbProgress = nil;
    }

    NSLog(@"%@",result);
    if (!result) {
        
        return;
    }else{
        self.appDelegate.login = YES;
    }
    //self.appDelegate.login = YES;
    id data = [result objectForKey:@"loginedUser"];
    if(_valueBlock)
    {
        LGModelData *loginData = [LGModelData shareDataOfLogin];
        loginData.nickName     = [data objectForKey:@"nickName"];
        loginData.mail         = [data objectForKey:@"email"];
        loginData.phoneNo      = [data objectForKey:@"telephone"];
        loginData.sex          = [data objectForKey:@"gender"];
        loginData.addr         = [data objectForKey:@"city"];
        loginData.age          = [data objectForKey:@"strBirth"];
        loginData.actorUrl     = [data objectForKey:@"portraitUrl"];
        
        
        _valueBlock(loginData);
    }
    
    
    [self.appDelegate.window.rootViewController dismissViewControllerAnimated:YES completion:NULL];
}
-(void)requestForLogin
{
    
#ifdef PRO_LD
    NSURL *url = [NSURL URLWithString:PBC_LOGIN_URL_PRO];
#endif
    
#ifdef DEV_LD
    NSURL *url = [NSURL URLWithString:PBC_LOGIN_URL_DEV];
#endif
    
    ASIFormDataRequest *requestForLogin = [ASIFormDataRequest requestWithURL:url];

    [requestForLogin addPostValue:userTextField.text forKey:@"username"];
    [requestForLogin addPostValue:pwdTextField.text forKey:@"password"];
    [requestForLogin addPostValue:RED_RECT_URL forKey:@"redRectUrl"];
    
    [requestForLogin setDelegate:self];
    
    requestForLogin.timeOutSeconds = TIMEOUT_SECONDS;
    
    [requestForLogin setDidFinishSelector:@selector(requestForLoginFinished:)];
    [requestForLogin setDidFailSelector:@selector(requestForLoginFailed:)];
	[requestForLogin startAsynchronous];
}

-(void)requestForLoginFinished:(ASIHTTPRequest *)request
{
    if ([[request responseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length < 10) {
        
        if (mbProgress) {
            mbProgress.labelText = @"服务器返回的数据有误";
            [mbProgress hide:YES afterDelay:0.81f];
            self.mbProgress = nil;
        }
        return;
    }
    
    if (request.responseStatusCode > 400) {
        
        if (mbProgress) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请求服务器时发生错误！"
                                                            message:[NSString stringWithFormat:@"错误代码：%d", request.responseStatusCode]
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }
        if (mbProgress) {
            
            [mbProgress hide:YES afterDelay:0.81f];
            self.mbProgress = nil;
        }
        
        if (mbProgress) {
            [mbProgress removeFromSuperview];
            self.mbProgress = nil;
        }
    }
	else if (request.responseStatusCode == 200) {
        
        NSLog(@"login back data -----> %@", [request responseString]);
        
        NSDictionary *dictionary = [[request responseString] objectFromJSONString];
        
        NSString *loginReturnValue = [dictionary objectForKey:@"returnValue"];
        
        if ([loginReturnValue isEqualToString:@"login successfully"]) {
            
            LDBaseData *baseDataFromLocal = nil;
            NSString *filePath = [self baseDataFilePath];
            if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
                
                // 使用归档方法持久化
                NSData *data = [[NSMutableData alloc] initWithContentsOfFile:[self baseDataFilePath]];
                NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
                
                baseDataFromLocal = [unarchiver decodeObjectForKey:kBaseDataKey];
                [unarchiver finishDecoding];

            }
            
            LDBaseData *baseData = [[LDBaseData alloc] init];
            baseData.account = userTextField.text;
            baseData.password = pwdTextField.text;
            
            NSMutableData *data = [[NSMutableData alloc] init];
            NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
            
            [archiver encodeObject:baseData forKey:kBaseDataKey];
            [archiver finishEncoding];
            
            [data writeToFile:[self baseDataFilePath] atomically:YES];
        
            [self login];
            
        }
        else if ([loginReturnValue isEqualToString:@"permission denied"]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"帐号权限不足！"
                                                            message:@"尊敬的用户您的权限不足"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            
            if (mbProgress) {
                
                [mbProgress hide:YES afterDelay:0.81f];
                self.mbProgress = nil;
            }
            
            if (mbProgress) {
                [mbProgress removeFromSuperview];
                self.mbProgress = nil;
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败！"
                                                            message:@"帐号或密码错误"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            
            if (mbProgress) {
                
                [mbProgress hide:YES afterDelay:0.81f];
                self.mbProgress = nil;
            }
            
            if (mbProgress) {
                [mbProgress removeFromSuperview];
                self.mbProgress = nil;
            }
            
        }
    }
	else {
        
        if (mbProgress) {
            
            mbProgress.labelText = [NSString stringWithFormat:@"未知错误，错误代码%d", request.responseStatusCode];
        }
        
        if (mbProgress) {
            
            [mbProgress hide:YES afterDelay:0.81f];
            self.mbProgress = nil;
        }
        
        if (mbProgress) {
            [mbProgress removeFromSuperview];
            self.mbProgress = nil;
        }
    }
    
}

-(void)requestForLoginFailed:(ASIHTTPRequest *)request
{
    if (mbProgress) {
        mbProgress.labelText = @"请求超时，请检查网络";
        [mbProgress hide:YES afterDelay:0.81f];
        self.mbProgress = nil;
    }
}

-(void)login
{
    appDelegate.loginStatus = 2;
    
    [self dismissViewControllerAnimated:YES completion:^{
        UIWindow* window = self.window;
        NSMutableArray* winArray = (NSMutableArray*)[[UIApplication sharedApplication] windows];
        [winArray removeObject:window];
        window.hidden = YES;
        
        NSMutableArray* nextArray = (NSMutableArray*)[[UIApplication sharedApplication] windows];
        UIWindow* win = nextArray[0];
        [win makeKeyWindow];
    }];
}

#pragma mark - UITextFieldAnimation Methods
/* Lilac: Stored.
 
- (void)handleKeyboardWillShow:(NSNotification *)paramNotification
{
    [UIView beginAnimations:@"keyboardAppear" context:NULL];
    
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    
// 获得键盘弹出的时间 以后可以用
//    NSTimeInterval animationDuration = [[[paramNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 获得键盘高度
    CGRect keyboardRect = [[[paramNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    self.view.center = CGPointMake(self.view.frame.size.width/2, keyboardRect.size.width - 99);
    
    [UIView commitAnimations];
    [UIView setAnimationsEnabled:YES];
}

- (void)handleKeyboardWillHide:(NSNotification *)paramNotification
{
    [UIView beginAnimations:@"keyboardDisappear" context:NULL];
    
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    
    self.view.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    
    [UIView commitAnimations];
    [UIView setAnimationsEnabled:YES];
}
*/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([userTextField isFirstResponder] == YES) {
        [userTextField resignFirstResponder];
    }
    
    if ([pwdTextField isFirstResponder] == YES) {
        [pwdTextField resignFirstResponder];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

@end
