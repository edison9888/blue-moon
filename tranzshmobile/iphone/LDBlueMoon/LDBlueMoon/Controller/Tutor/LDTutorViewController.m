//
//  LDTutorViewController.m
//  LDBlueMoon
//
//  Created by Lilac on 13-12-30.
//  Copyright (c) 2013年 tranzvision. All rights reserved.
//

#import "LDTutorViewController.h"
#import "ActivityDetailViewController.h"
#import "DataAccess.h"

@interface LDTutorViewController ()

@end

@implementation LDTutorViewController
@synthesize aoView;

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"活动";
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self showBackButtonItem];
    DataAccess *dataAccess= [[DataAccess alloc]init];
    NSMutableArray *dataArray = [dataAccess getDateArray];
    
    self.aoView = [[AOWaterView alloc]initWithDataArray:dataArray];
    self.aoView.clickDelegate=self;
    [self.view addSubview:self.aoView];
    [self loadData];

}

- (void)didReceiveMemoryWarning
{
   
}

-(void)loadData{
    ActivityModel *model =[[ActivityModel alloc]initWithData:nil];
    model.title     = @"弄堂游戏海选";
    model.addr      = @"上海市静安区南京西路150号";
    model.time      = @"2014年01月25日 9:00-12:00";
    model.host      = @"狮子王幼儿园";
    model.phone     = @"87654321";
    model.style     = @"高级";
    model.num       = @"0";
    model.introduce = @"20世纪的上海老房子，多是一些石库门的弄堂房子。那时候的一些小孩子，不管是男孩子、还是女孩子，都喜欢在自家的弄堂里玩一些小游戏。那些游戏虽说与现今比起来，“道具”都是自作的，很简陋，但是玩的人都很投入。对于50后、60后，甚至70后来说，弄堂游戏是他们童年欢乐的记忆和写照。";
    self.model = model;
    
}
-(void)imageClick:(DataInfo *)data
{
    
    
    ActivityDetailViewController *detailViewController = [[ActivityDetailViewController alloc]init];
    [detailViewController setHidesBottomBarWhenPushed:YES];
    detailViewController.imageName = data.url;
    detailViewController.model     = self.model;
  
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}
- (void)popNavigation{
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft
                                                           animated:YES];
}
@end
