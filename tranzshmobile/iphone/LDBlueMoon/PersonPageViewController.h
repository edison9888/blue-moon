
#import "BaseViewController.h"
#import "LGModelData.h"

@interface PersonPageViewController : BaseViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>



@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,strong)LGModelData *loginModel;
@property(nonatomic,strong)UIImageView *header;
@property(nonatomic,strong)NSString    *imagePath;
@property(nonatomic,strong)UILabel     *nickLable;
@property(nonatomic,strong)UILabel     *ageLable;
@property(nonatomic,strong)UIButton    *moreButton;
@end
