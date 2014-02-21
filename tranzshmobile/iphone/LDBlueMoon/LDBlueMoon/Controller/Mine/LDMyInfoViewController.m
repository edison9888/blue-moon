//
//  LDMyInfoViewController.m
//  LDBlueMoon
//
//  Created by Lilac on 13-11-14.
//  Copyright (c) 2013年 tranzvision. All rights reserved.
//

#import "LDMyInfoViewController.h"
#import <ShareSDK/ShareSDK.h>


@interface LDMyInfoViewController ()

@property (nonatomic,retain)UIButton *logoutBtn;

@end

@implementation LDMyInfoViewController
@synthesize logoutBtn;
@synthesize iconImageView;
@synthesize iconBtn;


- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< 我的" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
        [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
        self.iconBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 80, 82, 82)];
        self.logoutBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 350, 180, 30)];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [iconBtn setBackgroundColor:[UIColor lightGrayColor]];
    [iconBtn setBackgroundImage:[UIImage imageNamed:@"test.png"] forState:UIControlStateNormal];
    
    /* Lilac: 设置button上字体属性
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc]initWithString:@"点击更换头像"];
    [attriString addAttribute:(NSString *)kCTForegroundColorAttributeName
                        value:(id)[UIColor grayColor].CGColor
                        range:NSMakeRange(0, 6)];
    [attriString addAttribute:(NSString *)kCTFontAttributeName
                        value:(id)CFBridgingRelease(CTFontCreateWithName((CFStringRef)[UIFont boldSystemFontOfSize:14].fontName,                                                  14,NULL))
                        range:NSMakeRange(0, 6)];
    [iconBtn setAttributedTitle:attriString forState:UIControlStateNormal]; 
     */
    [iconBtn addTarget:self action:@selector(iconBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:iconBtn];
    
    
    [logoutBtn setBackgroundColor:[UIColor grayColor]];
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(logoutBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:logoutBtn];

}

-(void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)iconBtnPressed:(id)sender
{
    UIActionSheet *chooseImageSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机拍照",@"从相册选取", nil];
//    [chooseImageSheet showInView:self.view];
    // Lilac: fix UIActionSheet的最后一项点击失效，点最后一项的上半区域时有效的bug. 如下，或者[sheet showInView:[AppDelegate sharedDelegate].tabBarController.view]; (1219)
    [chooseImageSheet showInView:[UIApplication sharedApplication].keyWindow];
}

-(void)logoutBtnPressed:(id)sender
{
    LDAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    appDelegate.loginStatus = 1;
    
    NSString *filePath = [self baseDataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        // 使用归档方法持久化
        NSData *data = [[NSMutableData alloc] initWithContentsOfFile:[self baseDataFilePath]];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
        LDBaseData *baseData = [unarchiver decodeObjectForKey:kBaseDataKey];
        [unarchiver finishDecoding];
        
        LDBaseData *logoutBaseData = [[LDBaseData alloc]init];
        logoutBaseData.tsNickname = baseData.tsNickname;
        logoutBaseData.tsIconURL = baseData.tsIconURL;
        logoutBaseData.login = [NSNumber numberWithInteger:1];
        
        NSMutableData *logoutData = [[NSMutableData alloc] init];
        NSKeyedArchiver *logoutArchiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:logoutData];
        
        [logoutArchiver encodeObject:logoutBaseData forKey:kBaseDataKey];
        [logoutArchiver finishEncoding];
        
        [logoutData writeToFile:filePath atomically:YES];

        NSLog(@"%@ %@ %@", baseData.tsNickname, baseData.tsIconURL,baseData.login);
        
    }
    
    
    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
    [ShareSDK cancelAuthWithType:ShareTypeQQSpace];
    [ShareSDK cancelAuthWithType:ShareTypeRenren];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UIActionSheetDelegate Method
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = (id)self;
    
    switch (buttonIndex) {
        case 0://Take picture
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                
            }else{
                NSLog(@"模拟器无法打开相机");
            }
            [self presentViewController:picker animated:YES completion:NULL];
            break;
            
        case 1://From album
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:NULL];
            break;
            
        default:
            break;
    }
}

// Lilac: 添加修改头像的方法。(1219)
#pragma 拍照选择照片协议方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    NSData *data;
    
    if ([mediaType isEqualToString:@"public.image"]){
        
        //切忌不可直接使用originImage，因为这是没有经过格式化的图片数据，可能会导致选择的图片颠倒或是失真等现象的发生，从UIImagePickerControllerOriginalImage中的Origin可以看出，很原始，哈哈
        UIImage *originImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        //图片压缩，因为原图都是很大的，不必要传原图
        UIImage *scaleImage = [self scaleImage:originImage toScale:0.3];
        
        //以下这两步都是比较耗时的操作，最好开一个HUD提示用户，这样体验会好些，不至于阻塞界面
        if (UIImagePNGRepresentation(scaleImage) == nil) {
            //将图片转换为JPG格式的二进制数据
            data = UIImageJPEGRepresentation(scaleImage, 1);
        } else {
            //将图片转换为PNG格式的二进制数据
            data = UIImagePNGRepresentation(scaleImage);
        }
        
        //将二进制数据生成UIImage
        UIImage *image = [UIImage imageWithData:data];
        
        //将图片传递给截取界面进行截取并设置回调方法（协议）
        LDIconCaptureViewController *captureView = [[LDIconCaptureViewController alloc] init];
        captureView.delegate = self;
        captureView.originImg = image;
        //隐藏UIImagePickerController本身的导航栏
        picker.navigationBar.hidden = YES;
        [picker pushViewController:captureView animated:YES];
        
    }
}

#pragma mark - 图片回传协议方法
-(void)passImage:(UIImage *)image
{
    //将截取的图片显示在主界面
    iconImageView.image = image;
}

#pragma mark- 缩放图片
-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

// Lilac: end.(1219)

#pragma mark Achive Methods

- (NSString *)baseDataFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:kBaseDataFileName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
