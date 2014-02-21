//
//  LDMyLoginViewController.h
//  LDBlueMoon
//
//  Created by Lilac on 13-11-6.
//  Copyright (c) 2013年 tranzvision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

#import <ShareSDK/ShareSDK.h>
#import "LDAppDelegate.h"


#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h" 

#import "Constant.h"
#import "BaseViewController.h"

@protocol LDThirdPartyLoginDelegate <NSObject>

-(void)getThirdPartyLoginInfo:(id<ISSUserInfo>) userInfo;

@end

@class LGModelData;
typedef void (^MyBlock)(LGModelData *value);

@interface LDMyLoginViewController : BaseViewController<UITextFieldDelegate>

@property (nonatomic,assign) id<LDThirdPartyLoginDelegate>delegate;
@property (nonatomic,strong) MBProgressHUD *mbProgress;
@property (nonatomic,strong) LDAppDelegate *appDelegate;
@property (nonatomic,strong) UIWindow *window;
@property (nonatomic,strong) MyBlock valueBlock;
-(id)initWithBlock:(MyBlock)block;

@end
