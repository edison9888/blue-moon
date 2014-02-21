

#import "HotCourseCell.h"
#import "UIImageView+WebCache.h"
#import "AMBlurView.h"
#import "UIViewExt.h"
@implementation HotCourseCell

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
    //大图
    UIColor *color = GrayColor;
    UIView *view   = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, 250)];
    view.backgroundColor   = color;
    [self.contentView addSubview:view];
    
    _courseImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, 204)];
    
    //小图
    _courseImageView.clipsToBounds = YES;
    _courseImageView.contentMode   = UIViewContentModeScaleAspectFill;
    _courseImageView.userInteractionEnabled = YES;
    

    
    //标题
    _titleName                 =
    [[UILabel alloc]initWithFrame:CGRectMake(10, 168+8, 200, 20)];
    _titleName.font            = [UIFont boldSystemFontOfSize:18];
    _titleName.textColor       = [UIColor whiteColor];
    _titleName.backgroundColor = [UIColor clearColor];
    //hot
    _logoimageView   =
    [[UIImageView alloc]initWithFrame:CGRectMake(280, 168+4.5, 27, 27)];
    _logoimageView.userInteractionEnabled = YES;

    UIButton *hotButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [hotButton setImage:[UIImage imageNamed:@"heart_btn.png"] forState:UIControlStateNormal];
    [hotButton setImage:[UIImage imageNamed:@"heart_btn_selected.png"]
               forState:UIControlStateHighlighted];
    hotButton.frame = CGRectMake(6, 6, 16, 16);
  
    [_logoimageView addSubview:hotButton];
    //介绍
    _proLable        =
    [[UILabel alloc]initWithFrame:CGRectMake(10, _courseImageView.bottom+5, 160, 20)];
    _proLable.backgroundColor     = [UIColor clearColor];
    _proLable.numberOfLines       = 0;
    _proLable.font                = [UIFont systemFontOfSize:14];
    
    //线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _courseImageView.bottom, KSCreen_Width, 36)];
    lineView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:lineView];
    
    
    UIImageView *preferView =
    [[UIImageView alloc]initWithFrame:CGRectMake(235, _courseImageView.bottom+10, 16, 16)];
    
    [preferView setImage:[UIImage imageNamed:@"comment_icon.png"]];   //关注
    _preferLable      =
    [[UILabel alloc]initWithFrame:CGRectMake(preferView.right+5, _courseImageView.bottom+8,40, 20)];
    _preferLable.numberOfLines    = 0;
    _preferLable.backgroundColor  = [UIColor clearColor];
    _preferLable.font = [UIFont systemFontOfSize:14];

    
    UIImageView *commentView =
    [[UIImageView alloc]initWithFrame:CGRectMake(283, _courseImageView.bottom+10, 16, 16)];
    
    [commentView setImage:[UIImage imageNamed:@"more_btn.png"]];
    //评论
    _commentLable    =
    [[UILabel alloc]initWithFrame:CGRectMake(commentView.right+8,_courseImageView.bottom+15, 50, 20)];
    _commentLable.font = [UIFont systemFontOfSize:14];
    _commentLable.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:_courseImageView];
    
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 168, KSCreen_Width, 36)];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0.6;
    [_courseImageView addSubview:backgroundView];

    [self.contentView addSubview:_logoimageView];
    [self.contentView addSubview:_titleName];
    [self.contentView addSubview:_proLable];
    [self.contentView addSubview:_preferLable];

    [self.contentView addSubview:preferView];
    [self.contentView addSubview:commentView];
}
- (void)layoutSubviews
{
    [_courseImageView setImageWithURL:[NSURL URLWithString:self.model.photoUrl]];
    
    _logoimageView .image = [UIImage imageNamed:@"heart_bg.png"];
    
    _titleName.text = self.model.title;
   
    [_proLable setText:self.model.time];
    
    _preferLable.text  = @"19";
    
   
    
   
}
@end
