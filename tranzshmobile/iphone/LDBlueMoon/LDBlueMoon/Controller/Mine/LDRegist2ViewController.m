//
//  LDRegist2ViewController.m
//  LDBlueMoon
//
//  Created by Lilac on 13-11-29.
//  Copyright (c) 2013年 tranzvision. All rights reserved.
//

#import "LDRegist2ViewController.h"

@interface LDRegist2ViewController ()

@end

@implementation LDRegist2ViewController

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
    secondStepLabel.textColor = [UIColor redColor];
    secondStepLabel.font = [UIFont boldSystemFontOfSize:14.0];
    
    [self.view addSubview:secondStepLabel];
    
    UILabel *thirdStepLabel = [[UILabel alloc]initWithFrame:CGRectMake(220, 63, 100, 30)];
    thirdStepLabel.text = @"3 设置密码";
    thirdStepLabel.textColor = [UIColor darkGrayColor];
    thirdStepLabel.font = [UIFont boldSystemFontOfSize:14.0];
    
    [self.view addSubview:thirdStepLabel];
    
    UITextField *veriTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, 280, 30)];
    veriTextField.placeholder = @"请输入短信中的验证码";
    veriTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    veriTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    veriTextField.borderStyle = UITextBorderStyleBezel;
    veriTextField.textAlignment = NSTextAlignmentLeft;
    veriTextField.textColor = [UIColor darkGrayColor];
    veriTextField.font = [UIFont boldSystemFontOfSize:15.0f];
    veriTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    veriTextField.keyboardType = UIKeyboardTypeNumberPad;
    veriTextField.delegate = self;
    
    [self.view addSubview:veriTextField];
    [veriTextField becomeFirstResponder];
    
    UIButton *handVeriCodeBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 150, 280, 30)];
    [handVeriCodeBtn setBackgroundColor:[UIColor lightGrayColor]];
    [handVeriCodeBtn setTitle:@"提交验证码" forState:UIControlStateNormal];
    [handVeriCodeBtn setTitle:@"提交验证码" forState:UIControlStateSelected];
    [handVeriCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [handVeriCodeBtn addTarget:self action:@selector(handVeriCodeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:handVeriCodeBtn];

}

-(void)backRegistPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)handVeriCodeBtnPressed
{
    LDRegist3ViewController *step3ViewController = [[LDRegist3ViewController alloc]init];
    [self.navigationController pushViewController:step3ViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
