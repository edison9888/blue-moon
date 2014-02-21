//
//  ClassDetailViewController.m
//  LDBlueMoon
//
//  Created by IceBoy on 14-2-19.
//  Copyright (c) 2014年 tranzvision. All rights reserved.
//

#import "ClassDetailViewController.h"
#import "UIViewExt.h"
#import "CalenderTableView.h"
#import "ApplyViewController.h"
enum {
    AnnotationViewControllerAnnotationTypeRed = 0,
    AnnotationViewControllerAnnotationTypeGreen,
    AnnotationViewControllerAnnotationTypePurple
};
@interface ClassDetailViewController ()
{
    MAMapView *_mapView;
}
@property (nonatomic, strong) NSMutableArray *annotations;
@end

@implementation ClassDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initAnnotations];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self layoutSubViews];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(void)layoutSubViews
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    [button setTitle:@"选择" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(apply) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    UILabel *classNameLable   = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, KSCreen_Width, 20)];
    classNameLable.text = @"精品小班A班";
    classNameLable.font = [UIFont systemFontOfSize:FitSize];
    [self.view addSubview:classNameLable];

    UIView *footer_BGView     = [[UIView alloc]initWithFrame:CGRectMake(0, classNameLable.bottom+5, KSCreen_Width, 50)];
    UIView *lineViewo         = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, .5)];
    lineViewo.backgroundColor =  [UIColor colorWithRed:197/255.0
                                                  green:198/255.0
                                                   blue:193/255.0
                                                  alpha:1];
    [footer_BGView addSubview:lineViewo];
    
    UIImageView *actor = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 40, 40)];
    actor.image        = [UIImage imageNamed:@"actor.png"];
    [footer_BGView addSubview:actor];
     
     
     //
     for (int i = 0; i<4; i++) {
     UIImageView *imageView  = [[UIImageView alloc]initWithFrame:CGRectMake(actor.right+10+(3+23)*i, 13, 23, 23)];
     imageView.clipsToBounds = YES;
     imageView.contentMode   = UIViewContentModeScaleAspectFit;
     [imageView setImage:[UIImage imageNamed:@"course_star.png"]];
         if (i==3) {
             [imageView setImage:[UIImage imageNamed:@"halfstar.png"]];
         
         }
         [footer_BGView addSubview:imageView];
     
     }
     //
     UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, KSCreen_Width, .5)];
     lineView.backgroundColor = [UIColor colorWithRed:197/255.0 green:198/255.0 blue:193/255.0 alpha:1];
     [footer_BGView addSubview:lineView];
     //
     UIImageView *identifierView = [[UIImageView alloc]initWithFrame:CGRectMake(KSCreen_Width - 14-10, 13, 14, 24)];
     identifierView.clipsToBounds = YES;
     identifierView.contentMode = UIViewContentModeScaleAspectFit;
     identifierView.image = [UIImage imageNamed:@"icon_cell_rightArrow.png"];
     [footer_BGView addSubview:identifierView];
     //
     UILabel *scoreLable = [[UILabel alloc]initWithFrame:CGRectMake(193, 15, 40, 20)];
     scoreLable.text = @"4.5分";
     scoreLable.textColor = [UIColor orangeColor];
     scoreLable.font = [UIFont systemFontOfSize:FitSize];
     [footer_BGView addSubview:scoreLable];
     [self.view addSubview:footer_BGView];
    
    UIView *view =
    [[UIView alloc]initWithFrame:CGRectMake(0, footer_BGView.bottom, KSCreen_Width, 160)];
    view.backgroundColor = GrayColor;
    [self.view addSubview:view];
    
    UILabel *classLable  = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 80, 20)];
    classLable.font      = [UIFont systemFontOfSize:FitSize];
    classLable.textColor = [UIColor grayColor];
    classLable.text      = @"课程安排";
    [view addSubview:classLable];
    

    
    UILabel *addrLable  = [[UILabel alloc]initWithFrame:CGRectMake(20, 135, 80, 20)];
    addrLable.font      = [UIFont systemFontOfSize:FitSize];
    addrLable.textColor = [UIColor grayColor];
    addrLable.text      = @"上课地点";
    [view addSubview:addrLable];

    
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(5, view.bottom+5,KSCreen_Width-10, KSCreen_Height-view.bottom-10)];
    _mapView.delegate = self;
    _mapView.visibleMapRect = MAMapRectMake(220880104, 101476980, 272496, 466656);
    
    self.locationPoint = CLLocationCoordinate2DMake(31.237110, 121.437163);
    
    [self.view addSubview:_mapView];
   
    
}

-(void)viewDidAppear:(BOOL)animated{
    MACoordinateSpan span = {0.01,0.01};
    
    MACoordinateRegion region = {self.locationPoint,span};
    
   [ _mapView setRegion:region animated:YES];

    [_mapView addAnnotations:self.annotations];
}


#pragma  -mark ButtonAction
- (void)apply
{
    ApplyViewController *applyVctr = [[ApplyViewController alloc]init];
    [self.navigationController pushViewController:applyVctr animated:YES];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
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
        
        annotationView.pinColor = [self.annotations indexOfObject:annotation];
        
        return annotationView;
    }
    
    return nil;
}
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views{
    
}

#pragma mark - Initialization

- (void)initAnnotations
{
    self.annotations = [NSMutableArray array];
    
    /* Red annotation. */
    MAPointAnnotation *red = [[MAPointAnnotation alloc] init];
    red.coordinate = CLLocationCoordinate2DMake(31.237210, 121.437263);
    red.title      = @"Red";
    [self.annotations insertObject:red atIndex:AnnotationViewControllerAnnotationTypeRed];
    
    /* Green annotation. */
    MAPointAnnotation *green = [[MAPointAnnotation alloc] init];
    green.coordinate = CLLocationCoordinate2DMake(31.237698, 121.437248);
    green.title      = @"Green";
    [self.annotations insertObject:green atIndex:AnnotationViewControllerAnnotationTypeGreen];
    
    /* Purple annotation. */
    MAPointAnnotation *purple = [[MAPointAnnotation alloc] init];
    purple.coordinate = CLLocationCoordinate2DMake(31.237837, 116.437277);
    purple.title      = @"Purple";
    [self.annotations insertObject:purple atIndex:AnnotationViewControllerAnnotationTypePurple];
}
@end
