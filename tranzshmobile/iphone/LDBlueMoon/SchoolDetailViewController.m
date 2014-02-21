
#import "SchoolDetailViewController.h"
#import "CourseCell.h"
#import "SchoolCell.h"
#import "TeacherCell.h"
#import "CommentCell.h"
#import "CourseDetailViewController.h"
#import "BaseDataModel.h"
#import "UIViewExt.h"


#import "TeacherViewController.h"
@interface SchoolDetailViewController ()

@end

@implementation SchoolDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"机构主页";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initSubViews];
    [self loadData];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   // self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   // self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
- (void)initSubViews{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, 500)];
    //LOGO
    UIImageView *logoView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, 200)];
    logoView.image = [UIImage imageNamed:@"3.jpg"];
    [headerView addSubview:logoView];
    
    //头像
    UIImageView *actorView = [[UIImageView alloc]initWithFrame:CGRectMake(20, logoView.bottom-25, 50, 50)];
    actorView.image = [UIImage imageNamed:@"actor.png"];
    [headerView addSubview:actorView];
    self.schoolActor = actorView;
    
    //名字
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(actorView.right+5, logoView.bottom-25, 200, 20)];
    name.backgroundColor = [UIColor clearColor];
    name.text = @"Y+瑜伽体验中心";
    [headerView addSubview:name];
    self.nameLable = name;
    
    //flowers
    UIImageView *flower = [[UIImageView alloc]initWithFrame:CGRectMake(actorView.right+5, logoView.bottom+5, 80, 20)];
    flower.backgroundColor = [UIColor redColor];
    [headerView addSubview:flower];
    self.flowers = flower;
    
    //comment
    UILabel *comment = [[UILabel alloc]initWithFrame:CGRectMake(flower.right, logoView.bottom+5, 80, 20)];
    comment.text =@"(24)";
    [headerView addSubview:comment];
    self.commentLable = comment;
    
    //地址
    UIImageView *location = [[UIImageView alloc]initWithFrame:CGRectMake(20, actorView.bottom+10, 20, 20)];
    location.backgroundColor = [UIColor purpleColor];
    [headerView addSubview:location];
    
    UILabel *addr = [[UILabel alloc]initWithFrame:CGRectMake(location.right+10, actorView.bottom+10, 200, 20)];
    addr.text = @"华山路1780号XX大厦X楼";
    self.addrLable = addr;
    [headerView addSubview:addr];
    
    //联系方式
    UIImageView *photoView = [[UIImageView alloc]initWithFrame:CGRectMake(20, addr.bottom+5, 20, 20)];
    photoView.backgroundColor = [UIColor purpleColor];
    [headerView addSubview:photoView];
    UILabel *photo = [[UILabel alloc]initWithFrame:CGRectMake(photoView.right+10, addr.bottom+5, 200, 20)];
    photo.text = @"021-22334455";
    self.phoneLable = photo;
    [headerView addSubview:photo];
    
    //机构介绍
    UILabel *textLable = [[UILabel alloc]initWithFrame:CGRectZero];
    NSString *introduce = @"欢迎来到上海顶级瑜伽会所—Y+ Yoga Center中国顶级瑜伽会所, 全球认可高端瑜伽品牌每月超过800节课程,课程种类丰富，包括：流瑜伽、阴瑜伽、热瑜伽、Ashtanga 等专业资深的国际瑜伽教师团队地处闹市黄金地段，一流的环境及服务即刻免费申请瑜伽体验，开启自我探索的旅程";
    CGSize size = [introduce sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(320, 2000) lineBreakMode:NSLineBreakByWordWrapping];

    textLable.text = introduce;
    textLable.font = [UIFont systemFontOfSize:13];
    textLable.numberOfLines = 0;
    textLable.frame = CGRectMake(10, photo.bottom+10, 300, size.height);
    [headerView addSubview:textLable];
    self.introductionLable = textLable;
    
    UISegmentedControl *segMt = [[UISegmentedControl alloc]initWithItems:@[@"课程",@"分校",@"师资",@"评价"]];
    segMt.frame = CGRectMake(0, textLable.bottom+5, KSCreen_Width, 40);
    [segMt addTarget:self action:@selector(changeDataSourceOfShow:) forControlEvents:UIControlEventValueChanged];
    [headerView addSubview:segMt];
    
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, KSCreen_Height-44-20)];
    [self.view addSubview:tableView];
    headerView.frame = CGRectMake(0, 0, KSCreen_Width, segMt.bottom+5);
    tableView.tableHeaderView = headerView;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;

}
//加载数据
- (void)loadData{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i<10;i++) {
        ClassModel *model = [[ClassModel alloc]initWithData:nil];
        [arr addObject:model];
        
    }
    self.dataSource = arr;
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.dataSource count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (self.showState == LBCourseStyle) {
        static NSString *indentifier = @"c_Cell";
        CourseCell *c_cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if (c_cell==nil) {
            c_cell = [[CourseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        }
        cell = c_cell;
        c_cell.model = [[ClassModel alloc]initWithData:[self.dataSource objectAtIndex:indexPath.row]];
    }else if (self.showState == LBSchoolStyle){
        static NSString *indentifier = @"ch_Cell";
        SchoolCell *sh_cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if (sh_cell==nil) {
            sh_cell = [[SchoolCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        }
        
        cell = sh_cell;
    }else if (self.showState == LBTeacherStyle){
        static NSString *indentifier = @"t_Cell";
        TeacherCell *t_cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if (t_cell==nil) {
           t_cell  = [[TeacherCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        }
        t_cell.nameLable.text = @"Zero.Li";
        t_cell.sexLable.text  = @"女";
        t_cell.classLable.text = @"音乐";
        t_cell.headerView.image = [UIImage imageNamed:@"actor.png"];
        cell = t_cell;
    }else{
        static NSString *indentifier = @"cm_Cell";
        CommentCell *cm_cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if (cm_cell==nil) {
           cm_cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        }
        
        cell = cm_cell;
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.showState == 0) {
        CourseDetailViewController *classDetail = [[CourseDetailViewController alloc]init];
        [self.navigationController pushViewController:classDetail animated:YES];
    }else if (self.showState == 1){
        NSLog(@"正在完善");
    }else if (self.showState == 2){
        TeacherViewController *classDetail = [[TeacherViewController alloc]init];
        [self.navigationController pushViewController:classDetail animated:YES];
    }else if (self.showState == 3){
        NSLog(@"正在完善");
    }


    
}
- (void)changeDataSourceOfShow:(UISegmentedControl*)sender{
    int index = sender.selectedSegmentIndex;
    if (index == 0) {
        self.showState = LBCourseStyle;
        [self.tableView reloadData];
    }else if (index == 1){
        self.showState = LBSchoolStyle;
        [self.tableView reloadData];
        
    }else if (index ==2){
        self.showState = LBTeacherStyle;
        [self.tableView reloadData];
        
    }else{
        self.showState = LBCommentStyle;
        [self.tableView reloadData];
    }
}
@end
