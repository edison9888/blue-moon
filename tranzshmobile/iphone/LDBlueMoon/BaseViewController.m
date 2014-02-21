

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self isShowBackButtonItem];
	
}
/*
 * 重载设置控制器Title方法
 */
-(void)setTitle:(NSString *)title
{
    [super setTitle:title];
     UILabel *titleLable        = [[UILabel alloc]initWithFrame:CGRectZero];
     titleLable.font            = [UIFont boldSystemFontOfSize:20.0f];
     titleLable.backgroundColor = [UIColor clearColor];
     titleLable.textColor = [UIColor whiteColor];
     titleLable.text            = title;
     [titleLable sizeToFit];
    self.navigationItem.titleView = titleLable ;
    
}

/*
 * 获取AppDelegate
 */
-(LDAppDelegate*)appDelegate
{
    return  [[UIApplication sharedApplication] delegate];
}

/*
 *警告视图
 */
-(void)showAlertWithTitle:(NSString*)title message:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message
                                                  delegate:self
                                         cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert show];
    
}
/*
 *没有网络警告
 */
-(void)showNoNetWork
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络故障" message:@"找不到网络,稍后重试"
                                                  delegate:self
                                         cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}
/*
 *  为控制器添加返回按钮
 */
- (void)showBackButtonItem
{

        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"btn_backItem.png"] forState:UIControlStateNormal];
         backButton.frame     = CGRectMake(0, 0, 24, 24);
         backButton.showsTouchWhenHighlighted = YES;
        [backButton addTarget:self action:@selector(popNavigation) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = back;

}
/*
 *  自动为控制器添加返回按钮
 */
- (void)isShowBackButtonItem
{
    NSArray *viewControllers = self.navigationController.viewControllers;
    
    if (viewControllers.count > 1) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"btn_backItem.png"] forState:UIControlStateNormal];
        backButton.frame     = CGRectMake(0, 0, 24, 24);
        backButton.showsTouchWhenHighlighted = YES;
        [backButton addTarget:self action:@selector(popNavigation) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = back;
        
        
    }
    
}
- (void)popNavigation
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 *   风火轮
 */
- (void)showHUDWithTitle:(NSString*)title
{
    _progressHUD = [[MBProgressHUD alloc]initWithWindow:self.appDelegate.window];
    [_progressHUD show:YES];
    _progressHUD.labelText = title;
    [self.appDelegate.window addSubview:_progressHUD];
    
}
- (void)removeHUD
{
    if (_progressHUD!=nil) {
        [_progressHUD removeFromSuperview];
        _progressHUD = nil;
    }else{
        
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

@end
