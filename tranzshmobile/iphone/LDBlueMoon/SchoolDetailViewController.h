
#import "BaseViewController.h"
typedef NS_ENUM(NSInteger, LBshowState){
    LBCourseStyle,
    LBSchoolStyle,
    LBTeacherStyle,
    LBCommentStyle
    
};
@interface SchoolDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIImageView *headerLogoView;
@property(nonatomic,strong)UIImageView *schoolActor;
@property(nonatomic,strong)UILabel     *nameLable;
@property(nonatomic,strong)UIImageView *flowers;
@property(nonatomic,strong)UILabel     *commentLable;
@property(nonatomic,strong)UIImageView *locationView;
@property(nonatomic,strong)UILabel     *addrLable;
@property(nonatomic,strong)UIImageView *phoneImage;
@property(nonatomic,strong)UILabel     *phoneLable;
@property(nonatomic,strong)UILabel     *introductionLable;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,assign)LBshowState showState;

@end
