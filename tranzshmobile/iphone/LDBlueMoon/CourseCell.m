
#import "CourseCell.h"
#import "UIImageView+WebCache.h"
#import "UIViewExt.h"
#define FONT_SIZEA 14
#define FONT_SIZEB 14
#define FONT_SIZEC 14
#define FONT_SIZED 14

@implementation CourseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
    }
    return self;
}
-(void)dealloc{
    self.classPhoto    = nil;
    self.addrLable     = nil;
    
    self.nowPriceLable = nil;
    self.oldPriceLable = nil;
    self.numLable      = nil;
    self.timeLable     = nil;
    
}
-(void)initSubViews{
    
    UIImageView *photoView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 90, 90)];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(photoView.right+5, 10, 180, 20)];
    UILabel *time  = [[UILabel alloc]initWithFrame:CGRectMake(photoView.right+5, title.bottom+5, 130, 20)];
    UILabel *addr  = [[UILabel alloc]initWithFrame:CGRectMake(time.right, title.bottom+5,60, 20)];
    UILabel *newL  = [[UILabel alloc]initWithFrame:CGRectMake(photoView.right+5, time.bottom+5, 80, 20)];
    UILabel *oldL  = [[UILabel alloc]initWithFrame:CGRectMake(newL.right, time.bottom+5, 80,20)];
    UILabel *category = [[UILabel alloc]initWithFrame:CGRectMake(photoView.right+5, oldL.bottom+5, 40, 20)];
    self.categoryL = category;
    
    UILabel *num   = [[UILabel alloc]initWithFrame:CGRectMake(photoView.right+5, oldL.bottom+5,130,20)];
    UIView *line   = [[UIView alloc]initWithFrame:CGRectMake(newL.right-10, time.bottom+15, 80, 1)];

    line.backgroundColor = [UIColor blackColor];

    
    [self.contentView addSubview:title];
    [self.contentView addSubview:time];
    [self.contentView addSubview:addr];
    [self.contentView addSubview:oldL];
    [self.contentView addSubview:newL];
    [self.contentView addSubview:num];
    [self.contentView addSubview:photoView];
  
    [self.contentView addSubview:category];
    
    self.titleLable    = title;
    self.titleLable.font = [UIFont boldSystemFontOfSize:FONT_SIZEA];
    self.titleLable.textColor = [UIColor grayColor];
    self.categoryL.font = [UIFont systemFontOfSize:14];
    
 
    self.timeLable     = time;
    self.timeLable.font =[UIFont systemFontOfSize:FONT_SIZEC];
  
    self.addrLable     = addr;
    self.addrLable.font = [UIFont systemFontOfSize:FONT_SIZEC];
    
    self.oldPriceLable = oldL;
    self.oldPriceLable.font = [UIFont systemFontOfSize:FONT_SIZEC];
    
    self.nowPriceLable = newL;
    self.nowPriceLable.font = [UIFont systemFontOfSize:FONT_SIZEC];
    self.nowPriceLable.textColor = [UIColor grayColor];
   
    self.numLable      = num,
    self.numLable.font = [UIFont systemFontOfSize:FONT_SIZEC];

    self.classPhoto    = photoView;
    
    


}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLable.text    = self.model.title;
    self.timeLable.text     = self.model.time;
    self.addrLable.text     = self.model.addr;
    self.nowPriceLable.text = self.model.nowPrice;
    self.oldPriceLable.text = self.model.oldPrice;
 //   self.categoryL.text     = @"音乐";
    self.numLable.text      = [NSString stringWithFormat:@"已有%@人报名",self.model.num];
  
    [self.classPhoto setImageWithURL:[NSURL URLWithString:self.model.photoUrl]];
}
@end
