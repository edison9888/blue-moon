//
//  LDIconCaptureViewController.h
//  LDBlueMoon
//
//  Created by Lilac on 13-12-19.
//  Copyright (c) 2013年 tranzvision. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AGSimpleImageEditorView.h"

@protocol PassImageDelegate <NSObject>

-(void)passImage:(UIImage *)image;

@end

@interface LDIconCaptureViewController : UIViewController

@property(nonatomic,retain) AGSimpleImageEditorView *editorView;
@property(nonatomic,retain) UIImage *originImg;
@property(nonatomic,retain) id<PassImageDelegate> delegate;

@end
