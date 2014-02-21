//
//  LoginViewController.h
//  tz_bluemoon_ios_iphone
//
//  Created by IceBoy on 14-1-9.
//  Copyright (c) 2014年 test. All rights reserved.
//

#import "BaseViewController.h"
@class LGModelData;
typedef void (^MyBlock)(LGModelData *value);

@interface LoginViewController : BaseViewController
@property(nonatomic,strong)UITextField *userNameField;
@property(nonatomic,strong)UITextField *passWordField;
@property(nonatomic,strong)UIButton    *loginButton;
@property(nonatomic,strong)UIButton    *cancleButton;
@property(nonatomic,strong)MyBlock valueBlock;

-(id)initWithBlock:(MyBlock)block;
@end
