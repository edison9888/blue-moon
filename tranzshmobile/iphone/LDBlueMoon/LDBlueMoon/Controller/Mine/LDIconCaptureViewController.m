//
//  LDIconCaptureViewController.m
//  LDBlueMoon
//
//  Created by Lilac on 13-12-19.
//  Copyright (c) 2013年 tranzvision. All rights reserved.
//

#import "LDIconCaptureViewController.h"

@interface LDIconCaptureViewController ()

@end

@implementation LDIconCaptureViewController
@synthesize editorView;
@synthesize originImg;
@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //添加导航栏和完成按钮
    UINavigationBar *naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [self.view addSubview:naviBar];
    
    UINavigationItem *naviItem = [[UINavigationItem alloc] initWithTitle:@"图片裁剪"];
    [naviBar pushNavigationItem:naviItem animated:YES];
    
    //保存按钮
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(saveButton)];
    naviItem.rightBarButtonItem = doneItem;
    
    //image为上一个界面传过来的图片资源
    editorView = [[AGSimpleImageEditorView alloc] initWithImage:self.originImg];
    editorView.frame = CGRectMake(0, 0, self.view.frame.size.width ,  self.view.frame.size.width);
    editorView.center = self.view.center;
    
    //外边框的宽度及颜色
    editorView.borderWidth = 1.f;
    editorView.borderColor = [UIColor blackColor];
    
    //截取框的宽度及颜色
    editorView.ratioViewBorderWidth = 5.f;
    editorView.ratioViewBorderColor = [UIColor orangeColor];
    
    //截取比例，我这里按正方形1:1截取（可以写成 3./2. 16./9. 4./3.）
    editorView.ratio = 1;
    
    [self.view addSubview:editorView];
}

//完成截取
-(void)saveButton
{
    //output为截取后的图片，UIImage类型
    UIImage *resultImage = editorView.output;
    
    //通过代理回传给上一个界面显示
    [self.delegate passImage:resultImage];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
