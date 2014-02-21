//
//  LDSearchResultViewController.h
//  LDBlueMoon
//
//  Created by Lilac on 13-12-26.
//  Copyright (c) 2013年 tranzvision. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LDTwoLevelTableView.h"
#import "BaseViewController.h"
#import "ASIHTTPRequest.h"

@interface LDSearchResultViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,PullMenuDelegate>

@property(nonatomic,retain) NSString *keyWord;
@property(nonatomic,retain) UISegmentedControl *titleSegment;
@property(nonatomic,retain) UITableView *searchResultTableView;
@property(nonatomic,retain) UIButton *categoryBtn;
@property(nonatomic,retain) UIButton *placeBtn;
@property(nonatomic,retain) UIButton *orderBtn;

@property(nonatomic,retain) LDTwoLevelTableView *twoLevelTableView;

@end
