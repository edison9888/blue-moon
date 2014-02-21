//
//  LDBaseCell.m
//  LDBlueMoon
//
//  Created by IceBoy on 14-1-17.
//  Copyright (c) 2014年 tranzvision. All rights reserved.
//

#import "LDBaseCell.h"
#import "LDContView.h"
#import "UIViewExt.h"
#import "UIImageView+WebCache.h"
@implementation LDBaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubitemViews];
       
    }
    return self;
}
-(void)initSubitemViews{
    _logoView     = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 45, 45)];
    _nickLable    = [[UILabel alloc]initWithFrame:CGRectMake(_logoView.right+5, 10, 200, 20)];
    _timeLable    = [[UILabel alloc]initWithFrame:CGRectMake(_logoView.right+5, _nickLable.bottom+5, 200, 20)];
    _contentLable = [[UILabel alloc]initWithFrame:CGRectMake(25, _logoView.bottom+5 , 270, 40)];
    _contentLable.numberOfLines = 0;
    
    _photoView = [[UIImageView alloc]initWithFrame:CGRectMake(50, _contentLable.bottom+5, 220, 150)];
    [self.contentView addSubview:_logoView];
    [self.contentView addSubview:_nickLable];
    [self.contentView addSubview:_timeLable];
    [self.contentView addSubview:_photoView];
    [self.contentView addSubview:_contentLable];
    for (id lable in [self.contentView subviews]) {
        if ([lable isKindOfClass:[UILabel class]]) {
            UILabel *labl= (UILabel*)lable;
            labl.font = [UIFont systemFontOfSize:14];
        }
    }
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [_logoView setImageWithURL:[NSURL URLWithString:@"http://www.aiimg.com/uploads/userup/0903/250U4126037.jpg"]];
    _nickLable.text    = @"Zero";
    _timeLable.text    = @"2013-1-17";
    _contentLable.text = @"跳了一天，累死我了。不过收获还是蛮多的，泽罗加油！！！";
    
    [_photoView setImageWithURL:[NSURL URLWithString:@"http://d.hiphotos.bdimg.com/album/w%3D2048/sign=1e820e093801213fcf3349dc60df34d1/48540923dd54564e01cadee9b2de9c82d0584fb6.jpg"]];
}

-(void)dealloc{
    //self.contView     = nil;
    self.logoView     = nil;
    self.nickLable    = nil;
    self.contentLable = nil;
    self.photoView    = nil;
}

@end
