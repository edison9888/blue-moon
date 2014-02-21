

#import "PersonalDataViewController.h"
#import "LGModelData.h"
@interface PersonalDataViewController ()

@end

@implementation PersonalDataViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
-(void)dealloc{
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	UIScrollView *backgroundView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, KSCreen_Height )];
    
    UITapGestureRecognizer *tapGexture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wakeUp)];
    [backgroundView addGestureRecognizer:tapGexture];
    [self.view addSubview: backgroundView];
 
    [self initSubViews];
    
}
-(void)initSubViews{
    //昵称、性别、电话、年龄、地址、邮箱、
    
    float height = 0;

     _nickLabel  = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, 60,21)];
     _sexLable   = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, 60,21)];
     _ageLabel   = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 60,21)];
    _phoneLabel  = [[UILabel alloc]initWithFrame:CGRectMake(10, 130, 60,21)];
     _addrLabel  = [[UILabel alloc]initWithFrame:CGRectMake(10, 160, 60,21)];
     _mailLabel  = [[UILabel alloc]initWithFrame:CGRectMake(10, 190, 60,21)];
    
    _nickLabel.text  = @"昵称";
    _sexLable.text   = @"性别";
    _ageLabel.text   = @"年龄";
    _phoneLabel.text = @"手机";
    _addrLabel.text  = @"地址";
    _mailLabel.text  = @"邮箱";
    
    _nickField  = [[UITextField alloc]initWithFrame:CGRectMake(80, 40+height, 200, 21)];
    _sexField   = [[UITextField alloc]initWithFrame:CGRectMake(80, 70+height, 200, 21)];
    _ageField   = [[UITextField alloc]initWithFrame:CGRectMake(80, 100+height, 200,21)];
    _phoneField = [[UITextField alloc]initWithFrame:CGRectMake(80, 130+height, 200,21)];
    _addrField  = [[UITextField alloc]initWithFrame:CGRectMake(80, 160+height, 200,21)];
    _mailField  = [[UITextField alloc]initWithFrame:CGRectMake(80, 190+height, 200,21)];
    
//    _nickField.borderStyle  = UITextBorderStyleRoundedRect;
//    _sexField.borderStyle   = UITextBorderStyleRoundedRect;
//    _ageField.borderStyle   = UITextBorderStyleRoundedRect;
//    _phoneField.borderStyle = UITextBorderStyleRoundedRect;
//    _addrField.borderStyle  = UITextBorderStyleRoundedRect;
//    _mailField.borderStyle  = UITextBorderStyleRoundedRect;
    
    LGModelData *model = [LGModelData shareDataOfLogin];
    _nickField.text = model.nickName;
    
    if ([model.sex isEqualToString:@"m"]) {
        _sexField.text = @"男";
        
    }else{
        _sexField.text = @"女";
        
    }
    _ageField.text   = model.age;
    _addrField.text  = model.addr;
    _mailField.text  = model.mail;
    _phoneField.text = model.phoneNo;
    
    
    NSArray *items = @[_nickLabel,_nickField,_sexLable,_sexField,_ageLabel,_ageField,_phoneLabel,_phoneField,_addrLabel,_addrField,_mailLabel,_mailField];
    for (int i = 0; i<items.count; i++) {
        [self.view addSubview:items[i]];
        
    }
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIButton *saveBtn   = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancleBtn.frame     = CGRectMake(100,  230+height, 50, 30);
    saveBtn.frame       = CGRectMake(170, 230+height, 50, 30);
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.view addSubview:cancleBtn];
    [self.view addSubview:saveBtn];
    
}
//备用方法；
-(UITextField*)creatTextFieldWithFrame:(CGRect)frame{
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.delegate = self;
    return textField ;
    
}
-(void)wakeUp{
    for (id view in [self.view subviews]) {
        if ([view isKindOfClass:[UITextField class]]) {
            [view resignFirstResponder];
        }
    }
}


@end
