

#import "BaseMapViewController.h"

@implementation BaseMapViewController
@synthesize     mapView = _mapView;
@synthesize     search  = _search;

#pragma mark - Utility

- (void)clearMapView
{
     self.mapView.showsUserLocation = NO;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self.mapView removeOverlays:self.mapView.overlays];
    
    self.mapView.delegate = nil;
}

- (void)clearSearch
{
    self.search.delegate = nil;
}

#pragma mark - Handle Action

- (void)returnAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
    [self clearMapView];
    
    [self clearSearch];
}

#pragma mark - AMapSearchDelegate

- (void)search:(id)searchRequest error:(NSString *)errInfo
{
    NSLog(@"%s: searchRequest = %@, errInfo= %@", __func__, [searchRequest class], errInfo);
}

#pragma mark - Initialization

- (void)initMapView
{
    self.mapView.frame = self.view.bounds;
    
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
    
    self.mapView.visibleMapRect = MAMapRectMake(220880104, 101476980, 272496, 466656);
}

- (void)initSearch
{
    self.search.delegate = self;
}

- (void)initBaseNavigationBar
{
   
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"btn_backItem.png"] forState:UIControlStateNormal];
    backButton.frame     = CGRectMake(0, 0, 24, 24);
    backButton.showsTouchWhenHighlighted = YES;
    [backButton addTarget:self action:@selector(returnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = back;
    
}


#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initBaseNavigationBar];
    [self initMapView];
    [self initSearch];
}

@end
