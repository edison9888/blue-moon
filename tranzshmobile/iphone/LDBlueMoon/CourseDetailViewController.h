
#import "BaseViewController.h"


#import "BaseDataModel.h"
@interface CourseDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate
>
@property (nonatomic, strong)ClassModel  *model;//暂时借用ClassModel；
@property (nonatomic, strong)ClassModel  *detailModel;


@property (nonatomic, strong)NSString    *imageName;
@property (nonatomic, strong)UIPageControl *pageControl;

@property (nonatomic, strong)UIScrollView  *headerScroll;
@property (nonatomic, strong)UITableView   *tableView;

@property (nonatomic, strong)UIView   *headr_BGView;
@property (nonatomic, strong)UILabel  *titleLable;
@property (nonatomic, strong)UILabel  *natureLable;
@property (nonatomic, strong)UILabel  *detailLable;
@property (nonatomic, strong)UILabel  *timeLable;
@property (nonatomic, strong)UILabel  *addrLable;
@property (nonatomic, strong)UILabel  *teacherLable;
@property (nonatomic, strong)UILabel  *nowPriceLable;


@property (nonatomic,strong)NSTimer   *myTimer;


@property(nonatomic,assign)int model_id;

@end
