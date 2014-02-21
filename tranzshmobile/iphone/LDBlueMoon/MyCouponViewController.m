//
//  MyCouponViewController.m
//  tz_bluemoon_ios_iphone
//
//  Created by IceBoy on 13-12-23.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "MyCouponViewController.h"

@interface MyCouponViewController ()

@end

@implementation MyCouponViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我的优惠券";
        self.dataSource = [[NSArray alloc]init];
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(void)dealloc{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initSubViews];
	
}
- (void)initSubViews{
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, KSCreen_Height)];
    tableView.delegate   = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.dataSource = @[@[@"体育",@"舞蹈",@"棋牌"],@[@"音乐",@"培训",@"语言"]];
    self.title_NameList = @[@"将要过期",@"已经过期"] ;
    
}

#pragma Mark - UITableViewDelegate Methood

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.title_NameList objectAtIndex:section];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.dataSource objectAtIndex:section] count] ;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
    }
    cell.textLabel.text = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];;
    cell.detailTextLabel.text = @"2013-12-30";
    cell.imageView.image = [UIImage imageNamed:@"actor.png"];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%d",indexPath.row);
}
@end
