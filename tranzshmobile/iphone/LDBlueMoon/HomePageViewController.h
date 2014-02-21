

#import "BaseViewController.h"
typedef NS_ENUM(NSInteger, LBshowContentStyle){
    LBClassContent,//课程
    LBActivityContent,//活动
    LBSchoolContent,//学校
    LBUserContent//个人
};
@interface HomePageViewController : BaseViewController
@property (nonatomic, assign)LBshowContentStyle showContent;
@property (nonatomic, strong)NSArray *c_dataSource;//课程数据源
@property (nonatomic, strong)NSArray *t_dataSource;//老师数据源
@property (nonatomic, strong)NSArray *a_dataSource;//活动数据源
@property (nonatomic, strong)NSArray *s_dataSource;//机构数据源
@end
