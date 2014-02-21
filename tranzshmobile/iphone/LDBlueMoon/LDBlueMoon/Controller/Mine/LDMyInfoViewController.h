//
//  LDMyInfoViewController.h
//  LDBlueMoon
//
//  Created by Lilac on 13-11-14.
//  Copyright (c) 2013年 tranzvision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

#import "LDAppDelegate.h"
#import "LDBaseData.h"

#import "LDIconCaptureViewController.h"


@interface LDMyInfoViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,PassImageDelegate>


@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UIButton *iconBtn;

@end
