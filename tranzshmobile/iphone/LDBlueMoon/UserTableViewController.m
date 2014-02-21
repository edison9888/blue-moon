//
//  UserTableViewController.m
//  LDBlueMoon
//
//  Created by IceBoy on 14-1-20.
//  Copyright (c) 2014年 tranzvision. All rights reserved.
//

#import "UserTableViewController.h"
#import "TeacherViewController.h"

@interface UserTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSArray  *dataSource;
@property(nonatomic, strong)UIButton *button;
@end

@implementation UserTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"关注列表";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, KSCreen_Height-44-20)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(250, 7, 60, 30);
        button.tag = 101;
        [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:button];
       
    }
    UIButton *button = (UIButton*)[cell.contentView viewWithTag:101];
    [button setTitle:@"关注" forState:UIControlStateNormal];
    [cell.imageView setImage:[UIImage imageNamed:@"student2.jpg"]];
    cell.detailTextLabel.text = @"做梦，一切皆有可能！";
    cell.textLabel.text = @"Zero";
     self.button  = button;
    return  cell;
}
#pragma -mark tableViewAction
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TeacherViewController *teacherVctr = [[TeacherViewController alloc]init];
    [self.navigationController pushViewController:teacherVctr animated:YES];
}

#pragma -mark ButtonAction
- (void)action:(UIButton*)sender{
    [self showAlertWithTitle:@"" message:@"关注成功"];

    [self.button setTitle:@"已关注" forState:UIControlStateNormal];
}
@end
