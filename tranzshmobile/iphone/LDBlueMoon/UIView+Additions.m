//
//  UIView+Additions.m
//  8.12SelfSinaWeibo
//
//  Created by lceboy on 13-8-25.
//  Copyright (c) 2013年 lceboy. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)
- (UIViewController*)viewController
{
    UIResponder *next = [self nextResponder];
  
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return  (UIViewController*)next;
        }else
            next = [next nextResponder];
    } while (next !=nil);

    return nil;
}
@end
