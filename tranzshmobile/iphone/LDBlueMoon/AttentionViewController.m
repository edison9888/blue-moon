

#import "AttentionViewController.h"
#import "UIViewExt.h"
#import "LDBaseCell.h"
@interface AttentionViewController ()

@end

@implementation AttentionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我的动态";
        self.showStyle = LBClasses;
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //适配iOS7
    if (IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    //加载视图
    [self initSubViews];
    //加载数据
    [self loadData];
  	
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)initSubViews{
    
    [self showBackButtonItem];
    
    

    UIImageView *tableViewHeader = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, 200)];
    tableViewHeader.image = [UIImage imageNamed:@"bg_mine_accountView.png"];
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, KSCreen_Height-44-20)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView = tableViewHeader;
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
    
}
 //加载数据
-(void)loadData{
    
}

#pragma -mark TableViewDelegate DataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 260;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;

}
- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    LDBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LDBaseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
 
    
    return cell;
}

- (void)popNavigation{
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft
                                                           animated:YES];
}
@end
