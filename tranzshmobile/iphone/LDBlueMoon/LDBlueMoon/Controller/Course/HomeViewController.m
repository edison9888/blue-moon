

#import "HomeViewController.h"
#import "CourseCell.h"
#import "CourseDetailViewController.h"
#import "BaseDataModel.h"
#import "HotCourseCell.h"
#import "UIViewExt.h"
#import "LeftViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "BaseNavigationController.h"
@interface HomeViewController ()<EGORefreshTableHeaderDelegate,UIGestureRecognizerDelegate>{
    EGORefreshTableHeaderView *_refreshHeaderView;
    UIView *_segCtr;
    UILabel *_loc_lable;
	BOOL _reloading;
    UIPanGestureRecognizer *_pan;
}

@property (nonatomic,strong) MAMapView     *mapView;
@property (nonatomic,retain) AMapSearchAPI *search;
@property (nonatomic,retain) NSArray     *dataSource;
@property (nonatomic,retain) NSString    *currentCity;
@property (nonatomic,retain) UITableView *courseTableView;


@end

@implementation HomeViewController
@synthesize courseTableView;


- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = @"美课";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.revealSideViewController resetOption:PPRevealSideOptionsShowShadows];
    [self initSubViews];
    [self loadData];
    
}

-(void)initSubViews
{
    self.view.backgroundColor = ThemeColor;
    UILabel *locationLable    = [[UILabel alloc]initWithFrame:CGRectMake(190, 14, 80, 20)];
    [self.navigationController.navigationBar addSubview:locationLable];
    locationLable.text            = @"上海";
    locationLable.font            = [UIFont systemFontOfSize:FitSize];
    locationLable.textColor       = [UIColor whiteColor];
    locationLable.backgroundColor = [UIColor clearColor];
    locationLable.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                        action:@selector(chooseCity:)];
    [locationLable addGestureRecognizer:tap];
    _loc_lable = locationLable;
    
    
    //右导航按钮
    UIButton *locationBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,24,24)];
    [locationBtn setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    [locationBtn addTarget:self
                    action:@selector(searchItemPressed)
          forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[ UIBarButtonItem alloc]initWithCustomView:locationBtn];
    //左导航按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame     = CGRectMake(0, 0, 22, 22);
    [button setImage:[UIImage imageNamed:@"menu_item.png"] forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(cityItemPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *cityItem = [[UIBarButtonItem alloc]initWithCustomView:button ];

    
    [cityItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = cityItem;
    
    /**
     ** 覆盖连接处 一条黑线  加在NavgationBar上
     **/
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 42, KSCreen_Width, 4)];
    lineView.backgroundColor = [UIColor colorWithRed:41/255.0 green:172/255.0 blue:240/255.0 alpha:1];
    [self.navigationController.navigationBar addSubview:lineView];
    
    UISegmentedControl *segCtr = [[UISegmentedControl alloc]initWithItems:@[@"课程",@"活动"]];
    
    [segCtr addTarget:self
               action:@selector(changeStyle:)
     forControlEvents:UIControlEventValueChanged];

    segCtr.selectedSegmentIndex = 0;
    segCtr.selected = YES;
    
    segCtr.frame    = CGRectMake((KSCreen_Width-209)/2, 6, 209, 32);
    UIView *segView = [[UIView alloc]initWithFrame:CGRectMake(segCtr.left, 6, 208, 32)];
    segView.backgroundColor     = [UIColor whiteColor];
    segView.layer.cornerRadius  = 5;
    segView.layer.masksToBounds = YES;
    

    
    UIView*backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, 44)];
    backgroundView.backgroundColor = ThemeColor;
    [self.view addSubview:backgroundView];
    _segCtr = backgroundView;
    [_segCtr addSubview:segView];
    [_segCtr addSubview:segCtr];
   
    
 
    
    //列表
    courseTableView =
    [[UITableView alloc]initWithFrame:CGRectMake(0,44, KSCreen_Width, KSCreen_Height-44-20-44)];
    courseTableView.delegate       = self;
    courseTableView.dataSource     = self;
    courseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view =
        [[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0.0f, 0.0f - self.courseTableView.bounds.size.height, self.view.frame.size.width, self.courseTableView.bounds.size.height)];
		view.delegate = self;
		[courseTableView addSubview:view];
		_refreshHeaderView = view;
		
	}
    
    [self.view addSubview:courseTableView];
 

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    pan.delegate = self;
    [courseTableView addGestureRecognizer:pan];
    _pan = pan;
    courseTableView.userInteractionEnabled = YES;
    
    //间隔线补充
    if ([courseTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [courseTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    
}
-(void)pan:(UIPanGestureRecognizer*)pan
{
    CGPoint firstPoint = [pan translationInView:pan.view];
  
    float y = firstPoint.y;

    if (y>0) {
        [UIView animateWithDuration:.3 animations:^{
            _segCtr.frame          = CGRectMake(0, 0, KSCreen_Width, 44);
        }];
        courseTableView.top        = 44;
        courseTableView.height     = 372;
        if (self.view.bounds.size.height > 480) {
            courseTableView.height = 460;
        }
        
    }else{
        courseTableView.top         = 0;
        courseTableView.height      = 416;
        if (self.view.bounds.size.height > 480) {
            courseTableView.height  = 504;
        }
        
        [UIView animateWithDuration:.3 animations:^{
            _segCtr.frame = CGRectMake(0, 100, KSCreen_Width, 44);
        }];
    }
    
}

-(void)loadData
{
    NSArray *model_ids = @[@1,@2,@3,@4];
    NSArray *images = @[
                        @"http://10.10.1.202/users/appserver/images/52e52156aa2da08a99ec191a7828cd91?t[]=resize%3Awidth%3D280&accessToken=9d9910ac9ecbd764e8ea9e1d3223b667e6935c04c5de7df16b119ff2102086fa",
                        @"http://10.10.1.202/users/appserver/images/1aa7fd7f4b84a09588f02a3c1d29ae2d?t[]=resize%3Awidth%3D280&accessToken=7f6e380304473a288ba126a7146fc8093cdd6738d4cf3e4cf1c650112e6d4f73",
                        @"http://10.10.1.202/users/appserver/images/c5be059cad7973c76dbfdbe8f6f9c44a?t[]=resize%3Awidth%3D280&accessToken=fe80ceee64b0ace9b801b8e7bdb4a8a650a3784f838608f66b7522a837fa0e3a",
                        @"http://10.10.1.202/users/appserver/images/d2a78a144ed306cda0e854e01359cfe0?t[]=resize%3Awidth%3D280&accessToken=f81b74e4fb8196387910fb88a81adce32406f321df37fda87c4cda9f082e4dbd"];
    NSArray *classesNames = @[@"西方魔法扫盲班",@"小学毕业班数学辅导班",@"手工折纸课",@"霍格沃兹魔法班"];
    
    NSArray *titles = @[@"精品班、小班",
                        @"精品班、小班",
                        @"精品班、小班",
                        @"精品班、小班。"];
    NSArray *introduce = @[@"西方魔法扫盲班",
                           @"重点小学金牌教师绝密教案首次披露～！ 重点中学升学率高达90%～！",
                           @"折纸又称“工艺折纸”，是一种以纸张折成各种不同形状的艺术活动。在大部分的折纸比赛中，要求参赛者以一张无损伤的完整正方形纸张折出作品。折纸发源于中国，在日本得到发展。欧洲也有自成一体的折纸艺术。19世纪，西方人开始将折纸与自然科学结合在一起。折纸不仅成为建筑学院的教具，还发...",
                           @"霍格沃茨是寄宿学校，被设置在山湖旁的城堡。虽然它的精确地点在书中没有详述，但作者J.K.罗琳说明霍格沃茨位于苏格兰。而霍格沃茨的学生必须乘火车才能到达。（电影里的霍格沃茨在苏格兰的爱丁堡找到了安尼克古堡，霍格沃茨魔法学校的大部分地方都是在安尼克古堡取景的。另外的取景还包括牛津大学，剑桥大学，杜伦大学。）"];
    NSArray *price  = @[@"$500.00",@"$8888.00",@"$199.00",@"$8999.00"];
    NSArray *phoneNumber = @[@"电话:12345678",@"电话:87654321",@"电话:87654321",@"电话:99999999"];
    NSArray *logos = @[
                       @"http://10.10.1.202/users/appserver/images/4afc61ba11926e2c1cd57404eb9d8918?t[]=resize%3Awidth%3D280&accessToken=b05dbd8fe3c085df9a4322ddd9aaed70523db593659f0ba3ee92024e1b331084",
                       @"http://10.10.1.202/users/appserver/images/809fe3abfbb610d5c589a0a42aa74761?t[]=resize%3Awidth%3D280&accessToken=41036c60115600c13370c44b18fabc6d403059f7b6e100de0ebfb816654b069f",
                       @"http://10.10.1.202/users/appserver/images/9bb722f3ebc48659249f3c718a282262?t[]=resize%3Awidth%3D280&accessToken=557516279a57dfe2549e143dcc7431d489715e04d36b6deee436fb92d7de6a80",
                       @"http://10.10.1.202/users/appserver/images/8a156d6ce66ca366fe37c22a34d8e3c4?t[]=resize%3Awidth%3D280&accessToken=faea726e2f3e12a50de8dfb3afc8b97165e85aaef754bebff20b523e6f2ee313"];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i<4;i++) {
        ClassModel *model = [[ClassModel alloc]initWithData:nil];
        model.photoUrl    = images[i];
        model.title       = classesNames[i];
        model.time        = titles[i];
        model.content     = introduce[i];
        model.nowPrice    = price[i];
        model.classStyle  = phoneNumber[i];
        model.model_id    = model_ids[i];
        model.logoUrl     = logos[i];
        [arr addObject:model];
        
    }
    self.dataSource = arr;
    [self.courseTableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated
{
    _segCtr.hidden = NO;
}

-(void)viewDidAppear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = YES;
    _loc_lable.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = NO;
    _loc_lable.hidden = YES;
    _segCtr.hidden    = YES;

}
-(void)viewDidDisappear:(BOOL)animated
{
    _segCtr.hidden = YES;
}
/*
 *进入菜单
 */
-(void)cityItemPressed:(id)sender
{
    LeftViewController *tableViewController =
    [[LeftViewController alloc]initWithStyle:UITableViewStylePlain];
    
    [self.revealSideViewController
     pushViewController:tableViewController
     onDirection:PPRevealSideDirectionLeft withOffset:40 animated:YES];

}

/*
 *搜索按钮
 */
-(void)searchItemPressed
{
    LDSearchCourseViewController *searchCourseVC = [[LDSearchCourseViewController alloc]init];

    [self.navigationController pushViewController:searchCourseVC animated:YES];
}

/*
 *选择城市
 */
-(void)chooseCity:(UITapGestureRecognizer*)tap
{

        LDSearchCityViewController *searchCityViewController = [[LDSearchCityViewController alloc]init];
         searchCityViewController.delegate = self;
    
         BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:searchCityViewController];
         LDAppDelegate *ldDelegate = [UIApplication sharedApplication].delegate;
    
         [ldDelegate.window.rootViewController presentViewController:nav animated:YES completion:NULL];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
  
}



#pragma mark LDSearchCityDelegate

-(void)selectCity:(NSString *)city
{
  _loc_lable.text = city;
}

#pragma mark HTTP Request

-(void)requestForCourse
{
    
}

-(void)requestForCourseFinished:(ASIHTTPRequest *)request
{
    
}

-(void)requestForCourseFailed:(ASIHTTPRequest *)request
{
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataSource.count;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    HotCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   
    if (cell == nil) {
      
        cell = [[HotCourseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    }
  
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model          = [self.dataSource objectAtIndex:indexPath.row];
    
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    CourseDetailViewController *classDetailVctr = [[CourseDetailViewController alloc]init];
    ClassModel *model           = [self.dataSource objectAtIndex:indexPath.row];
    classDetailVctr.imageName   = model.photoUrl;
    classDetailVctr.detailModel = model;

    [self.navigationController pushViewController:classDetailVctr animated:YES];
}

/*
 * 切换显示内容
 */
-(void)changeStyle:(UISegmentedControl*)sender{
    if (sender.selectedSegmentIndex==0) {
    
        [UIView beginAnimations:@"doflip" context:nil];
        //设置时常
        [UIView setAnimationDuration:1];
        //设置动画淡入淡出
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        //设置代理
        [UIView setAnimationDelegate:self];
        //设置翻转方向
        [UIView setAnimationTransition:
         UIViewAnimationTransitionFlipFromLeft  forView:self.courseTableView cache:YES];
        //动画结束
        [UIView commitAnimations];
        
        [self.courseTableView reloadData];
    }else{
        
        [UIView beginAnimations:@"doflip" context:nil];
        [UIView setAnimationDuration:1];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDelegate:self];
        
         [UIView setAnimationTransition:
         UIViewAnimationTransitionFlipFromRight  forView:self.courseTableView cache:YES];
        
        [UIView commitAnimations];
        
        [self.courseTableView reloadData];
    }
}



#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	

	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	
	
	 _reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.courseTableView];
	
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
	
	return _reloading;
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
	
	return [NSDate date];
	
}
//手势代理
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
