

#import "ActivityCell.h"
#import "UIViewExt.h"
#import "UIImageView+WebCache.h"
@implementation ActivityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews
{
    _schoolLogo    = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 105, 105)];
    
    UILabel *name  = [[UILabel alloc]initWithFrame:CGRectMake(_schoolLogo.right+5, 10, 75, 20)];
    name.text      = @"活动主题:";
    name.textColor = [UIColor grayColor];
    UILabel *addr  = [[UILabel alloc]initWithFrame:CGRectMake(_schoolLogo.right+5, name.bottom+3, 75, 20)];
        addr.text  = @"活动地址:";
    addr.textColor = [UIColor grayColor];
    UILabel *time  = [[UILabel alloc]initWithFrame:CGRectMake(_schoolLogo.right+5, addr.bottom+3, 75, 20)];
        time.text  = @"活动时间:";
    time.textColor = [UIColor grayColor];
    UILabel *pNum  = [[UILabel alloc]initWithFrame:CGRectMake(_schoolLogo.right+5, time.bottom+3, 75, 20)];
        pNum.text  = @"参与人数:";
    pNum.textColor = [UIColor grayColor];
    
    UILabel *host  = [[UILabel alloc]initWithFrame:CGRectMake(_schoolLogo.right+5, pNum.bottom+3, 80, 20)];
    host.text      = @"发起机构:";
    
    host.textColor = [UIColor grayColor];
    
    _activityName  = [[UILabel alloc]initWithFrame:CGRectMake(name.right, 7, 140, 20)];
    
    _activityAddr  = [[UILabel alloc]initWithFrame:CGRectMake(addr.right, name.bottom+3, 130, 20)];
    _activityTime  = [[UILabel alloc]initWithFrame:CGRectMake(time.right, addr.bottom+3, 120, 20)];
    _activityPn    = [[UILabel alloc]initWithFrame:CGRectMake(pNum.right, time.bottom+3, 120, 20)];
    _activityHost  = [[UILabel alloc]initWithFrame:CGRectMake(host.right, pNum.bottom+3, 120, 20)];
    
    
     [self.contentView addSubview:name];
     [self.contentView addSubview:addr];
     [self.contentView addSubview:time];
     [self.contentView addSubview:pNum];
     [self.contentView addSubview:host];
     [self.contentView addSubview:_schoolLogo];
     [self.contentView addSubview:_activityName];
     [self.contentView addSubview:_activityAddr];
     [self.contentView addSubview:_activityTime];
     [self.contentView addSubview:_activityPn];
     [self.contentView addSubview:_activityHost];
    for (id view in [self.contentView subviews]) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *lable = (UILabel *)view;
           
            lable.font = [UIFont systemFontOfSize:14.0f];
        }
    }

}
- (void)layoutSubviews
{
    [super layoutSubviews];

        _activityName.text  = self.model.title;
        _activityAddr.text  = self.model.addr ;
        _activityTime.text  = self.model.time;
        _activityPn.text    = self.model.num;
        _activityHost.text  = self.model.host;
    

    
}
@end
