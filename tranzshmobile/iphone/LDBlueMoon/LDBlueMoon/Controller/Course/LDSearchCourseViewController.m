

#import "LDSearchCourseViewController.h"
#import "LDCourseDetailViewController.h"
@interface LDSearchCourseViewController ()

@end

@implementation LDSearchCourseViewController
@synthesize searchDisplayController;
@synthesize tagArray;
@synthesize tagStr;

- (id)init
{
    self = [super init];
    if (self) {
       
        tagArray = [NSArray arrayWithObjects:@"瑜伽",@"乒乓球",@"书法",@"击剑",@"数学",@"台球",@"象棋",@"健美操",@"篆刻", nil];
        
        for (int i=1; i<tagArray.count+1; i++) {
            NSInteger row = 0;
            if (i%3 == 0) {
                row = i / 3 - 1;
            }else{
                row = i / 3;
            }
            if (i % 3 == 1) {
                [self initTagButtonsWithFrame:CGRectMake(15, 74 + (36+10) * row, 90, 36) andTag:i -1];
            }else if (i % 3 == 2){
                [self initTagButtonsWithFrame:CGRectMake(15 + 90+10, 74 + (36+10) * row, 90, 36) andTag:i -1];
            }else if(i % 3 == 0){
                [self initTagButtonsWithFrame:CGRectMake(15 + 100 + 100, 74 + (36+10) * row, 90, 36) andTag:i -1];
            }
        }
    }
    return self;
}

-(void)initTagButtonsWithFrame:(CGRect)frame andTag:(NSInteger)btnTag
{
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tagButton.layer.borderWidth = 1;
    tagButton.layer.cornerRadius = 4.0;
    tagButton.layer.masksToBounds = YES;
    tagButton.frame = frame;
    tagButton.tag = btnTag;
    [tagButton setAdjustsImageWhenHighlighted:NO];
    [tagButton setTitle:[tagArray objectAtIndex:btnTag] forState:UIControlStateNormal];
    [tagButton setTitle:[tagArray objectAtIndex:btnTag] forState:UIControlStateHighlighted];
    [tagButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [tagButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    tagButton.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1] CGColor];
    [tagButton setBackgroundColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1]];
    [tagButton addTarget:self action:@selector(tagButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:tagButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
  
    self.view.backgroundColor = GrayColor;
    self.title = @"搜索";
 
    [self showBackButtonItem];
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    searchBar.userInteractionEnabled = YES;
    searchBar.showsScopeBar   = YES;

    searchBar.backgroundColor = [UIColor clearColor];
    searchBar.placeholder = @"请输入课程名称、地址等";
   

    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    backgroundView.backgroundColor = ThemeColor;
    [searchBar insertSubview:backgroundView atIndex:1];
    
    [self.view addSubview:searchBar];
    
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
    searchDisplayController.delegate = self;
    self.searchDisplayController.searchResultsDelegate = self;
    self.searchDisplayController.searchResultsDataSource = self;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

}

-(void)tagButtonPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    LDSearchResultViewController *searchResultVC = [[LDSearchResultViewController alloc]init];
    searchResultVC.keyWord = [tagArray objectAtIndex:button.tag];

    [self.navigationController pushViewController:searchResultVC animated:YES];
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


#pragma mark UISearchDisplayController Delegate

-(void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope
{
//    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",searchText];
//    searchResults = [recipes filteredArrayUsingPredicate:resultPredicate];
    
//    NSLog(@"#############%@",searchResults);
    
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

    }
    return rows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {

    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        LDCourseDetailViewController *courseDetailViewController = [[LDCourseDetailViewController alloc]init];

        [self.navigationController pushViewController:courseDetailViewController animated:YES];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
