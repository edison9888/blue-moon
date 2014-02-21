#import "MyClassViewController.h"
#import "CourseDetailViewController.h"
#import "CourseCell.h"
#import "BaseDataModel.h"
#import "UIViewExt.h"
@interface MyClassViewController ()

@end

@implementation MyClassViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.title = @"我的听课";
        self.dataSource = [[NSArray alloc]init];
    }
    return self;
}
-(void)dealloc{
    
    self.tableView = nil;
    self.tableView = nil;

}
- (void)viewDidLoad
{
    [super viewDidLoad];
   // [self showHUDWithTitle:@"Loading..."];
    [self initSubViews];
    [self loadData];
	
}
-(void)loadData{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i<10;i++) {
        ClassModel *model = [[ClassModel alloc]initWithData:nil];
        [arr addObject:model];
    
    }
    self.dataSource = arr;
    [self.tableView reloadData];
}
- (void)initSubViews
{
    if (IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    NSArray *items = @[@"价格",@"开课时间",@"信用"];
    UISegmentedControl *segmentCtr = [[UISegmentedControl alloc]initWithItems:items];
    segmentCtr.frame = CGRectMake(0, 0, KSCreen_Width, 40);
    [segmentCtr addTarget:self action:@selector(changeStyle:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentCtr];
   
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, segmentCtr.bottom, KSCreen_Width, KSCreen_Height-20-44-49-40)];
    tableView.delegate   = self;
    tableView.dataSource = self;
    self.tableView       = tableView;
    [self.view addSubview:tableView];
}
#pragma mark - UITableViewDelegate Methood
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.dataSource count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"Cell";
    CourseCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell==nil) {
        cell = [[CourseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    cell.model = [[ClassModel alloc]initWithData:[self.dataSource objectAtIndex:indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CourseDetailViewController *classDetailVctr = [[CourseDetailViewController alloc]init];
    [self.navigationController pushViewController:classDetailVctr animated:YES];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark- UISegmentController Action
-(void)changeStyle:(UISegmentedControl*)sender{
    if (sender.selectedSegmentIndex==0) {
        
    }else if (sender.selectedSegmentIndex ==1){
        
    }else if(sender.selectedSegmentIndex ==2){
        
    }
}
@end
