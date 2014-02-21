//
//  LDTwoLevelTableView.h
//  TwoLevelMenu
//
//  Created by Lilac on 13-12-26.
//  Copyright (c) 2013年 tranzvision. All rights reserved.
//
/*
 TableView 的seprator距离左边有一块空白：
 
     if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
         [_tableView setSeparatorInset:UIEdgeInsetsZero];
     }

 
 */
#import <UIKit/UIKit.h>

@protocol PullMenuDelegate <NSObject>


-(void)menuItemSelected:(NSIndexPath *)indexPath withFilterStyle:(NSString *)style;


@end

@interface LDTwoLevelTableView : UIView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain) UITableView *level0TableView;
@property(nonatomic,retain) UITableView *level1TableView;
@property(nonatomic,retain) NSArray *dataDicArray;
@property(nonatomic,retain) NSMutableArray *level0Array;
@property(nonatomic,retain) NSArray *level1Array;
@property(nonatomic,retain) UIButton *dropdownBtn;
@property(nonatomic,retain) id<PullMenuDelegate>delegate;
@property(nonatomic,assign) BOOL isOpen;
// Lilac: (0120)
@property(nonatomic,assign) BOOL isTwoLevel;
@property(nonatomic,assign) NSInteger selected;

-(void)animatePullUp;

@end
