

#import <UIKit/UIKit.h>
#import "BaseMapViewController.h"

#import "LDTwoLevelTableView.h"
@interface LDMapViewController : BaseMapViewController<PullMenuDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak) UIButton *selectedBtn;  
@property(nonatomic,retain)NSArray *dataSource;

@end
