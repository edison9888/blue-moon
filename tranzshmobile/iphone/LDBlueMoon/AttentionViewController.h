
#import "BaseViewController.h"
typedef NS_ENUM(NSInteger, LBshowStyle){
    LBClasses,
    LBTeacher,
    LBSchool
};

@interface AttentionViewController : BaseViewController<UITableViewDataSource,
UITableViewDelegate>
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSArray *dataSource;
@property(nonatomic,assign)LBshowStyle showStyle;

@end
