//
//  LDClassTableCell.m
//  LDBlueMoon
//
//  Created by IceBoy on 14-2-17.
//  Copyright (c) 2014年 tranzvision. All rights reserved.
//

#import "LDClassTableCell.h"
#import "UIImageView+WebCache.h"
#import "UIViewExt.h"
#import "LDAppDelegate.h"
#import "ApplyViewController.h"
#import "UIView+Additions.h"
@implementation LDClassTableCell

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
    //背景
    
    UIColor *color = GrayColor;
    UIView *view   = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, 85)];
    view.backgroundColor   = color;
    [self.contentView addSubview:view];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KSCreen_Width, 82)];
    imageView.userInteractionEnabled = YES;
    
    imageView.image = [UIImage imageNamed:@"choClass_cell_bg.png"];
    [self.contentView addSubview:imageView];

    
    //班级名称
    
    self.nameLable      = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 120, 20)];
    self.nameLable.font = [UIFont boldSystemFontOfSize:18];
    
    
    //老师
    
    UIButton *p_view = [UIButton buttonWithType:UIButtonTypeCustom];
     p_view.frame    = CGRectMake(10, self.nameLable.bottom+5+1.5, 17, 17);
     p_view.userInteractionEnabled = YES;
    [p_view setImage:[UIImage imageNamed:@"teacher_btn.png"] forState:UIControlStateNormal];
    [p_view addTarget:self action:@selector(caonima:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *teacherName =
    [[UILabel alloc]initWithFrame:CGRectMake(p_view.right+5, self.nameLable.bottom+5, 100, 20)];
    teacherName.font = [UIFont systemFontOfSize:14];
    teacherName.text = @"刘老师";
    teacherName.textColor = [UIColor grayColor];
    [self.contentView addSubview:teacherName];
    [self.contentView addSubview:p_view];
    
    //地址
  
    UIImageView *locView =
    [[UIImageView alloc]initWithFrame:CGRectMake(10, teacherName.bottom+5+1.5,17, 17)];
    locView.image        = [UIImage imageNamed:@"location_btn.png"];
    [self.contentView addSubview:locView];
    self.addrLable       =
    [[UILabel alloc]initWithFrame:CGRectMake(locView.right+5, teacherName.bottom+5, 220, 20)];
    self.addrLable.font      = [UIFont systemFontOfSize:14];
    self.addrLable.textColor = [UIColor grayColor];
    
    //报名人数
    self.numLabe        =
    [[UILabel alloc]initWithFrame:CGRectMake(self.nameLable.right, 10, 100, 20)];
    self.numLabe.textAlignment = NSTextAlignmentRight;
    self.numLabe.textColor     = [UIColor grayColor];
    self.numLabe.font          = [UIFont systemFontOfSize:13];
    
    //课程表
    
    UIImageView *calenderView = [[UIImageView alloc ]initWithFrame:CGRectMake(teacherName.right, self.nameLable.bottom+5+1.5, 17, 17)];
    calenderView.image = [UIImage imageNamed:@"calendar_btn.png"];
    calenderView.userInteractionEnabled = YES;
    
    UILabel *calender =
    [[UILabel alloc]initWithFrame:CGRectMake(calenderView.right+5,self.nameLable.bottom+5,100, 20)];
    calender.font = [UIFont systemFontOfSize:13];
    calender.text = @"2014-03-07";
    calender.textColor = [UIColor grayColor];
    [self.contentView addSubview:calender];
    
    
    UIButton *signUp = [UIButton buttonWithType:UIButtonTypeCustom];
        signUp.frame = CGRectMake(250, 29, 59, 24);
    signUp.highlighted = YES;
    [signUp setImage:[UIImage imageNamed:@"classList_signup_btn.png"] forState:UIControlStateNormal];
    [signUp setImage:[UIImage imageNamed:@"classList_signup_btn_pressed.png"] forState:UIControlStateHighlighted];
    [signUp addTarget:self action:@selector(signUp:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(3, 2, 53, 20)];
    title.text = @"马上报名";
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont systemFontOfSize:13];
    [signUp addSubview:title];
    
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(caonima:)];

    [calenderView addGestureRecognizer:tap];
    
    

    
    [p_view addGestureRecognizer:tap];
     p_view.userInteractionEnabled =YES;
    
    [self.contentView addSubview:self.photoView];
    [self.contentView addSubview:self.nameLable];
    [self.contentView addSubview:self.addrLable];
    [self.contentView addSubview:self.numLabe];
    [self.contentView addSubview:calenderView];
    [self.contentView addSubview:signUp];

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.photoView setImageWithURL:[NSURL URLWithString:@"http://10.10.1.202/users/appserver/images/4afc61ba11926e2c1cd57404eb9d8918?t[]=resize%3Awidth%3D280&accessToken=b05dbd8fe3c085df9a4322ddd9aaed70523db593659f0ba3ee92024e1b331084"]];
    self.nameLable.text  = @"精品小班A班";
    self.addrLable.text  = @"徐汇区虹桥路1号";
    self.numLabe.text    = @"94人报名";
    
}
- (void)caonima:(UITapGestureRecognizer*)sender
{
    LDAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    UIWindow *window     = [appDelegate window];
    UIView *view         = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = .7;
   
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [window addSubview:view];
    
    view.tag = 102;
    [view addSubview:tableView];
    self.view = view;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame     = CGRectZero;
    button.tag       = 101;
    [button setTitle:@"X" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    [UIView animateWithDuration:.3 animations:^{
        view.frame      = CGRectMake(0, 0, KSCreen_Width, KSCreen_Height);
        tableView.frame = CGRectMake(40, 124, 240, 300);
        button.frame    = CGRectMake(tableView.left-30, tableView.top-30, 30, 30);
    }];
}
-(void)cancle
{
   
    UIButton *button       = (UIButton*)[self.view viewWithTag:101];
    UITableView *tableView = (UITableView*)[self.view viewWithTag:102];

    [UIView animateWithDuration:.3 animations:^{
        self.view.frame = CGRectZero;
        tableView.frame = CGRectZero;
        button.frame    = CGRectZero;
    } completion:^(BOOL finished) {
        
        [tableView removeFromSuperview];
        [button    removeFromSuperview];
        [self.view removeFromSuperview];
         self.view = nil;

    }];
}
- (void)signUp:(UIButton*)sender
{
    ApplyViewController *applyVctr = [[ApplyViewController alloc]init];
    [sender.viewController.navigationController pushViewController:applyVctr animated:YES];
    
}
@end
