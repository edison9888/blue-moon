

#import "LDMapViewController.h"
#import "CustomAnnotationView.h"
#import "POIAnnotation.h"
#import "CommonUtility.h"
#import "sys/utsname.h"
#import "BMAnnotation.h"
#import "MBProgressHUD.h"
@interface LDMapViewController ()
{
    MBProgressHUD *progressHUD;
}

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) NSMutableArray *annotations;

@property (nonatomic, assign) AMapSearchType searchType;
@property (nonatomic, strong) MAUserLocation *myLocation;
@property (nonatomic, strong) NSArray *dataArray;




@end

@implementation LDMapViewController
@synthesize mapView     = _mapView;
@synthesize search      = _search;
@synthesize annotations;

@synthesize searchType = _searchType;
@synthesize myLocation;

@synthesize dataArray;


@synthesize selectedBtn;


- (id)init
{
    self = [super init];
    if (self) {
      
    }
    return self;
}
-(void)dealloc
{
    self.mapView.delegate =nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
- (void)initMapView
{
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.showsUserLocation = YES;
}


/* 初始化标注 */

- (void)initAnnotations
{
    
    MAPointAnnotation *annotation1 = [[MAPointAnnotation alloc] init];
    annotation1.coordinate = CLLocationCoordinate2DMake(31.237210, 121.437263);
    annotation1.title    = @"AutoNavi";
    annotation1.subtitle = @"CustomAnnotationView";
    
    
    MAPointAnnotation *annotation2 = [[MAPointAnnotation alloc] init];
    annotation2.coordinate = CLLocationCoordinate2DMake(31.237698, 121.437248);;
    annotation2.title    = @"AutoNavi";
    annotation2.subtitle = @"CustomAnnotationView";
    
    MAPointAnnotation *annotation3 = [[MAPointAnnotation alloc] init];
    annotation3.coordinate = CLLocationCoordinate2DMake(31.237210, 121.437263);
    annotation3.title    = @"AutoNavi";
    annotation3.subtitle = @"CustomAnnotationView";
    
    
    MAPointAnnotation *annotation7 = [[MAPointAnnotation alloc] init];
    annotation7.coordinate = CLLocationCoordinate2DMake(31.236886, 121.436813);
    annotation7.title    = @"AutoNavi";
    annotation7.subtitle = @"CustomAnnotationView";
    
    MAPointAnnotation *annotation4 = [[MAPointAnnotation alloc] init];
    annotation4.coordinate = CLLocationCoordinate2DMake(31.236935, 121.437531);
    annotation4.title    = @"AutoNavi";
    annotation4.subtitle = @"CustomAnnotationView";
    
    MAPointAnnotation *annotation5 = [[MAPointAnnotation alloc] init];
    annotation5.coordinate = CLLocationCoordinate2DMake(31.236897, 121.437447);
    annotation5.title    = @"AutoNavi";
    annotation5.subtitle = @"CustomAnnotationView";
    
    MAPointAnnotation *annotation6 = [[MAPointAnnotation alloc] init];
    annotation6.coordinate = CLLocationCoordinate2DMake(31.237041, 121.437637);
    annotation6.title    = @"AutoNavi";
    annotation6.subtitle = @"CustomAnnotationView";
    annotations = [NSMutableArray arrayWithObjects: annotation1,annotation2,annotation3,annotation4,annotation5,annotation6,annotation7,nil];

    
  
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];

    [self initMapView];
    [self initAnnotations];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    

    self.mapView.delegate   = self;

    [self.view addSubview:self.mapView];
    
    UIButton *back = [self makeButtonWithframe:@""
                                         image:@"icon_dealsmap_back.png"
                                         frame:CGRectMake(10, 20, 40, 40)];
    

    UIButton *more = [self makeButtonWithframe:@""
                                         image:@""
                                         frame:CGRectMake(49.5, 20, 150, 40)];
    
    UIButton *refresh = [self makeButtonWithframe:@""
                                            image:@"icon_map_refresh.png"
                                            frame:CGRectMake(KSCreen_Width-50, 20, 40, 40)];
    
    UIButton *location = [self makeButtonWithframe:@""
                                             image:@"icon_map_locate.png"
                                             frame:CGRectMake(10, KSCreen_Height-20-40, 40, 40)];
    
    UIButton *list = [self makeButtonWithframe:@""
                                         image:@"icon_map_tabList.png"
                                         frame:CGRectMake(KSCreen_Width-50,KSCreen_Height-60,40,40)];

    [back addTarget:self
             action:@selector(popAction)
   forControlEvents:UIControlEventTouchUpInside];
    
    [more addTarget:self
             action:@selector(moreAction)
   forControlEvents:UIControlEventTouchUpInside];
    [refresh addTarget:self
                action:@selector(refreshAction)
      forControlEvents:UIControlEventTouchUpInside];
    
    [location addTarget:self
                 action:@selector(mylocationBtnPressed)
       forControlEvents:UIControlEventTouchUpInside];
    
    
    [list addTarget:self
             action:@selector(listAction) forControlEvents:UIControlEventTouchUpInside];
    
   
    [self.view addSubview:back];
    [self.view addSubview:more];
    [self.view addSubview:refresh];
    [self.view addSubview:location];
    [self.view addSubview:list];
}
- (UIButton*)makeButtonWithframe:(NSString*)title
                           image:(NSString*)image
                           frame:(CGRect)frame
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor blackColor];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    button.frame = frame;
    button.alpha = .7;
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CLLocationCoordinate2D coordate = self.myLocation.location.coordinate;
    MACoordinateSpan     span = {0.003,0.003};
    MACoordinateRegion region = {coordate, span};
    [self.mapView setRegion:region animated:YES];
    [self.mapView addAnnotations:self.annotations];
    [self performSelector:@selector(mylocationBtnPressed) withObject:nil afterDelay:1];
   

}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [self.mapView removeAnnotations: self.annotations];
}


