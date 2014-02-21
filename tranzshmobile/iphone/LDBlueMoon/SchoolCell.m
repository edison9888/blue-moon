//
//  SchoolCell.m
//  tz_bluemoon_ios_iphone
//
//  Created by IceBoy on 13-12-31.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "SchoolCell.h"
#import "UIViewExt.h"
#import "UIImageView+WebCache.h"
@implementation SchoolCell

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
    //学校logo
    
    _schoolLogo       = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 90)];
    
    _schoolName       = [[UILabel alloc]initWithFrame:CGRectMake(_schoolLogo.right+10, 10, 200, 20)];
    _schoolName.font  = [UIFont systemFontOfSize:14];
    
    //
    UILabel *nature   =
    [[UILabel alloc]initWithFrame:CGRectMake(_schoolLogo.right+5, _schoolName.bottom+5, 40, 20)];
    nature.text       = @"课程:";
    nature.font       = [UIFont systemFontOfSize:14];
    
    
    _schoolNature     =
    [[UILabel alloc]initWithFrame:CGRectMake(nature.right+10, _schoolName.bottom+5, 200, 20)];
    _schoolNature.font = [UIFont systemFontOfSize:14];
    
    //电话标签
    
    UILabel *phone =
    [[UILabel alloc]initWithFrame:CGRectMake(_schoolLogo.right+5, _schoolNature.bottom+5, 40, 20)];
    phone.text     = @"电话:";
    phone.font     = [UIFont systemFontOfSize:14];
    
    //电话
    
    _phoneLable    =
    [[UILabel alloc]initWithFrame:CGRectMake(phone.right+10,_schoolNature.bottom+5, 200, 20)];
    _phoneLable.font     = [UIFont systemFontOfSize:14];
    
    //地址标签
    
    UILabel *addr =
    [[UILabel alloc]initWithFrame:CGRectMake(_schoolLogo.right+5, _phoneLable.bottom+5, 40, 20)];
    addr.text     = @"地址:";
    addr.font  = [UIFont systemFontOfSize:14];
    
    //地址
    
    _addrlabel =
    [[UILabel alloc]initWithFrame:CGRectMake(addr.right+5, _phoneLable.bottom+5, 160, 20)];
    _addrlabel.numberOfLines = 0;
    _addrlabel.font     = [UIFont systemFontOfSize:14];
    _addrlabel.text = @"宝华晶典501室";
    
    [self.contentView addSubview:addr];
    [self.contentView addSubview:nature];
    [self.contentView addSubview:phone];
    
    [self.contentView addSubview:_schoolNature];
    [self.contentView addSubview:_schoolName];
    [self.contentView addSubview:_schoolLogo];
    [self.contentView addSubview:_phoneLable];
    [self.contentView addSubview:_addrlabel];

    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    _schoolNature.text = self.model.nature;
    _schoolName.text   = self.model.name;
    [_schoolLogo setImageWithURL:[NSURL URLWithString:self.model.logoUrl]];
    _phoneLable.text   = self.model.phoneNum;
}
@end
