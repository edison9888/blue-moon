//
//  LDSearchResultViewController.m
//  LDBlueMoon
//
//  Created by Lilac on 13-12-26.
//  Copyright (c) 2013年 tranzvision. All rights reserved.
//

#import "LDSearchResultViewController.h"
#import "BaseDataModel.h"
#import "CourseCell.h"
#import "CourseDetailViewController.h"
#import "LDMapViewController.h"
@interface LDSearchResultViewController ()
@property(nonatomic,strong)NSArray *dataSource;
@end

@implementation LDSearchResultViewController
@synthesize keyWord;
@synthesize titleSegment;

@synthesize searchResultTableView;
@synthesize categoryBtn,placeBtn,orderBtn;
@synthesize twoLevelTableView;


- (id)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor whiteColor];
    if (IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    //过滤周边
    UIButton *location = [UIButton buttonWithType:UIButtonTypeCustom];
    location.frame = CGRectMake(0, 0, 16, 26);
    [location addTarget:self action:@selector(locationItemPressed) forControlEvents:UIControlEventTouchUpInside];
    [location setImage:[UIImage imageNamed:@"07-map-marker.png"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:location];
    self.navigationItem.rightBarButtonItem  = rightItem;
    
    
    
    searchResultTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, 320, self.view.bounds.size.height - 30) style:UITableViewStylePlain];
    searchResultTableView.delegate = self;
    searchResultTableView.dataSource = self;
    [self.view addSubview:searchResultTableView];
    
    categoryBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [categoryBtn setTitle:@"全部分类" forState:UIControlStateNormal];
    categoryBtn.frame = CGRectMake(0, 0, 106, 30);
    categoryBtn.tag = 1111;
    categoryBtn.layer.borderWidth = 1.0f;
    categoryBtn.layer.borderColor = [UIColor colorWithRed:14.0/255 green:108.0/255 blue:255.0/255 alpha:1.0f].CGColor;
    [categoryBtn addTarget:self action:@selector(filterBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:categoryBtn];
    
    placeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [placeBtn setTitle:@"全城" forState:UIControlStateNormal];
    placeBtn.frame = CGRectMake(106, 0, 106, 30);
    placeBtn.tag = 2222;
    placeBtn.layer.borderWidth = 1.0f;
    placeBtn.layer.borderColor = [UIColor colorWithRed:14.0/255 green:108.0/255 blue:255.0/255 alpha:1.0f].CGColor;
    [placeBtn addTarget:self action:@selector(filterBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:placeBtn];
    
    orderBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [orderBtn setTitle:@"智能排序" forState:UIControlStateNormal];
    orderBtn.frame = CGRectMake(212, 0, 106, 30);
    orderBtn.tag = 3333;
    orderBtn.layer.borderWidth = 1.0f;
    orderBtn.layer.borderColor = [UIColor colorWithRed:14.0/255 green:108.0/255 blue:255.0/255 alpha:1.0f].CGColor;
    [orderBtn addTarget:self action:@selector(filterBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:orderBtn];
    
    twoLevelTableView = [[LDTwoLevelTableView alloc]initWithFrame:CGRectMake(0, -320, 320, 280)];
    twoLevelTableView.isOpen = NO;
    twoLevelTableView.delegate = self;
    [self.view addSubview:twoLevelTableView];
    [self.view sendSubviewToBack:twoLevelTableView];
    [self loadData];
}
-(void)loadData{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:30];
    for (int i = 0; i<30;i++) {
        ClassModel *model = [[ClassModel alloc]initWithData:nil];
        [arr addObject:model];
        
    }
    self.dataSource = arr;
    [self.searchResultTableView reloadData];
}
-(void)filterBtnPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    switch (button.tag) {
        case 1111:
            // Get some different data.
            twoLevelTableView.level0TableView.frame = CGRectMake(0, 0, 160, 250);
            
            break;
        case 2222:
            // Get some different data.
            twoLevelTableView.level0TableView.frame = CGRectMake(0, 0, 160, 250);
            
            break;
        case 3333:
            twoLevelTableView.level0TableView.frame = CGRectMake(0, 0, 320, 250);
            break;
        default:
            break;
    }
    [self.view bringSubviewToFront:twoLevelTableView];
    [self.view bringSubviewToFront:categoryBtn];
    [self.view bringSubviewToFront:placeBtn];
    [self.view bringSubviewToFront:orderBtn];
    [twoLevelTableView.level0TableView reloadData];
    [twoLevelTableView.level1TableView reloadData];
    [twoLevelTableView animatePullUp];
}

#pragma mark PullMenuDelegate

-(void)menuItemSelected:(NSIndexPath *)indexPath
{
    [twoLevelTableView animatePullUp];
}

#pragma mark - HTTP Request

-(void)requestForSearch
{
    
}

-(void)requestForSearchFinished:(ASIHTTPRequest *)request
{
    
}

-(void)requestForSearchFailed:(ASIHTTPRequest *)request
{
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 30;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CourseCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[CourseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    

    }
    cell.model = [self.dataSource objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseDetailViewController *courseDetailViewController = [[CourseDetailViewController alloc]init];
    [courseDetailViewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:courseDetailViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
#pragma -mark buttonAction-
-(void)locationItemPressed
{
    LDMapViewController *mapViewController = [[LDMapViewController alloc]init];
    [mapViewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:mapViewController animated:YES];
}

@end
