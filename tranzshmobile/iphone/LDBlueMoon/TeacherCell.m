
#import "TeacherCell.h"
#import "UIViewExt.h"
#import "UIImageView+WebCache.h"

@implementation TeacherCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    _headerView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    _nameLable  = [[UILabel alloc]initWithFrame:CGRectMake(_headerView.right+10, 10, 200, 20)];
    _sexLable   =
    [[UILabel alloc]initWithFrame:CGRectMake(_headerView.right+10, _nameLable.bottom+5, 100, 20)];
    _classLable =
    [[UILabel alloc]initWithFrame:CGRectMake(_headerView.right+10,_sexLable.bottom+5, 200, 20)];
    
    [self.contentView addSubview:_headerView];
    [self.contentView addSubview:_nameLable];
    [self.contentView addSubview:_sexLable];
    [self.contentView addSubview:_classLable];
    
    for (id view in [self.contentView subviews]) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *lable = (UILabel*)view;
            lable.font = [UIFont systemFontOfSize:14];
        }
    }
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_headerView setImageWithURL:[NSURL URLWithString:self.model.actorUrl]];
    if (self.model!=nil) {
        _nameLable.text  = self.model.name;
        _sexLable.text   = self.model.sex;
        _classLable.text = self.model.className;
    };

}

@end
