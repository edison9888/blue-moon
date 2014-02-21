//
//  LDCalendarViewController.m
//  LDBlueMoon
//
//  Created by Lilac on 13-11-22.
//  Copyright (c) 2013年 tranzvision. All rights reserved.
//

#import "LDCalendarViewController.h"

@interface LDCalendarViewController ()

@end

@implementation LDCalendarViewController
//@synthesize monthViewController;


- (id)init{
    self = [super init];
    if (self) {
        // Custom initialization
        self.title = @"课程安排";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< 我的" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
        [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    
//    monthViewController = [[KalViewController alloc] init];
//    monthViewController.view.frame = CGRectMake(0, 64, 320, 480);
//    monthViewController.view.backgroundColor = [UIColor clearColor];
//	dataSource = [[EventKitDataSource alloc] init];
//	monthViewController.dataSource = dataSource;
//	monthViewController.rootViewController = self;
//    CalendarDetailViewController *detailsViewController = [[CalendarDetailViewController alloc] initWithStyle:UITableViewStylePlain];
//	monthVC.detailsViewController = detailsViewController;
    
  //  [self.view addSubview:monthViewController.view];
    
}

-(void)back:(id)sender
{
     [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
