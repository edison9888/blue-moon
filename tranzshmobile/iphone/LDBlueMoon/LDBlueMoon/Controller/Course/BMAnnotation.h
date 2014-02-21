//
//  BMAnnotation.h
//  LDBlueMoon
//
//  Created by IceBoy on 14-2-19.
//  Copyright (c) 2014年 tranzvision. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import "BaseDataModel.h"
@interface BMAnnotation : NSObject<MAAnnotation>
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic,  copy) NSString *title;
@property (nonatomic,  copy) NSString *subtitle;
@property (nonatomic,strong)ClassModel *model;
-(id)initAnnotationWith:(ClassModel*)classModel;
@end
