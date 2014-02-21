//
//  LDRegist3ViewController.m
//  LDBlueMoon
//
//  Created by Lilac on 13-11-29.
//  Copyright (c) 2013年 tranzvision. All rights reserved.
//

#import "LDRegist3ViewController.h"

@interface LDRegist3ViewController ()

@end

@implementation LDRegist3ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backRegistPressed)];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    
    UILabel *firstStepLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 63, 100, 30)];
    firstStepLabel.text = @"1 输入手机号";
    firstStepLabel.textColor = [UIColor darkGrayColor];
    firstStepLabel.font = [UIFont boldSystemFontOfSize:14.0];
    
    [self.view addSubview:firstStepLabel];
    
    UILabel *secondStepLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 63, 100, 30)];
    secondStepLabel.text = @"2 输入验证码";
    secondStepLabel.textColor = [UIColor darkGrayColor];
    secondStepLabel.font = [UIFont boldSystemFontOfSize:14.0];
    
    [self.view addSubview:secondStepLabel];
    
    UILabel *thirdStepLabel = [[UILabel alloc]initWithFrame:CGRectMake(220, 63, 100, 30)];
    thirdStepLabel.text = @"3 设置密码";
    thirdStepLabel.textColor = [UIColor redColor];
    thirdStepLabel.font = [UIFont boldSystemFontOfSize:14.0];
    
    [self.view addSubview:thirdStepLabel];
    
    UITextField *pwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, 280, 30)];
    pwdTextField.placeholder = @"设置密码：";
    pwdTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    pwdTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    pwdTextField.borderStyle = UITextBorderStyleBezel;
    pwdTextField.textAlignment = NSTextAlignmentLeft;
    pwdTextField.textColor = [UIColor darkGrayColor];
    pwdTextField.font = [UIFont boldSystemFontOfSize:15.0f];
    pwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    pwdTextField.keyboardType = UIKeyboardTypeDefault;
    pwdTextField.delegate = self;
    
    [self.view addSubview:pwdTextField];
    [pwdTextField becomeFirstResponder];
    
    
    UITextField *pwdVerTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 130, 280, 30)];
    pwdVerTextField.placeholder = @"确认密码：";
    pwdVerTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    pwdVerTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    pwdVerTextField.borderStyle = UITextBorderStyleBezel;
    pwdVerTextField.textAlignment = NSTextAlignmentLeft;
    pwdVerTextField.textColor = [UIColor darkGrayColor];
    pwdVerTextField.font = [UIFont boldSystemFontOfSize:15.0f];
    pwdVerTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    pwdVerTextField.keyboardType = UIKeyboardTypeDefault;
    pwdVerTextField.delegate = self;
    
    [self.view addSubview:pwdVerTextField];
    
    UIButton *registBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 180, 280, 30)];
    [registBtn setBackgroundColor:[UIColor lightGrayColor]];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setTitle:@"注册" forState:UIControlStateSelected];
    [registBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(registBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:registBtn];

}

-(void)backRegistPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)registBtnPressed
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
