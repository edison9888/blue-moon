//
//  LoginViewController.m
//  tz_bluemoon_ios_iphone
//
//  Created by IceBoy on 14-1-9.
//  Copyright (c) 2014年 test. All rights reserved.
//

#import "LoginViewController.h"
#import "AKTabBarController.h"

#import "UIViewExt.h"
#import "HttpRequest.h"
#import "LGModelData.h"
@interface LoginViewController ()

@end

@implementation LoginViewController


-(id)initWithBlock:(MyBlock)block{
    self = [super init];
    if (self = [super init]) {
        self.title = @"登陆";
        self.valueBlock = block;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    



	UITextField *LoginName = [[UITextField alloc]initWithFrame:CGRectMake(50, 80, 220, 21)];
    UITextField *passWord  = [[UITextField alloc]initWithFrame:CGRectMake(50, 110, 220, 21)];
    LoginName.placeholder  = @"用户名";
    LoginName.borderStyle  = UITextBorderStyleLine;
    passWord.placeholder   = @"密码";
    passWord.borderStyle   = UITextBorderStyleLine;
    passWord.secureTextEntry = YES;//密码格式
    self.userNameField     = LoginName;
    self.passWordField     = passWord;
    
    LoginName.text = @"lceboy@163.com";
    passWord.text  = @"l15290330993b";
    
    [self.view addSubview:LoginName];
    [self.view addSubview:passWord];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginBtn.frame = CGRectMake(80,passWord.bottom+20, 80, 40);
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancleBtn.frame = CGRectMake(loginBtn.right, passWord.bottom+20, 80 ,40);
    [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [self.view addSubview:cancleBtn];
    
}
-(void)loginAction
{
    [self showHUDWithTitle:@"登录中"];
    [HttpRequest  LoginWithID:self.userNameField.text PassWord:self.passWordField.text Code:nil Finsh:^(id result) {
        [self performSelector:@selector(loginSucess:) withObject:result afterDelay:2];
    }];
    
    
}
- (void)loginSucess:(id)result
{
    
    [self removeHUD];
    NSLog(@"%@",result);
    if (!result) {
        [self showAlertWithTitle:@"警告" message:@"登陆失败"];
        self.appDelegate.login = YES;
        return;
    }else{
        //self.appDelegate.login = YES;
    }
    self.appDelegate.login = YES;
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(void)cancleAction
{
    [self.appDelegate.window.rootViewController dismissViewControllerAnimated:YES completion:NULL];
}

@end
