//
//  AppDelegate.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/3.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "AppDelegate.h"
#import "UDObject.h"
#import "DataBaseManage.h"
#import "Template.h"
#import "HttpManage.h"
#import "PCHeader.h"
#import "StatusBar.h"
#import "TalkingData.h"
#import "SMS_SDK/SMS_SDK.h"
#import "PCHeader.h"
#import "FileManage.h"
#import "waitingView.h"
@interface AppDelegate (){
    BOOL is_xz;
    BOOL is_add;
    TencentOAuth* _tencentOAuth;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if (ISIOS8LATER) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge
                                                                                             |UIRemoteNotificationTypeSound
                                                                                             |UIRemoteNotificationTypeAlert) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else{
        [[UIApplication sharedApplication]
         registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeAlert |
          UIRemoteNotificationTypeBadge |
          UIRemoteNotificationTypeSound)];
    }
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [WXApi registerApp:@"wx06ea6c3bc82c99ac" withDescription:@"sdyydome"];
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"1103283068"
                                            andDelegate:self];
    [TalkingData setExceptionReportEnabled:YES];
    [TalkingData sessionStarted:@"D556EA902795B17C4B339CEE2F61FA41" withChannelId:@"AppStore"];
    
    [SMS_SDK registerApp:@"4ec26c11eca2" withSecret:@"e80f13299bf5581e40ed33e2d8350cae"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onebyone) name:@"onebyone" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getmaxtemplate:) name:@"getmax" object:nil];
    [self getmaxtemplate:YES];
    return YES;
}

#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}
#endif

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)pToken {
    NSString *TOKEN = [NSString stringWithFormat:@"%@",pToken];
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"<>"];
    TOKEN = [TOKEN stringByTrimmingCharactersInSet:set];
    TOKEN = [TOKEN stringByReplacingOccurrencesOfString:@" " withString:@""];
    //注册成功，将deviceToken保存到应用服务器数据库中
    [UDObject setTSID:TOKEN];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    // 处理推送消息
//    NSLog(@"userinfo:%@",userInfo);
    NSLog(@"收到推送消息:%@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
    //注册(第一步)
    NSNotification *ntfc  =[NSNotification notificationWithName:@"message" object:nil];
    //发送（第二步）
    [[NSNotificationCenter defaultCenter] postNotification:ntfc];
    
    if (application.applicationState == UIApplicationStateActive){
    }else{
    }
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    NSLog(@"Registfail%@",error);
}



-(void)QQLogin:(NSNotification*)noc{
    [_tencentOAuth authorize:[NSArray arrayWithObjects:@"get_user_info",@"get_simple_userinfo", @"add_t", nil] inSafari:NO];
}

-(void)QQshare:(NSNotification*)noc{
    NSDictionary* dic = (NSDictionary*)noc.object;
    NSString *utf8String = [dic valueForKey:@"url"];
    NSString *title = [dic valueForKey:@"title"];
    NSString *description = [dic valueForKey:@"des"];
    NSString *previewImageUrl = [dic valueForKey:@"imgUrl"];
    QQApiNewsObject *newsObj = [QQApiNewsObject
                                objectWithURL:[NSURL URLWithString:utf8String]
                                title:title
                                description:description
                                previewImageURL:[NSURL URLWithString:previewImageUrl]];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    //将内容分享到qq
    [QQApiInterface sendReq:req];
    //将内容分享到qzone
//    QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
}
-(void)QQZoneshare:(NSNotification*)noc{
    NSDictionary* dic = (NSDictionary*)noc.object;
    NSString *utf8String = [dic valueForKey:@"url"];
    NSString *title = [dic valueForKey:@"title"];
    NSString *description = [dic valueForKey:@"des"];
    NSString *previewImageUrl = [dic valueForKey:@"imgUrl"];
    QQApiNewsObject *newsObj = [QQApiNewsObject
                                objectWithURL:[NSURL URLWithString:utf8String]
                                title:title
                                description:description
                                previewImageURL:[NSURL URLWithString:previewImageUrl]];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    //将内容分享到qq
//    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    //将内容分享到qzone
    [QQApiInterface SendReqToQZone:req];
}
- (void)tencentDidLogin
{
//    _labelTitle.text = @"登录完成";
    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length])
    {
        // 记录登录用户的OpenID、Token以及过期时间
//        _labelAccessToken.text = _tencentOAuth.accessToken;
//        NSString* token = [_tencentOAuth accessToken] ;
//        NSString* openid = [_tencentOAuth openId] ;
//        NSDate* expirationDate = [_tencentOAuth expirationDate] ;
        if ([_tencentOAuth getUserInfo]) {
            
        }else{
            [[StatusBar sharedStatusBar] talkMsg:@"获取QQ用户数据失败。" inTime:0.5];
        }
    }
    else
    {
        [[StatusBar sharedStatusBar] talkMsg:@"未能成功使用QQ登陆。" inTime:0.5];
//        _labelAccessToken.text = @"登录不成功 没有获取accesstoken";
    }
}
/**
 * Called when the get_user_info has response.
 */
