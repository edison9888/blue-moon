//
//  LDSearchCityViewController.h
//  LDBlueMoon
//
//  Created by Lilac on 13-11-13.
//  Copyright (c) 2013年 tranzvision. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LDSearchCityDelegate <NSObject>

-(void)selectCity:(NSString *)city;

@end
#import "BaseViewController.h"
@interface LDSearchCityViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate>
{
    UISearchDisplayController *searchDisplayController;
    NSArray *totalCitiesObj;
    NSArray *searchResults;
}

@property(nonatomic,retain) UISearchDisplayController *searchDisplayController;
@property(nonatomic,retain) NSArray *totalCitiesObj;
@property(nonatomic,retain) NSArray *searchResults;
@property(nonatomic,assign) id<LDSearchCityDelegate>delegate;
@property(nonatomic,retain) UIWindow *window;

@end
