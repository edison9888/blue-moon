//
//  LDBaseCell.h
//  LDBlueMoon
//
//  Created by IceBoy on 14-1-17.
//  Copyright (c) 2014年 tranzvision. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LDContView;
@interface LDBaseCell : UITableViewCell
//@property(nonatomic,retain)LDContView  *contView;
@property(nonatomic,strong)UIImageView *logoView;
@property(nonatomic,strong)UILabel     *nickLable;
@property(nonatomic,strong)UILabel     *contentLable;
@property(nonatomic,strong)UIImageView *photoView;
@property(nonatomic,strong)UILabel     *timeLable;
@end
