//
//  HotCourseCell.h
//  LDBlueMoon
//
//  Created by IceBoy on 14-2-8.
//  Copyright (c) 2014年 tranzvision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDataModel.h"
@interface HotCourseCell : UITableViewCell
@property (nonatomic,strong)ClassModel *model;
@property(nonatomic,strong)UIImageView *courseImageView;
@property(nonatomic,strong)UIImageView *logoimageView;
@property(nonatomic,strong)UILabel     *titleName;
@property(nonatomic,strong)UILabel     *proLable;
@property(nonatomic,strong)UILabel     *preferLable;
@property(nonatomic,strong)UILabel     *commentLable;
@end
