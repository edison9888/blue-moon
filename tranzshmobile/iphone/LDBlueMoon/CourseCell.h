//
//  ClassCell.h
//  tz_bluemoon_ios_iphone
//
//  Created by IceBoy on 13-12-23.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDataModel.h"
@interface CourseCell : UITableViewCell
@property(nonatomic,strong)ClassModel *model;

@property(nonatomic,strong)UIImageView *classPhoto;
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UILabel *timeLable;
@property(nonatomic,strong)UILabel *addrLable;
@property(nonatomic,strong)UILabel *nowPriceLable;
@property(nonatomic,strong)UILabel *oldPriceLable;
@property(nonatomic,strong)UILabel *numLable;
@property(nonatomic,strong)UILabel *categoryL;
@end
