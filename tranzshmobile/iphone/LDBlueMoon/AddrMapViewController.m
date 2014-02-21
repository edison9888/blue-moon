
#import "AddrMapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
@interface AddrMapViewController ()<AMapSearchDelegate,MAMapViewDelegate>
@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) AMapSearchAPI *search;

- (void)returnAction;
@end

@implementation AddrMapViewController
@synthesize mapView = _mapView;
@synthesize search  = _search;

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
    NSLog(@"地图已经清除。。。");
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
{   self.mapView = [[MAMapView alloc]init];
    self.mapView.frame = self.view.bounds;
    
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
    
    self.mapView.visibleMapRect = MAMapRectMake(220880104, 101476980, 272496, 466656);
}

- (void)initSearch
{
    self.search = [[AMapSearchAPI alloc] initWithSearchKey:[MAMapServices sharedServices].apiKey Delegate:nil];
    self.search.delegate = self;
    
}

- (void)popNavigation
{
    [self returnAction];
    
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initMapView];
    
    [self initSearch];
    [self searchPlaceByKey];
}
- (void)searchPlaceByKey
{
    AMapPlaceSearchRequest *poiRequest = [[AMapPlaceSearchRequest alloc] init];
    poiRequest.searchType = AMapSearchType_PlaceKeyword;
    poiRequest.keywords = @"长寿大厦";
    poiRequest.city = @[@"shanghai"];
    poiRequest.requireExtension = YES;
    [self.search AMapPlaceSearch: poiRequest];
}
- (void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)response
{

    NSString *strPoi = @"";
    for (AMapPOI *p in response.pois) {
        strPoi = [NSString stringWithFormat:@"%@\nPOI: %@", strPoi, p.description];
        NSLog(@"%f,%f",p.location.longitude,p.location.latitude);
    }
 
   
}

@end
