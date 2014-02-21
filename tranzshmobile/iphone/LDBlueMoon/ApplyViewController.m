

#import "ApplyViewController.h"
#import "ApplySucViewController.h"
#import "UIViewExt.h"
@interface ApplyViewController()

@end

@implementation ApplyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.title = @"报名";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowNotification:) name:UIKeyboardDidShowNotification object:nil];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidenNotification:) name:UIKeyboardWillHideNotification object:nil];

    return self;
}
-(void)keyboardShowNotification:(NSNotification*)notification
{

    [UIView animateWithDuration:.2 animations:^{
 
        self.view.top = -100;
    }];
}
//
-(void)keyboardHidenNotification:(NSNotification*)notification{
    [UIView animateWithDuration:.2 animations:^{
        UIView *view = (UIView*)[self.view  viewWithTag:101];
        view.alpha = 0;
        self.view.frame = CGRectMake(0,
                                     KNavBar_Height+KStatusBar_Height,
                                     KSCreen_Width,
                                     KSCreen_Height-KNavBar_Height-KStatusBar_Height);
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
 
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, KSCreen_Height-64)];
    scroll.contentSize = CGSizeMake(KSCreen_Width, KSCreen_Height-64);
    self.view =scroll;
    self.view.backgroundColor =  [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    [self initSubViews];
	
}
-(void)initSubViews
{
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, 72)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    UILabel *alertLable = [[UILabel alloc]initWithFrame:CGRectMake(26, 15, 200, 15)];
    alertLable.text = @"您要报名的课程是";
    alertLable.font = [UIFont systemFontOfSize:16];
    [backgroundView addSubview:alertLable];
    
    self.courseLable = [[UILabel alloc]initWithFrame:CGRectMake(26, alertLable.bottom+6, 180, 22)];
    self.courseLable.text = @"小学毕业班数学辅导班";
    CGSize size = [self.courseLable.text sizeWithFont:[UIFont boldSystemFontOfSize:18] constrainedToSize:CGSizeMake(180, 22) lineBreakMode:NSLineBreakByCharWrapping];
    NSLog(@"%f,%f",size.height,size.width);
    self.courseLable.width      = size.width;
    self.courseLable.height    = size.height;
    self.courseLable.textColor = [UIColor colorWithRed:41/255.0 green:172/255.0 blue:240/255.0 alpha:1];
    self.courseLable.font      = [UIFont boldSystemFontOfSize:18];
    _courseLable.lineBreakMode = NSLineBreakByCharWrapping;
    
    self.priceLable  = [[UILabel alloc]initWithFrame:CGRectMake(214, alertLable.bottom, 80, 30)];
    self.priceLable.text = @"￥199";
    
    self.priceLable.textAlignment = NSTextAlignmentRight;
    self.priceLable.textColor     =
    [UIColor colorWithRed:41/255.0 green:172/255.0 blue:240/255.0 alpha:1];
    self.priceLable.font = [UIFont fontWithName:@"TimesNewRomanPS-BoldItalicMT" size:20];
    
    [backgroundView addSubview:self.courseLable];
    [backgroundView addSubview:self.priceLable];
    //班级信息
    UILabel *classInfo = [[UILabel alloc]initWithFrame:CGRectMake(26, backgroundView.bottom+5, 100, 20)];
    classInfo.font = [UIFont systemFontOfSize:14];
     classInfo.text = @"班级信息";
    [self.view addSubview:classInfo];
    //班级信息组合控件
    UIView *cell = [[UIView alloc]initWithFrame:CGRectMake(0, classInfo.bottom+5, KSCreen_Width, 38)];
    cell.backgroundColor = [UIColor whiteColor];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(26, 9, 80, 20)];
    lable.text = @"上课班级";
    lable.font = [UIFont systemFontOfSize:14];
    lable.backgroundColor = [UIColor clearColor];
    UILabel *textField = [[UILabel alloc]initWithFrame:CGRectMake(lable.right+5, 4, 180, 30)];
    textField.text = @"精品小班一班";
    textField.font = [UIFont systemFontOfSize:14];
    textField.textColor = [UIColor grayColor];
    [cell addSubview:lable];
    [cell addSubview:textField];
    [self.view addSubview:cell];
    //个人信息
    UILabel *infoLable = [[UILabel alloc]initWithFrame:CGRectMake(26, cell.bottom+5, 100, 20)];
     infoLable.text = @"个人信息";
    infoLable.font = [UIFont systemFontOfSize:14];
    
    [self.view addSubview:backgroundView];
    [self.view addSubview:infoLable];
    
    //
    NSArray *array = @[@"姓名",@"电话",@"邮箱"];
    NSArray *hoders = @[@"填写报名人姓名",@"填写报名人电话",@"填写报名人邮箱"];
    for (int i = 0; i<3; i++) {
        UIView *cell = [[UIView alloc]initWithFrame:CGRectMake(0, infoLable.bottom+5+38*i, KSCreen_Width, 38)];
        cell.backgroundColor = [UIColor whiteColor];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(26, 9, 80, 20)];
        lable.text = [array objectAtIndex:i];
        lable.backgroundColor = [UIColor clearColor];
        lable.font = [UIFont systemFontOfSize:14];
        
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(lable.right+5, 4, 180, 30)];
        
        textField.delegate = self;
        textField.font = [UIFont systemFontOfSize:13];

        textField.placeholder =[hoders objectAtIndex:i];
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 37.5, KSCreen_Width, .5)];
        line.backgroundColor =  [UIColor colorWithRed:197/255.0 green:198/255.0 blue:193/255.0 alpha:1];
        [cell addSubview:line];
        [cell addSubview:lable];
        [cell addSubview:textField];
        [self.view addSubview:cell];
    }
    //

    
   
    //
    UIButton *applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    applyButton.frame = CGRectMake((KSCreen_Width-282)/2,infoLable.bottom+150, 282, 35);
    
    UILabel *apply = [[UILabel alloc]initWithFrame:CGRectMake(0, 7.5, 282, 20)];
    apply.backgroundColor = [UIColor clearColor];
    apply.text = @"立即报名";
    apply.font = [UIFont systemFontOfSize:14];
    apply.textColor = [UIColor whiteColor];
    apply.textAlignment = NSTextAlignmentCenter;
    [applyButton addSubview:apply];
 
    [applyButton addTarget:self action:@selector(apply) forControlEvents:UIControlEventTouchUpInside];
    [applyButton setImage:[UIImage imageNamed:@"signup_rn_btn.png"] forState:UIControlStateNormal];
    [applyButton setImage:[UIImage imageNamed:@"signup_rn_btn_pressed.png"] forState:UIControlStateHighlighted];
    
    
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.frame = CGRectMake((KSCreen_Width-282)/2, applyButton.bottom+10, 282, 35);
    
    UILabel *back = [[UILabel alloc]initWithFrame:CGRectMake(0, 7.5, 282, 20)];
    back.backgroundColor = [UIColor clearColor];
    back.text = @"取消报名";
    back.font = [UIFont systemFontOfSize:14];
    back.textColor = [UIColor whiteColor];
    back.textAlignment = NSTextAlignmentCenter;
    [cancleButton addSubview:back];
    
    [cancleButton addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [cancleButton setImage:[UIImage imageNamed:@"signup_cancel_btn.png"] forState:UIControlStateNormal];
    [self.view addSubview:applyButton];
    [self.view addSubview:cancleButton];
}


#pragma -mark UITextFiedDelegete

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    return YES;
}

#pragma -mark ButtonAction--
- (void)apply
{
    ApplySucViewController *sucessVctr = [[ApplySucViewController alloc]init];
    [self.navigationController pushViewController:sucessVctr animated:YES];
    sucessVctr = nil;
}


- (void)cancle
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
