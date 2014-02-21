//
//  LDMoreViewController.m
//  LDBlueMoon
//
//  Created by Lilac on 13-11-6.
//  Copyright (c) 2013年 tranzvision. All rights reserved.
//

#import "LDMoreViewController.h"
#import "PPRevealSideViewController.h"
@interface LDMoreViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataSource;

@end

@implementation LDMoreViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"更多";
    }
    return self;
}

- (NSString *)tabImageName
{
	return @"icon_tabbar_misc";
}

- (NSString *)tabTitle
{
	return self.title;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    if (IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"btn_backItem.png"] forState:UIControlStateNormal];
    backButton.frame     = CGRectMake(0, 0, 24, 24);
    backButton.showsTouchWhenHighlighted = YES;
    [backButton addTarget:self action:@selector(popNavigation) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = back;
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, KSCreen_Height-49-20) style:UITableViewStyleGrouped];
    self.dataSource = [NSArray arrayWithObjects: @[@"仅wifi下显示图片",@"消息提醒",@"分享设置",@"清空缓存"],@[@"意见反馈",@"检查更新",@"关于BlueMoon"],@[@"精品应用"],nil];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.dataSource objectAtIndex:section] count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.text = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (indexPath.section == 0 && indexPath.row == 0) {
        [cell.contentView addSubview:[[UISwitch alloc]initWithFrame:CGRectMake(260, 10, 40, 20)]];
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.section==0&&indexPath.row ==3) {
            cell.detailTextLabel.text = @"801.14K";
        }
        if (indexPath.section==1&&indexPath.row ==1) {
            cell.detailTextLabel.text = @"当前版本v0.2";
        }
    }
    return cell;
}

- (void)popNavigation{
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft
                                                           animated:YES];
}
@end
