//
//  ClassDetailViewController.h
//  LDBlueMoon
//
//  Created by IceBoy on 14-2-19.
//  Copyright (c) 2014年 tranzvision. All rights reserved.
//

#import "BaseViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
@interface ClassDetailViewController : BaseViewController<MAMapViewDelegate,AMapSearchDelegate>
@property(nonatomic,assign)CLLocationCoordinate2D locationPoint ;
@end
