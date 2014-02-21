

#import "HomePageViewController.h"
#import "CourseDetailViewController.h"//课程主页
#import "SchoolDetailViewController.h"
#import "TeacherViewController.h"
#import "ActivityDetailViewController.h"

#import "CourseCell.h"
#import "ActivityCell.h"
#import "SchoolCell.h"
#import "TeacherCell.h"
#import "BaseDataModel.h"
#import "HttpRequest.h"
@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *_moveView;
}
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSArray *dataSource;

@end

@implementation HomePageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
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
    [self showBackButtonItem];
    

	[self initSubViews];
    [self loadData];
}
- (void)initSubViews
{
    
    UIView *toolBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, 40)];
    [self.view addSubview:toolBarView];
    toolBarView.backgroundColor  = [UIColor groupTableViewBackgroundColor];
    _moveView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width/4, 40)];
    _moveView.tag = 201412;
    _moveView.backgroundColor = [UIColor orangeColor];
    [toolBarView addSubview:_moveView];
    
    NSArray *atName = @[@"课程",@"活动",@"机构",@"用户"];
    for (int i = 0; i<4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*KSCreen_Width/4, 0, KSCreen_Width/4, 40);
        [button setTitle:atName[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = i+1;
        [button addTarget:self action:@selector(changePosition:) forControlEvents:UIControlEventTouchUpInside];
        [toolBarView addSubview:button];
    }
    
    //表
    UITableView *listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];

    self.tableView = listView;

    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    [self.view addSubview:self.tableView];
}
- (void)loadData
{
        NSArray *images = @[@"http://10.10.1.202/users/appserver/images/52e52156aa2da08a99ec191a7828cd91?t[]=resize%3Awidth%3D280&accessToken=9d9910ac9ecbd764e8ea9e1d3223b667e6935c04c5de7df16b119ff2102086fa",
                            @"http://10.10.1.202/users/appserver/images/1aa7fd7f4b84a09588f02a3c1d29ae2d?t[]=resize%3Awidth%3D280&accessToken=7f6e380304473a288ba126a7146fc8093cdd6738d4cf3e4cf1c650112e6d4f73",
                            @"http://10.10.1.202/users/appserver/images/c5be059cad7973c76dbfdbe8f6f9c44a?t[]=resize%3Awidth%3D280&accessToken=fe80ceee64b0ace9b801b8e7bdb4a8a650a3784f838608f66b7522a837fa0e3a",
                            @"http://10.10.1.202/users/appserver/images/d2a78a144ed306cda0e854e01359cfe0?t[]=resize%3Awidth%3D280&accessToken=f81b74e4fb8196387910fb88a81adce32406f321df37fda87c4cda9f082e4dbd"];
        NSArray *classesNames = @[@"西方魔法扫盲班",@"小学毕业班数学辅导班",@"手工折纸课",@"霍格沃兹魔法班"];
        
        NSArray *titles = @[@"西方魔法扫盲班",@"金牌教师亲自指导",@"折纸又称“工艺折纸”，是一种以...",@"火焰杯大赛要开始了。。。"];
        NSArray *introduce = @[@"西方魔法扫盲班",@"重点小学金牌教师绝密教案首次披露～！ 重点中学升学率高达90%～！",@"折纸又称“工艺折纸”，是一种以纸张折成各种不同形状的艺术活动。在大部分的折纸比赛中，要求参赛者以一张无损伤的完整正方形纸张折出作品。折纸发源于中国，在日本得到发展。欧洲也有自成一体的折纸艺术。19世纪，西方人开始将折纸与自然科学结合在一起。折纸不仅成为建筑学院的教具，还发...",@"霍格沃茨是寄宿学校，被设置在山湖旁的城堡。虽然它的精确地点在书中没有详述，但作者J.K.罗琳说明霍格沃茨位于苏格兰。而霍格沃茨的学生必须乘火车才能到达。（电影里的霍格沃茨在苏格兰的爱丁堡找到了安尼克古堡，霍格沃茨魔法学校的大部分地方都是在安尼克古堡取景的。另外的取景还包括牛津大学，剑桥大学，杜伦大学。）"];
        NSArray *price  = @[@"$500.00",@"$8888.00",@"$199.00",@"$8999.00"];
        NSArray *phoneNumber = @[@"电话:12345678",@"电话:87654321",@"电话:87654321",@"电话:99999999"];
        
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
    NSLog(@"%d",self.appDelegate.numat);
    if (self.appDelegate.numat == 0) {
        self.appDelegate.numat = 1;
    }
            ClassModel *model = [[ClassModel alloc]initWithData:nil];
            model.photoUrl    = images[self.appDelegate.numat-1];
            model.title       = classesNames[self.appDelegate.numat-1];
            model.time        = titles[self.appDelegate.numat-1];
            model.content     = introduce[self.appDelegate.numat-1];
            model.nowPrice    = price[self.appDelegate.numat-1];
            model.classStyle  = phoneNumber[self.appDelegate.numat-1];
            [arr addObject:model];
            
    
        self.dataSource = arr;
    
        [self.tableView reloadData];
    
}
#pragma -ListViewDelegate Methed

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    float num = 0;
    if (self.showContent ==LBClassContent) {
        
        num = self.appDelegate.atCLNum;
        
    }else if (self.showContent == LBActivityContent){
        
        num = self.appDelegate.atACNum;
        
    }else if (self.showContent == LBSchoolContent) {
        
        num = 0;
        
    }else if (self.showContent == LBUserContent){
        
        num = 0;
    }
    return num;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = 0;
    if (self.showContent ==LBClassContent) {
        
        height = 110;
        
    }else if (self.showContent == LBActivityContent){
        
        height = 130;
        
    }else if (self.showContent == LBSchoolContent) {
        
        height = 130;
        
    }else if (self.showContent == LBUserContent){
        
        height = 80;
        
    }
    return height;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell;
    
    if (self.showContent == LBClassContent) {
        
        static NSString *indentifier = @"c_Cell";
        
        CourseCell *c_cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if (c_cell==nil) {
            
            c_cell = [[CourseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        }
        
        cell = c_cell;
        
        c_cell.model = [self.dataSource objectAtIndex:indexPath.row];
        
    }else if (self.showContent == LBActivityContent){
        
        static NSString *indentifier = @"ch_Cell";
        
        ActivityCell *sh_cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if (sh_cell==nil) {
            sh_cell = [[ActivityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        }
        
        sh_cell.schoolLogo.image = [UIImage imageNamed:self.appDelegate.imageName];
        sh_cell.model = self.appDelegate.model;
        NSLog(@"%@",self.appDelegate.model.title);
        cell = sh_cell;
        
    }else if (self.showContent == LBSchoolContent){
        static NSString *indentifier = @"t_Cell";
        SchoolCell *t_cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if (t_cell==nil) {
            t_cell  = [[SchoolCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        }
        t_cell.model = [self.s_dataSource objectAtIndex:indexPath.row];
        cell = t_cell;
    }else{
        static NSString *indentifier = @"cm_Cell";
        TeacherCell *cm_cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if (cm_cell==nil) {
            cm_cell = [[TeacherCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        }
        cm_cell.model = [self.t_dataSource objectAtIndex:indexPath.row];
        cell = cm_cell;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.showContent == LBClassContent)
    {
        CourseDetailViewController *classPageVCtr = [[CourseDetailViewController alloc]init];
        ClassModel *model = [self.dataSource objectAtIndex:indexPath.row];
        classPageVCtr.imageName   = model.photoUrl;
        classPageVCtr.detailModel = model;
        [self.navigationController pushViewController:classPageVCtr animated:YES];
       
    }else if (self.showContent == LBActivityContent){
        ActivityDetailViewController *actDetaicVctr = [[ActivityDetailViewController alloc]init];
        
        actDetaicVctr.imageName = self.appDelegate.imageName;
        actDetaicVctr.model = self.appDelegate.model;
        [self.navigationController pushViewController:actDetaicVctr animated:YES];
        
    }else if (self.showContent == LBSchoolContent){
        SchoolDetailViewController *schoolPageVctr = [[SchoolDetailViewController alloc]init];
        [self.navigationController pushViewController:schoolPageVctr animated:YES];
        
    }else if (self.showContent == LBUserContent){
        TeacherViewController *teacherVctr = [[TeacherViewController alloc]init];
        [self.navigationController pushViewController:teacherVctr animated:YES];
        
    }
}
- (void)changePosition:(UIButton*)sender
{
    int btn_tag = sender.tag;
    [UIView animateWithDuration:.2 animations:^{
        _moveView.frame = CGRectMake((btn_tag-1)*KSCreen_Width/4, 0, KSCreen_Width/4, 40);
    }];
    switch (btn_tag) {
        case 1:
        self.showContent = LBClassContent;
            [self.tableView reloadData];
        break;
        case 2:
        {
        self.showContent = LBActivityContent;
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
            for (int i = 0; i<self.appDelegate.atACNum; i++) {
                ActivityModel *model = [[ActivityModel alloc]initWithData:nil];
                [arr addObject:model];
            }
            self.t_dataSource = arr;
            [self.tableView reloadData];
        }

        break;
        case 3:
        {
            self.showContent = LBSchoolContent;
            [HttpRequest requestWithUrl:@"http://bluemoon/user/favorite/friends/m/25" params:nil block:^(id result) {
              
            }];
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
            for (int i = 0; i<20; i++) {
                SchoolModel *model = [[SchoolModel alloc]initWithData:nil];
                [arr addObject:model];
            }
            self.s_dataSource = arr;
            [self.tableView reloadData];
        }
        break;
        case 4:
        {
            self.showContent = LBUserContent;
            [HttpRequest requestWithUrl:@"http://bluemoon/product/clazz/detail/m/4/25" params:nil block:^(id result) {
                NSLog(@"%@",result);
            }];
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
            for (int i = 0; i<20; i++) {
                TeacherModel *model = [[TeacherModel alloc]initWithData:nil];
                [arr addObject:model];
            }
            self.t_dataSource = arr;
            [self.tableView reloadData];
        }
        break;
        default:
        break;
    }

}
- (void)popNavigation{
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft
                                                           animated:YES];
}
@end