#pragma mark - Actions

-(void)mylocationBtnPressed
{
   self.mapView.centerCoordinate = CLLocationCoordinate2DMake(self.myLocation.location.coordinate.latitude, self.myLocation.location.coordinate.longitude);
    
}

- (void)popAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)moreAction
{
    
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, KSCreen_Height)];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = .4;
        view.tag = 200;
        [self.view addSubview:view];
        UITapGestureRecognizer *tap =
        [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidenMenuView)];
        [self.view addGestureRecognizer:tap];
        LDTwoLevelTableView *menuView =
        [[LDTwoLevelTableView alloc]initWithFrame:CGRectMake(10, 60, 300, 0)];
        
        [self.view addSubview:menuView];
        menuView.tag = 201;
        [UIView animateWithDuration:.3 animations:^{
            menuView.frame = CGRectMake(10, 60, 300, 250);
        }];
    

        
    

}
-(void)refreshAction
{
    [self.mapView addAnnotations:annotations];
}
-(void)listAction
{
    UIView *fullView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, KSCreen_Height)];
    fullView.backgroundColor = [UIColor blackColor];
    fullView.alpha = 0;
    fullView.tag = 101;
    [self.view addSubview:fullView];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(30, -420, 260, 360)];
    [self.view addSubview:tableView];
    tableView.tag = 102;
    tableView.backgroundColor     = [UIColor whiteColor];
    tableView.layer.cornerRadius  = 5;
    tableView.layer.masksToBounds = YES;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidenView)];
    [fullView addGestureRecognizer:tap];
    
    [UIView animateWithDuration:.5 animations:^{
        fullView.alpha  = .4;
        tableView.frame = CGRectMake(30, 60, 260, 360);
    }];
    
}

- (void)hidenView
{
    __block UIView *view = (UIView*)[self.view viewWithTag:101];
    __block UITableView *tableView = (UITableView*)[self.view viewWithTag:102];
    [UIView animateWithDuration:.3 animations:^{
         view.alpha = 0;
        tableView.frame = CGRectMake(30, KSCreen_Height-60, 260, 360);
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
        [tableView removeFromSuperview];
        tableView = nil;
        view = nil;
    }];
    
}
- (void)hidenMenuView
{
    
    __block  LDTwoLevelTableView *menuView = (LDTwoLevelTableView*)[self.view viewWithTag:201];
    __block  UIView *view = (UIView*)[self.view viewWithTag:200];
    [UIView animateWithDuration:.3 animations:^{
        menuView.frame = CGRectMake(10, 60, 300, 0);
        view.alpha = 0;
    } completion:^(BOOL finished) {
        [menuView removeFromSuperview];
        menuView = nil;
        
        [view removeFromSuperview];
        view = nil;
        
    }];
    
}
#pragma mark - MAMapViewDelegate

