

#import "LeftViewController.h"
#import "NotificationViewController.h"
#import "AttentionViewController.h"
#import "HomePageViewController.h"
#import "MyActivityViewController.h"
#import "HomeViewController.h"
#import "LDTutorViewController.h"
#import "PersonPageViewController.h"
#import "LDMoreViewController.h"
#import "BaseNavigationController.h"

#import "LDTutorViewController.h"
#import "UIViewExt.h"
@interface LeftViewController ()
@property(nonatomic,strong) NSMutableArray *dataSource;
@property(nonatomic,strong) NSArray *imageSource;
@end

@implementation LeftViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.dataSource = (NSMutableArray*)@[@"首页",
                            @"我的",@"关注",@"课程",@"活动",
                            @"消息",
                            @"设置"];
        self.imageSource = @[@"home_icon.png",
                             @"mine_icon.png",@"150-sailboat.png",@"187-pencil.png",@"153-guitar.png",
                             @"message_icon.png",
                             @"setting_icon.png"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:21/255.0 green:27/255.0 blue:37/255.0 alpha:1];
    //头像
    UIImageView *header = [[UIImageView alloc]initWithFrame:CGRectMake(10, 34, 50, 50)];
    header.layer.cornerRadius  = 25.0;
    header.layer.masksToBounds = YES;
    header.image = [UIImage imageNamed:@"actor.png"];
    //
    UILabel *nick = [[UILabel alloc]initWithFrame:CGRectMake(70, 54, 100, 20)];
    nick.text = @"Zero";
    nick.font = [UIFont boldSystemFontOfSize:14];
    nick.textColor = [UIColor whiteColor];
  
    

    //
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width-40, 108)];
    headerView.backgroundColor = [UIColor colorWithRed:57/255.0 green:136/255.0  blue:184/255.0  alpha:1];
    self.tableView.tableHeaderView = headerView;
    [headerView addSubview:header];
    [headerView addSubview:nick];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    
    return self.dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float height = 0.0;
    if (indexPath.row==2||indexPath.row == 3 || indexPath.row == 4) {
        return 38;
    }else{
        height = 44;
    }
    return height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
 
        cell.contentView.backgroundColor = [UIColor colorWithRed:21/255.0 green:27/255.0 blue:37/255.0 alpha:1];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(26, 12, 20, 20)];
        imageView.tag = 101;
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:imageView];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(70, 12, 100, 20)];
        [cell.contentView addSubview:lable];
        lable.font = [UIFont boldSystemFontOfSize:16];
        lable.textColor = [UIColor whiteColor];
        lable.tag = 100;
        lable.backgroundColor = [UIColor clearColor];
        
        
    }
    

    UILabel *lable = (UILabel*)[cell.contentView viewWithTag:100];
    UIImageView *imageView = (UIImageView*)[cell.contentView viewWithTag:101];
    
    if (indexPath.row==2||indexPath.row==3||indexPath.row==4) {
      
        lable.left = 105;
       
        lable.font = [UIFont boldSystemFontOfSize:14];
       
        imageView.hidden = YES;
    }
 
    
    lable.text = [self.dataSource objectAtIndex:indexPath.row];
    imageView.image = [UIImage imageNamed:[self.imageSource objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int index = indexPath.row;
    switch (index) {
        case 0:
        {
            HomeViewController * home = [[HomeViewController alloc]init];
            BaseNavigationController *n = [[BaseNavigationController alloc] initWithRootViewController:home];
            [self.revealSideViewController popViewControllerWithNewCenterController:n
                                                                           animated:YES];
        }
            break;
        case 1:
        {

            
            AttentionViewController *Vctr =[[AttentionViewController alloc]init];
            BaseNavigationController *baseNav = [[BaseNavigationController alloc]initWithRootViewController:Vctr];
            [self.revealSideViewController popViewControllerWithNewCenterController:baseNav animated:YES];
            
        }
            break;
        case 2:
        {
            HomePageViewController *moreVctr =[[HomePageViewController alloc]init];
            BaseNavigationController *baseNav = [[BaseNavigationController alloc]initWithRootViewController:moreVctr];
            [self.revealSideViewController popViewControllerWithNewCenterController:baseNav animated:YES];
        }
            break;
        case 3:
        {
            MyActivityViewController *moreVctr =[[MyActivityViewController alloc]init];
            BaseNavigationController *baseNav = [[BaseNavigationController alloc]initWithRootViewController:moreVctr];
            [self.revealSideViewController popViewControllerWithNewCenterController:baseNav animated:YES];
        }
            break;
        case 4:
        {
            LDTutorViewController *moreVctr =[[LDTutorViewController alloc]init];
            BaseNavigationController *baseNav = [[BaseNavigationController alloc]initWithRootViewController:moreVctr];
            [self.revealSideViewController popViewControllerWithNewCenterController:baseNav animated:YES];
        }
            break;
        case 5:
        {
            NotificationViewController *moreVctr =[[NotificationViewController alloc]init];
            BaseNavigationController *baseNav = [[BaseNavigationController alloc]initWithRootViewController:moreVctr];
            [self.revealSideViewController popViewControllerWithNewCenterController:baseNav animated:YES];
        }
            break;
        case 6:
        {
            LDMoreViewController *moreVctr =[[LDMoreViewController alloc]init];
            BaseNavigationController *baseNav = [[BaseNavigationController alloc]initWithRootViewController:moreVctr];
            [self.revealSideViewController popViewControllerWithNewCenterController:baseNav animated:YES];
        }
            break;
            
            
        default:
            break;
    }
}

@end
