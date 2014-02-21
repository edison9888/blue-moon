

#import "LDAppDelegate.h"
#import "HomeViewController.h"
#import "BaseNavigationController.h"
@implementation LDAppDelegate

@synthesize viewDelegate = _viewDelegate;
@synthesize loginStatus;
@synthesize reachability;
@synthesize tabBarController;

@synthesize shareDic;

// Lilac: 高德地图的apiKey。
- (void)configureAPIKey
{
    if ([APIKey length] == 0)
    {
        NSString *name   = [NSString stringWithFormat:@"\nSDKVersion:%@\nFILE:%s\nLINE:%d\nMETHOD:%s", [MAMapServices sharedServices].SDKVersion, __FILE__, __LINE__, __func__];
        NSString *reason = [NSString stringWithFormat:@"请首先配置APIKey.h中的APIKey, 申请APIKey参考见 http://api.amap.com"];
        
        @throw [NSException exceptionWithName:name
                                       reason:reason
                                     userInfo:nil];
    }
    
    [MAMapServices sharedServices].apiKey = (NSString *)APIKey;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _viewDelegate = [[AGViewDelegate alloc]init];
    self.loginStatus = 0;
    reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [reachability startNotifier];
    

        [ShareSDK registerApp:@"ea67c2169e0"];
        
        // 添加新浪微博应用
        [ShareSDK connectSinaWeiboWithAppKey:@"2861504436"
                                   appSecret:@"d3e276987647a73249932bca9175abcc"
                                 redirectUri:@"https://api.weibo.com/oauth2/default.html"];
        
        // 添加qq应用
        [ShareSDK connectQZoneWithAppKey:@"100554010"
                               appSecret:@"55dd9ab3bb016e6bc2ee45deb323c9f6"];
        
        // 添加人人网应用
        [ShareSDK connectRenRenWithAppKey:@"4cc389e8ca45413bad063ad35c199d52"
                                appSecret:@"a175892d4299455bb7c15f9e9796a69b"];
        
        
    //    [Parse setApplicationId:@"MKs5AeGmHYl1igaSS1VbIWhhAISnWnDDT6Jq22Zm"
    //                  clientKey:@"J5D68sH4M6KVxqRAyFijlWIMgZVciTytvP6na95M"];
        
        
        [ShareSDK authWithType:ShareTypeSinaWeibo                   //需要授权的平台类型
                       options:nil                                  //授权选项，包括视图定制，自动授权
                        result:^(SSAuthState state, id<ICMErrorInfo> error) {   //授权返回后的回调方法
                            if (state == SSAuthStateSuccess)
                            {
                                NSLog(@"成功");
                            }
                            else if (state == SSAuthStateFail)
                            {
                                NSLog(@"失败");
                            }
                        }];
        

        
        // Lilac：高德地图的apiKey。
        [self configureAPIKey];
        
        shareDic = [[NSMutableDictionary alloc]init];

    _mainViewController = [[MainViewController alloc] initWithTabBarHeight:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 70 : 50];
    [_mainViewController setMinimumHeightToDisplayTitle:40.0];
    HomeViewController  *homeVctr = [[HomeViewController alloc]init];
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:homeVctr];
    
    
    __revealSideViewController = [[PPRevealSideViewController alloc]initWithRootViewController:nav];
    self.window.rootViewController = __revealSideViewController;

    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{

}

//监听到网络状态改变
- (void) reachabilityChanged: (NSNotification* )note

{
    
    Reachability* curReach = [note object];
    
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    
    [self updateInterfaceWithReachability: curReach];
    
}

- (void) updateInterfaceWithReachability: (Reachability*) curReach

{
    //对连接改变做出响应的处理动作。
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if(status == kReachableViaWWAN)
    {
        printf("\n3g/2G\n");
        
    }else if(status == kReachableViaWiFi)
    {
        
        printf("\nwifi\n");
    }else{
       
        printf("\n无网络\n");
    }
    
}

@end
