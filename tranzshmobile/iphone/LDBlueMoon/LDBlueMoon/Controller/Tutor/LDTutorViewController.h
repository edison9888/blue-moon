
#import <UIKit/UIKit.h>
#import "AOWaterView.h"
#import "ActivityModel.h"
#import "BaseViewController.h"
@interface LDTutorViewController : BaseViewController<UIScrollViewDelegate,ImageClickDelegate>
{

}
@property(nonatomic,strong)AOWaterView *aoView;
@property(nonatomic,strong)ActivityModel *model;
@property(nonatomic,strong)NSArray *dataSource;

@end
