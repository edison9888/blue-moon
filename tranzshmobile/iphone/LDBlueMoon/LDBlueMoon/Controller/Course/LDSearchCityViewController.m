//
//  LDSearchCityViewController.m
//  LDBlueMoon
//
//  Created by Lilac on 13-11-13.
//  Copyright (c) 2013年 tranzvision. All rights reserved.
//

#import "LDSearchCityViewController.h"

@interface LDSearchCityViewController ()

@property (nonatomic,retain) NSArray *totalCities;
@property (nonatomic,retain) UITableView *currentableView;
@end

@implementation LDSearchCityViewController
@synthesize searchDisplayController;
@synthesize totalCitiesObj;
@synthesize searchResults;
@synthesize delegate;

@synthesize totalCities;
@synthesize currentableView;


- (id)init
{
    self = [super init];
    if (self) {
        
        currentableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, 568-80) style:UITableViewStylePlain];
        [self initData];
    }
    return self;
}

-(void)initData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ProvincesAndCities" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *tempObj = [[NSMutableArray alloc]init];
    for (int i = 0; i<array.count; i++) {
        NSArray *a = [array objectAtIndex:i];
        [tempObj addObjectsFromArray:[a valueForKey:@"Cities"]];
    }
    
    NSLog(@"~~~~temp:%d",tempObj.count);
    self.totalCitiesObj = tempObj;
    
    NSMutableArray *tmp = [[NSMutableArray alloc]init];
    for (int j = 0; j< tempObj.count; j++) {
        NSString *s = [tempObj[j] valueForKey:@"city"];
        [tmp addObject:s];
    }
    self.totalCities = tmp;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	  
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"搜索城市";
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonPressed)];
    self.navigationItem.rightBarButtonItem = cancel;
    
    currentableView.delegate = self;
    currentableView.dataSource =self;
    [self.view addSubview:currentableView];
    
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    searchBar.userInteractionEnabled = YES;
    searchBar.showsScopeBar = YES;
    searchBar.showsCancelButton = YES;
    searchBar.placeholder = @"输入城市名或拼音查询";
    
    [self.view addSubview:searchBar];
    
    
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
    searchDisplayController.delegate = self;
    self.searchDisplayController.searchResultsDelegate = self;
    self.searchDisplayController.searchResultsDataSource = self;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

-(void)cancelButtonPressed
{
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}


#pragma mark UISearchDisplayController Delegate

-(void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",searchText];
    searchResults = [totalCities filteredArrayUsingPredicate:resultPredicate];
    
    NSLog(@"#############%@",searchResults);
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}

#pragma mark UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        rows = self.searchResults.count;
    }else{
        rows = self.totalCities.count;
    }
    return rows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        cell.textLabel.text = [searchResults objectAtIndex:[indexPath row]];
    }else{
        cell.textLabel.text = [totalCities objectAtIndex:[indexPath row]];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView])
    {
        [self.delegate selectCity:[searchResults objectAtIndex:[indexPath row]]];
    }
    else{
        [self.delegate selectCity:[totalCities objectAtIndex:[indexPath row]]];
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
