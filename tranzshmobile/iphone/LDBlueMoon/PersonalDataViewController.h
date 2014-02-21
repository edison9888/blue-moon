//
//  PersonalDataViewController.h
//  tz_bluemoon_ios_iphone
//
//  Created by IceBoy on 13-12-23.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "BaseViewController.h"

@interface PersonalDataViewController : BaseViewController<UITextFieldDelegate>
@property(nonatomic,retain)UILabel *nickLabel;
@property(nonatomic,retain)UILabel *sexLable;
@property(nonatomic,retain)UILabel *phoneLabel;
@property(nonatomic,retain)UILabel *addrLabel;
@property(nonatomic,retain)UILabel *mailLabel;
@property(nonatomic,retain)UILabel *ageLabel;
@property(nonatomic,retain)UILabel *authorMangerLabel;


@property(nonatomic,retain)UITextField *nickField;
@property(nonatomic,retain)UITextField *sexField;
@property(nonatomic,retain)UITextField *ageField;
@property(nonatomic,retain)UITextField *addrField;
@property(nonatomic,retain)UITextField *mailField;
@property(nonatomic,retain)UITextField *phoneField;

@property(nonatomic,retain)UIButton *editButton;
@property(nonatomic,retain)UIButton *cancleButton;
@property(nonatomic,retain)UIButton *saveButton;




@end
