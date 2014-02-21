
typedef NS_ENUM(NSInteger, LBChooseStyle){
    LBClass,
    LBActivity
};

#import "BaseViewController.h"

@interface MyActivityViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSArray *dataSource;
@property(nonatomic,retain)NSArray *activitySource;
@property(nonatomic,assign)LBChooseStyle style;
@end
