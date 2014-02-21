

#import "TeacherViewController.h"
#import "UIViewExt.h"
#import "UIColor+expanded.h"
@interface TeacherViewController ()

@end

@implementation TeacherViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"教师主页";
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
	
}
- (void)initSubViews
{
    //header
    UIView *backgroundView   = [[UIView alloc]initWithFrame:CGRectZero];
    UIImageView  *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(7, 6, 80, 80)];
    UILabel     *nicLable    = [[UILabel alloc]initWithFrame:CGRectMake(99, 6, 142,  21)];
    UILabel     *proLable    = [[UILabel alloc]initWithFrame:CGRectMake(99, 36, 156, 21)];
    UILabel     *itdLable    = [[UILabel alloc]initWithFrame:CGRectMake(99, 64, 211, 52)];
    nicLable.text  = @"Zero.Li";
    proLable.text  = @"中国 上海  普陀";
    itdLable.text  = @"著名舞蹈老师,十年舞蹈功底。";
    itdLable.numberOfLines = 0;
    headerView.image = [UIImage imageNamed:@"actor.png"];
    [backgroundView addSubview:headerView];
    [backgroundView addSubview:nicLable];
    [backgroundView addSubview:proLable];
    [backgroundView addSubview:itdLable];
    NSArray *titles = @[@"相册",@"学生",@"资料",@"更多"];
    
    for (int i = 0; i<4;i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(8+i*(70+8), 120, 70, 60);
        button.backgroundColor     = [UIColor colorWithRed:0.0/255 green:220.0/255 blue:161.0/255 alpha:1];
        button.layer.cornerRadius  = 4;
        button.layer.masksToBounds = YES;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(pushTo:) forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:button];
        
    }
    
    UILabel *s_lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 190, KSCreen_Width, 20)];
    s_lable.text = @"    学员评价";
    [backgroundView addSubview:s_lable];
    UIColor *color = [UIColor colorWithRed:0/255.0 green:220/255.0 blue:161/255.0 alpha:1.0];
    
    [s_lable setBackgroundColor:color];
    backgroundView.frame = CGRectMake(0, 0, KSCreen_Width, 220);

    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, KSCreen_Height-KStatusBar_Height-KNavBar_Height)];
    _tableView.tableHeaderView = backgroundView;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}
#pragma -mark  tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifer = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    cell.textLabel.text = @"评价内容";
    return cell;
    
}

#pragma -mark ButtonAction
-(void)pushTo:(UIButton*)sender{
    
    
}


@end
