

#import "MyActivityViewController.h"
#import "CourseDetailViewController.h"
#import "ActivityDetailViewController.h"
#import "ActivityCell.h"
#import "CourseCell.h"
#import "BaseDataModel.h"
#import "HttpRequest.h"
#import "ActivityModel.h"
#import "ApplySucViewController.h"
@interface MyActivityViewController ()

@end

@implementation MyActivityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我的活动";
        self.dataSource = [[NSArray alloc]init];
        self.style = LBActivity;
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initSubViews];
    [self loadData];
}
- (void)initSubViews
{
    
    [self showBackButtonItem];
    
    UIButton *styleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    styleButton.frame = CGRectMake(0, 0, 40, 30);
    [styleButton setTitle:@"课程" forState:UIControlStateNormal];
    [styleButton addTarget:self action:@selector(changeStyle:) forControlEvents:UIControlEventTouchUpInside ];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:styleButton];
    self.navigationItem.rightBarButtonItem = rightItem ;
    

    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, KSCreen_Height)];
    tableView.delegate   = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;


}

- (void)loadData
{

    NSMutableArray *arr = [NSMutableArray  arrayWithCapacity:20];
    for (int i = 0; i<20; i++) {
        ClassModel *classModel = [[ClassModel alloc]initWithData:nil];
        [arr addObject:classModel];
    }
    self.dataSource = arr;
}

- (void)loadDataFinish:(id)result
{
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:2];
    for (id elem in result) {
    
        ActivityModel *model = [[ActivityModel alloc]initWithData:elem];
        [models addObject:model];
    }
    self.activitySource = models;
}
#pragma Mark - UITableViewDelegate Methood

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.style==LBActivity) {
        return 150;
    }else{
        return 130;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.style==LBActivity) {
        return 20;
    }else{
        return self.dataSource.count;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UITableViewCell*cell;
    if (self.style==LBActivity) {
        static NSString *a_indentifier = @"ACell";
        ActivityCell *a_cell = [tableView dequeueReusableCellWithIdentifier:a_indentifier];
        if (a_cell==nil) {
            
            a_cell = [[ActivityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:a_indentifier];
        }
        cell = a_cell;
    }else{
        static NSString *c_indentifier = @"CCell";
        CourseCell *c_cell = [tableView dequeueReusableCellWithIdentifier:c_indentifier];
        if (c_cell==nil) {
            c_cell = [[CourseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:c_indentifier];
        }
    
        cell = c_cell;
        c_cell.model = [self.dataSource objectAtIndex:indexPath.row];
    }

    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.style == LBClass) {
        CourseDetailViewController *classDetailVctr = [[CourseDetailViewController alloc]init];
        [self.navigationController pushViewController:classDetailVctr animated:YES];
 
    }else if (self.style == LBActivity){
        ActivityDetailViewController *activityDetailVctr = [[ActivityDetailViewController alloc]init];
        [self.navigationController pushViewController:activityDetailVctr animated:YES];
        
    }
}
-(void)changeStyle:(UIButton*)sender{
    if ([sender.titleLabel.text isEqualToString:@"课程"]) {
        [HttpRequest requestWithUrl:@"http://bluemoon/user/learnings/m/26" params:nil block:^(id result) {
            [self loadDataFinish:result];
        }];
        [sender setTitle:@"活动" forState:UIControlStateNormal];
        self.style = LBClass;
        self.title = @"我的课程";
        [UIView beginAnimations:@"doflip" context:nil];
        //设置时常
        [UIView setAnimationDuration:1];
        //设置动画淡入淡出
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        //设置代理
        [UIView setAnimationDelegate:self];
        //设置翻转方向
        [UIView setAnimationTransition:
         UIViewAnimationTransitionFlipFromLeft  forView:self.tableView cache:YES];
        //动画结束
        [UIView commitAnimations];
        
        [self.tableView reloadData];
    }else{

        [sender setTitle:@"课程" forState:UIControlStateNormal];
        self.style = LBActivity;
        self.title = @"我的活动";
        [UIView beginAnimations:@"doflip" context:nil];
        [UIView setAnimationDuration:1];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDelegate:self];
    
        [UIView setAnimationTransition:
         UIViewAnimationTransitionFlipFromRight  forView:self.tableView cache:YES];
        
        [UIView commitAnimations];
        
        [self.tableView reloadData];
    }
}
- (void)popNavigation{

    int count = self.navigationController.viewControllers.count;
    if (count>2&&[[self.navigationController.viewControllers objectAtIndex: count-2] isKindOfClass:[ApplySucViewController class]]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft
                                                               animated:YES];
 
    }
}
@end
