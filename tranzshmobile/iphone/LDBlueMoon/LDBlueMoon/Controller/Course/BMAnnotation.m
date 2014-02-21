//
//  BMAnnotation.m
//  LDBlueMoon
//
//  Created by IceBoy on 14-2-19.
//  Copyright (c) 2014年 tranzvision. All rights reserved.
//

#import "BMAnnotation.h"

@implementation BMAnnotation
-(id)initAnnotationWith:(ClassModel*)classModel
{
    if (self = [super init]) {
        self.model = classModel;
    }
    return self;
}

-(void)setModel:(ClassModel *)model{
    _model = model;
    
    
    
}
-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate{
    _coordinate = newCoordinate;
    
}

@end
