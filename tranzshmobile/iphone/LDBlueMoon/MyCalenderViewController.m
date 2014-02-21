

#import "MyCalenderViewController.h"
#import "NSDate+convenience.h"
#import "DailyViewController.h"
//#import "ClassPageViewController.h"
@interface MyCalenderViewController ()

@end

@implementation MyCalenderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我的日历";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initSubViews];
	
}
-(void)initSubViews{
    VRGCalendarView *calendar = [[VRGCalendarView alloc] init];
    calendar.frame = CGRectMake(0, 0,KSCreen_Width, 400);
    calendar.delegate=self;
    [self.view addSubview:calendar];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
    if (month==[[NSDate date] month]) {
        NSArray *dates = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:5], nil];
        [calendarView markDates:dates];
    }
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date {
    if ([date day]==1||[date day] == 5) {
        DailyViewController  *dailyVctr = [[DailyViewController alloc]init];
        [self.navigationController pushViewController:dailyVctr animated:YES];
        
    }
}

@end
