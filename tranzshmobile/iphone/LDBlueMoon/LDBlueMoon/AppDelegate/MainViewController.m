//
//  MainViewController.m
//  LDBlueMoon
//
//  Created by IceBoy on 14-1-24.
//  Copyright (c) 2014年 tranzvision. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "LDTutorViewController.h"
#import "PersonPageViewController.h"
#import "LDMoreViewController.h"
#import "BaseNavigationController.h"

@interface MainViewController ()

@property(nonatomic,strong)HomeViewController *homeViewController;

@property(nonatomic,strong)LDTutorViewController *tutorViewController;
@property(nonatomic,strong)PersonPageViewController *personViewController;
@property(nonatomic,strong)LDMoreViewController *moreViewController;


@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initSubVctrs];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(void)initSubVctrs
{
   
    //首页
    _homeViewController          = [[HomeViewController alloc]init];
    BaseNavigationController *nav1 = [[BaseNavigationController alloc]initWithRootViewController:_homeViewController];
    

    //活动
    _tutorViewController           = [[LDTutorViewController alloc]init];
    BaseNavigationController *nav2 = [[BaseNavigationController alloc]initWithRootViewController:_tutorViewController];
    
    //我的
    _personViewController          =[[PersonPageViewController alloc]init];
    BaseNavigationController *nav3 = [[BaseNavigationController alloc]initWithRootViewController:_personViewController];
    
    //更多
    _moreViewController            = [[LDMoreViewController alloc]init];
    BaseNavigationController *nav4 = [[BaseNavigationController alloc]initWithRootViewController:_moreViewController];
    NSArray *viewControllers       = @[nav1,nav2,nav3,nav4];
    
    [self setViewControllers:(NSMutableArray*)viewControllers];
}     
@end
