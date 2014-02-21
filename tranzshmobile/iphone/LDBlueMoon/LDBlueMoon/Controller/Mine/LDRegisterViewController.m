//
//  LDRegisterViewController.m
//  LDBlueMoon
//
//  Created by Lilac on 13-11-14.
//  Copyright (c) 2013年 tranzvision. All rights reserved.
//

#import "LDRegisterViewController.h"

#import "UITextField+AKNumericFormatter.h"
#import "AKNumericFormatter.h"

@interface LDRegisterViewController ()

@end

@implementation LDRegisterViewController

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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelRegistPressed)];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];

    UILabel *firstStepLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 63, 100, 30)];
    firstStepLabel.text = @"1 输入手机号";
    firstStepLabel.textColor = [UIColor redColor];
    firstStepLabel.font = [UIFont boldSystemFontOfSize:14.0];
    
    [self.view addSubview:firstStepLabel];
    
    UILabel *secondStepLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 63, 100, 30)];
    secondStepLabel.text = @"2 输入验证码";
    secondStepLabel.textColor = [UIColor darkGrayColor];
    secondStepLabel.font = [UIFont boldSystemFontOfSize:14.0];
    
    [self.view addSubview:secondStepLabel];
    
    UILabel *thirdStepLabel = [[UILabel alloc]initWithFrame:CGRectMake(220, 63, 100, 30)];
    thirdStepLabel.text = @"3 设置密码";
    thirdStepLabel.textColor = [UIColor darkGrayColor];
    thirdStepLabel.font = [UIFont boldSystemFontOfSize:14.0];
    
    [self.view addSubview:thirdStepLabel];
    
    UITextField *mobileTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, 280, 30)];
    mobileTextField.placeholder = @"请输入您的手机号码";
    mobileTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    mobileTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    mobileTextField.borderStyle = UITextBorderStyleBezel;
    mobileTextField.textAlignment = NSTextAlignmentLeft;
    mobileTextField.textColor = [UIColor darkGrayColor];
    mobileTextField.font = [UIFont boldSystemFontOfSize:15.0f];
    mobileTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    mobileTextField.keyboardType = UIKeyboardTypeNumberPad;
    mobileTextField.delegate = self;
    mobileTextField.numericFormatter = [AKNumericFormatter formatterWithMask:@"*** **** ****" placeholderCharacter:'*'];
    
    [self.view addSubview:mobileTextField];
    [mobileTextField becomeFirstResponder];
    
    UIButton *getVeriCodeBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 150, 280, 30)];
    [getVeriCodeBtn setBackgroundColor:[UIColor lightGrayColor]];
    [getVeriCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getVeriCodeBtn setTitle:@"获取验证码" forState:UIControlStateSelected];
    [getVeriCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [getVeriCodeBtn addTarget:self action:@selector(getVeriCodeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:getVeriCodeBtn];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
}

-(void)cancelRegistPressed
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)getVeriCodeBtnPressed
{
    LDRegist2ViewController *step2ViewController = [[LDRegist2ViewController alloc]init];
    [self.navigationController pushViewController:step2ViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