- (void)getUserInfoResponse:(APIResponse*) response {
    if (response.retCode == URLREQUEST_SUCCEED)
    {
        NSDictionary *json = response.jsonResponse;
        NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:[json objectForKey:@"nickname"],@"nickname",[_tencentOAuth openId],@"openid", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_SDWX" object:self userInfo:dic];
    }
}
- (void)responseDidReceived:(APIResponse*)response forMessage:(NSString *)message{
//    NSLog(@"response=%@,message=%@",response,message);
}
-(void)tencentDidNotLogin:(BOOL)cancelled
{
    if (cancelled)
    {
        [[StatusBar sharedStatusBar] talkMsg:@"QQ登陆失败。" inTime:0.5];
//        _labelTitle.text = @"用户取消登录";
    }
    else
    {
        [[StatusBar sharedStatusBar] talkMsg:@"QQ登陆失败了，再试一次吧。" inTime:0.5];
//        _labelTitle.text = @"登录失败";
    }
}
-(void)tencentDidNotNetWork
{
    [[StatusBar sharedStatusBar] talkMsg:@"无网络连接，请设置网络。" inTime:0.5];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"QQ_LOGIN" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"QQ_SENDTO" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"QQZONE_SENDTO" object:nil];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}
- (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame{
    
}
- (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame{
    
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_PHONE_BACK" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QQLogin:) name:@"QQ_LOGIN" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QQshare:) name:@"QQ_SENDTO" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QQZoneshare:) name:@"QQZONE_SENDTO" object:nil];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    [self checkToken];
    
    [HttpManage edition:@"ios" cb:^(BOOL isOK, NSString *URL) {
        if (isOK) {
            if (![URL isEqualToString:@"failure"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"版本需更新" message:@"目前版本不是最新版本，请点击更新" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"版本更新", nil];
                [alert show];
            }
        }
    }];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            
            break;
        case 1:
            [self tzurl];
            break;
        default:
            break;
    }
    
}

-(void)tzurl{
    NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/kuai-yao-yue-qing-song-zuo/id927884233?mt=8"];
    [[UIApplication sharedApplication]openURL:url];
}

-(void)getmaxtemplate:(BOOL)state{
    is_add = state;
    NSArray *fetchedObjects = [[DataBaseManage getDataBaseManage] QueryTemplate];
//    NSLog(@"%lu",(unsigned long)[fetchedObjects count]);
    if ([fetchedObjects count] != 0) {
        is_xz = NO;
        Template *template = [fetchedObjects objectAtIndex:0];
        NSString *timestamp = template.neftimestamp;
        [self maxtemplate :timestamp];
        
                NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
                NSString *uptime = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"uptime"]];
                if (uptime.length > 0 && ![uptime isEqualToString:@"(null)"]) {
            
                }else{
                   uptime = timestamp;
                }
        
                [HttpManage templateRenewal:uptime cb:^(BOOL isOK, NSArray *array) {
                    if (isOK) {
                        NSLog(@"啦啦啦啦-%@",array);
                        for (int i = 0; i < [array count]; i++) {
                            NSDictionary *dic = [array objectAtIndex:i];
                            [[DataBaseManage getDataBaseManage] UpTemplate:dic];
                            
                            NSString *renewalType = [dic objectForKey:@"renewalType"];
                            if ([renewalType isEqualToString:@"coordinate"]) {
                                [[DataBaseManage getDataBaseManage] UpdataInfo:dic];
                            }else{
                                
                                NSString *background = [dic objectForKey:@"background"];
                                NSString *thumbUrl = [dic objectForKey:@"preview"];
                                NSString *preview = [dic objectForKey:@"thumbUrl"];
                                
                                NSArray *array = [background componentsSeparatedByString:@"/"];
                                NSString *bname = [array objectAtIndex:([array count] - 4)];
                                
                                NSString *name = [NSString stringWithFormat:@"%@/assets/images/base",bname];
                                name = [[FileManage sharedFileManage] getImgPath:name];
                                
                                NSString *pname = [NSString stringWithFormat:@"%@/assets/images/preview",bname];
                                pname = [[FileManage sharedFileManage] getImgPath:pname];
                                
                                NSString *tname = [NSString stringWithFormat:@"%@/assets/images/thumb",bname];
                                tname = [[FileManage sharedFileManage] getImgPath:tname];
                                
                                [HttpManage postdownloadimg:background :name];
                                [HttpManage postdownloadimg:preview :pname];
                                [HttpManage postdownloadimg:thumbUrl :tname];
                                
                            }
                            if (i == ([array count]-1)) {
                                NSDictionary *dic1 = [array objectAtIndex:0];
                                NSString *uptime = [dic1 objectForKey:@"renewal"];
                                [userInfo setObject:uptime forKey:@"uptime"];
                                [userInfo synchronize];
                            }
                        }
                    }
                }];
        
    }else{
        is_xz = YES;
        [self maxtemplate :@"-1"];
    }
}

