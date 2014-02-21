//
//  SchoolCell.h
//  tz_bluemoon_ios_iphone
//
//  Created by IceBoy on 13-12-31.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDataModel.h"
@interface SchoolCell : UITableViewCell
@property (nonatomic,strong)UIImageView *schoolLogo;
@property (nonatomic,strong)UILabel     *schoolName;
@property (nonatomic,strong)UILabel     *schoolNature;
@property (nonatomic,strong)UILabel     *phoneLable;//以后需要换成RTlable;
@property (nonatomic,strong)UILabel     *addrlabel;

@property (nonatomic,strong)SchoolModel *model;
@end
