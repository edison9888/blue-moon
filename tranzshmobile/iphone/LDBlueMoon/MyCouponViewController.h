
#import "BaseViewController.h"

@interface MyCouponViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSArray *dataSource;
@property(nonatomic,retain)NSArray *title_NameList;
@end
/*
 1、参照美团、UI统一、风格统一
 2、日历修改、
 3、添加我的动态、
 5、课程评论、机构评论、活动评论、老师评论、
 6、添加活动主页、
 7、添加老师主页、
*/