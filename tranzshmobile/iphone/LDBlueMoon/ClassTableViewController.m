//
//  ClassTableViewController.m
//  LDBlueMoon
//
//  Created by IceBoy on 14-2-14.
//  Copyright (c) 2014年 tranzvision. All rights reserved.
//

#import "ClassTableViewController.h"
#import "ApplyViewController.h"
#import "LDClassTableCell.h"
#import "ClassDetailViewController.h"
@interface ClassTableViewController ()
{
    UITableView *_tableView;
    
}
@property(nonatomic,strong)NSArray *dataSource;
@end

@implementation ClassTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.title = @"选择班级";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, KSCreen_Height-64)];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    self.dataSource = [UIFont familyNames];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    LDClassTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[LDClassTableCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ClassDetailViewController *classVctr = [[ClassDetailViewController alloc]init];
    [self.navigationController pushViewController:classVctr animated:YES];
}
@end