-(void)mapView:(MAMapView*)mapView didUpdateUserLocation:(MAUserLocation*)userLocation
{
    //NSLog(@"我的位置:%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    self.myLocation = userLocation;
}
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    CLLocationCoordinate2D  location = [mapView convertPoint:self.view.center toCoordinateFromView:self.view];
    NSLog(@"%f,%f",location.latitude,location.longitude);
    static int index = 0;

    if (index>1) {
        if (progressHUD) {
            [progressHUD removeFromSuperview];
            progressHUD = nil;
        }
        
        progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:progressHUD];
        [self.view bringSubviewToFront:progressHUD];
        
        progressHUD.labelText = @"当前范围标注中...";
        [progressHUD show:YES];
        
        [self performSelector:@selector(removeSub) withObject:nil afterDelay:2];
      
       
    }

    index ++;
    
}
-(void)removeSub
{
    if (progressHUD) {
        [progressHUD removeFromSuperview];
         progressHUD = nil;
    }
    [self initOther];
   
    
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
   
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
            
            annotationView.canShowCallout            = YES;
            annotationView.animatesDrop              = YES;
            annotationView.draggable                 = YES;
            annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        }
        
        return annotationView;
        
    }
    return nil;

  
}



#pragma -mark
#pragma UITableViewDelegate DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.imageView.image = [UIImage imageNamed:@"icon.png"];
    cell.textLabel.text  = @"手公告折纸课";
    return cell;
}

//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
//
-(void)menuItemSelected:(NSIndexPath *)indexPath withFilterStyle:(NSString *)style
{
    
}













/*
 121.433472,31.236879
 121.433662,31.236765
 121.433289,31.236757

 121.441505,31.247080
 121.436073,31.240946
 121.436432,31.240772
 121.433060,31.237022
 121.436554,31.237551
 121.436111,31.243898
 121.433281,31.244284
 121.436668,31.238745
 121.439026,31.242268
 121.436745,31.240179
 *
 */
- (void)initOther{
   
    [self.mapView removeAnnotations:self.annotations];
    MAPointAnnotation *annotation1 = [[MAPointAnnotation alloc] init];
    annotation1.coordinate = CLLocationCoordinate2DMake(121.433472,31.236879);
    annotation1.title    = @"AutoNavi";
    annotation1.subtitle = @"CustomAnnotationView";
    MAPointAnnotation *annotation2 = [[MAPointAnnotation alloc] init];
    annotation2.coordinate = CLLocationCoordinate2DMake(121.433281,31.244284);
    annotation2.title    = @"AutoNavi";
    annotation2.subtitle = @"CustomAnnotationView";
    MAPointAnnotation *annotation3 = [[MAPointAnnotation alloc] init];
    annotation3.coordinate = CLLocationCoordinate2DMake(121.436745,31.240179);
    annotation3.title    = @"AutoNavi";
    annotation3.subtitle = @"CustomAnnotationView";
    MAPointAnnotation *annotation4 = [[MAPointAnnotation alloc] init];
    annotation4.coordinate = CLLocationCoordinate2DMake(121.436554,31.237551);
    annotation4.title    = @"AutoNavi";
    annotation4.subtitle = @"CustomAnnotationView";
    MAPointAnnotation *annotation5 = [[MAPointAnnotation alloc] init];
    annotation5.coordinate = CLLocationCoordinate2DMake(121.436432,31.240772);
    annotation5.title    = @"AutoNavi";
    annotation5.subtitle = @"CustomAnnotationView";
    MAPointAnnotation *annotation6 = [[MAPointAnnotation alloc] init];
    annotation6.coordinate = CLLocationCoordinate2DMake(121.433289,31.236757);
    annotation6.title    = @"AutoNavi";
    annotation6.subtitle = @"CustomAnnotationView";
    self.annotations = [[NSMutableArray alloc ]initWithObjects: annotation1,annotation2,annotation3,annotation4,annotation5,annotation6, nil];
    
    [self.mapView addAnnotations:self.annotations];
}
@end