-(void)maxtemplate:(NSString *)timestamp{
    [HttpManage template:timestamp size:@"-1" cb:^(BOOL isOK, NSMutableArray *array) {
        NSLog(@"%@",array);
        if (isOK) {
            for (int i = 0; i < [array count]; i++) {
                NSDictionary *resultDic = [array objectAtIndex:i];
                if (is_xz) {
                    [self zip:[resultDic objectForKey:@"zipUrl"] :[NSString stringWithFormat:@"%d",i]];
                }
                [[DataBaseManage getDataBaseManage] AddTemplate:resultDic];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DOWNLOAD_DONE" object:nil];
            if (!is_add) {
                [[StatusBar sharedStatusBar] talkMsg:@"模板加载完成..." inTime:0.5];
            }
            
        }
        else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DOWNLOAD_DONE" object:nil];
        }
    }];
    
}

-(void)zip : (NSString *)zip :(NSString *) i{
    if ([zip length] > 0) {
        NSArray *array = [zip componentsSeparatedByString:@"/"];
        NSString *name = [NSString stringWithFormat:@"%@",[array objectAtIndex:([array count]- 1)]];
        NSArray *array1 = [name componentsSeparatedByString:@"."];
        NSString *name1 = [NSString stringWithFormat:@"%@",[array1 objectAtIndex:([array1 count]- 2)]];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"sdyy"];
        [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        NSString *path = [testDirectory stringByAppendingPathComponent:name1];
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [HttpManage postdownload:zip :name1];
        }
    }
}

-(void)checkToken{
    if ([UDObject gettoken].length > 0) {
        [HttpManage checkToken:[UDObject gettoken] cb:^(BOOL isOK, NSDictionary *dic) {
            if (isOK) {
                if ([[dic objectForKey:@"result"] isEqualToString:@"success"]) {
                    
                }else{
                    [[StatusBar sharedStatusBar] talkMsg:@"账号已过期" inTime:0.5];
                    [UDObject setHLContent:@"" xn_name:@"" hltime:@"" bmendtime:@"" address_name:@"" music:@"" musicname:@"" imgarr:@""];
                    [UDObject setSWContent:@"" swtime:@"" swbmendtime:@"" address_name:@"" swxlr_name:@"" swxlfs_name:@"" swhd_name:@"" music:@"" musicname:@"" imgarr:@""];
                    [UDObject setWLContent:@"" wltime:@"" wlbmendtime:@"" wladdress_name:@"" wllxr_name:@"" wllxfs_name:@"" wlts_name:@"" wlaudio:@"" wlimgarr:@""];
                    [UDObject setZDYContent:@"" zdytitle:@"" zdydd:@"" zdytime:@"" zdyendtime:@"" zdymusic:@"" zdymusicname:@"" zdyimgarr:@""];
                    [UDObject setUserInfo:@"" userName:@"" token:@""];
                    
                    [self onebyone];
                }
            }else{
                
            }
        }];
    }
}

-(void)onebyone{
   
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [window makeKeyAndVisible];
    _window = window;
    _window.backgroundColor = [UIColor blackColor];
    _window.rootViewController = [storyBoard instantiateInitialViewController];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DOWNLOAD_DONE" object:nil];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    //    return  [WXApi handleOpenURL:url delegate:self];
//    NSLog(@"%@",url);
    return [WXApi handleOpenURL:url delegate:self] || [TencentOAuth HandleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //    BOOL isSuc = [WXApi handleOpenURL:url delegate:self];
    return [WXApi handleOpenURL:url delegate:self] || [TencentOAuth HandleOpenURL:url];
    //    return  isSuc;
}
//- (void)onReq:(QQBaseReq *)req{
//    
//}
//- (void)onResp:(QQBaseResp *)resp{
//    
//}
-(void) onReq:(BaseReq*)req
{
//    NSLog(@"req-%@",req);
}

//回调
-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        if (resp.errCode == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"back" object:self];
//            [SVProgressHUD showSuccessWithStatus:@"分享成功" duration:1];
        }
    }else{
        if (resp.errCode == 0) {
            SendAuthResp *req = (SendAuthResp *)resp;
            [self getAccess_token:req.code];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"nowx" object:self];
        }
    }
}

-(void)getAccess_token:(NSString *) code
{
    //https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",@"wx06ea6c3bc82c99ac",@"1e9e5b207389d2959a43ad203f74a6fd",code];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                NSLog(@"%@",dic);
                [self getUserInfo:[dic objectForKey:@"access_token"] :[dic objectForKey:@"openid"]];
            }
        });
    });
}

-(void)getUserInfo :(NSString *) access_token :(NSString *)openid
{
    // https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token,openid];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_SDWX" object:self userInfo:dic];
            }
            else{
                [[waitingView sharedwaitingView] stopWait];
                [[StatusBar sharedStatusBar] talkMsg:@"微信登陆失败了，再试一次吧。" inTime:0.5];
            }
        });
        
    });
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.nef.kuaiyaoyue" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"kuaiyaoyue" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"kuaiyaoyue.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    
    NSDictionary *optionsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],
                                       NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES],
                                       NSInferMappingModelAutomaticallyOption, nil];
    
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:optionsDictionary error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
