//
//  LDSearchCourseViewController.h
//  LDBlueMoon
//
//  Created by Lilac on 13-12-25.
//  Copyright (c) 2013年 tranzvision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDSearchResultViewController.h"
#import "BaseViewController.h"
#import "ASIHTTPRequest.h"

@interface LDSearchCourseViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate>


@property(nonatomic,retain) UISearchDisplayController *searchDisplayController;
@property(nonatomic,retain) NSArray *tagArray;
@property(nonatomic,retain) NSString *tagStr;

@end
