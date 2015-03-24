//
//  FourViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "FourViewController.h"
#import "UDObject.h"
#import "myImageView.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "TalkingData.h"
#import "waitingView.h"
#import "HttpManage.h"
#import "coverAnimation.h"
#import "FileManage.h"
#import "PCHeader.h"
#import "WXApi.h"
#import <TencentOpenAPI/QQApi.h>

@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.view.bounds = IPAD_FRAME;
    }
    myImageView* bg = [[myImageView alloc] initWithFrame:self.view.bounds andImageName:@"bg_login@2x.jpg" withScale:2.0 andAlign:UIImgAlignmentCenter];
    [self.view addSubview:bg];
    myImageView* logo = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 318.0/2.0, 344.0/2.0) andImageName:@"logo_login@2x" withScale:2.0 andAlign:UIImgAlignmentCenter];
    logo.center = CGPointMake(self.view.bounds.size.width/2.0, (self.view.bounds.size.height - 478.0/2.0)/2.0);
    [self.view addSubview:logo];
    
    UIView* ipad_bg = [[UIView alloc] initWithFrame:self.view.bounds];
    ipad_bg.userInteractionEnabled = YES;
    ipad_bg.tag = 90;
    ipad_bg.backgroundColor = [UIColor clearColor];
    [self.view addSubview:ipad_bg];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 164.0/2.0, self.view.bounds.size.width, 1.0)];
    line.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.1];
    [ipad_bg addSubview:line];
    
    UILabel* mbtitle = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 204.0/2.0, self.view.bounds.size.width, 15.0)];
    [mbtitle setFont:[UIFont systemFontOfSize:13]];
    [mbtitle setTextAlignment:NSTextAlignmentCenter];
    [mbtitle setTextColor:[UIColor whiteColor]];
    [mbtitle setBackgroundColor:[UIColor clearColor]];
    [mbtitle setText:@"使用快邀约账号登录"];
    [ipad_bg addSubview:mbtitle];
    
    myImageView* login_btn = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 160.0/2.0, 64.0/2.0) andImageName:@"btn_login_1" withScale:2.0];
    login_btn.tag = 103;
    [ipad_bg addSubview:login_btn];
    myImageView* reg_btn = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 160.0/2.0, 64.0/2.0) andImageName:@"btn_login_2" withScale:2.0];
    reg_btn.tag = 104;
    [ipad_bg addSubview:reg_btn];
    login_btn.center = CGPointMake(self.view.bounds.size.width/2.0-11.0-160.0/4.0, self.view.bounds.size.height-50.0/2.0-64.0/4.0);
    reg_btn.center = CGPointMake(self.view.bounds.size.width/2.0+11.0+160.0/4.0, self.view.bounds.size.height-50.0/2.0-64.0/4.0);
    myImageView* qq_btn = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 360.0/2.0, 84.0/2.0) andImageName:@"btn_login_qq" withScale:2.0];
    qq_btn.tag = 101;
    [ipad_bg addSubview:qq_btn];
    myImageView* wx_btn = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 360.0/2.0, 84.0/2.0) andImageName:@"btn_login_weixin" withScale:2.0];
    wx_btn.tag = 102;
    [ipad_bg addSubview:wx_btn];
    qq_btn.center = CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height-284.0/2.0-84.0*3.0/4.0-26.0/2.0);
    wx_btn.center = CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height-284.0/2.0-84.0/4.0);
    
    UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(QQTap:)];
    [qq_btn addGestureRecognizer:tap1];
    UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(WXTap:)];
    [wx_btn addGestureRecognizer:tap2];
    UITapGestureRecognizer* tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DLTap:)];
    [login_btn addGestureRecognizer:tap3];
    UITapGestureRecognizer* tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ZCTap:)];
    [reg_btn addGestureRecognizer:tap4];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        ipad_bg.alpha = 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_SDWX" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_LOGIN_DONE" object:nil];
}
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginDine) name:@"MSG_LOGIN_DONE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(sdwx:)
                                                 name: @"MSG_SDWX"
                                               object: nil];
    //MSG_Regme
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self ipadgoin];
    }
}
-(void)ipadgoin{
    UIView* ipad_bg = [self.view viewWithTag:90];
    ipad_bg.layer.transform = CATransform3DMakeTranslation(0, 150, 0);
    [UIView animateWithDuration:0.3
     delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
         ipad_bg.alpha = 1;
         ipad_bg.layer.transform = CATransform3DIdentity;
     } completion:^(BOOL finished) {
         
     }];
}

-(void)sdwx :(NSNotification*)notification{
    NSDictionary *dictionary = [notification userInfo];
    NSString *name = [dictionary objectForKey:@"nickname"];
    NSString *opneid = [dictionary objectForKey:@"openid"];
    [HttpManage registers:name userPwd:@"123456" phoneId:[UDObject getTSID] openId:opneid cb:^(BOOL isOK, NSDictionary *dic) {
        [[waitingView sharedwaitingView] stopWait];
        if (isOK) {
            [UDObject setUserInfo:name userName:name token:[dic objectForKey:@"token"]];
            [UDObject setXM:name];
            [self performSegueWithIdentifier:@"wel2main" sender:nil];
        }else{
            
//            [[StatusBar sharedStatusBar] talkMsg:@"登陆失败了，再试一次吧。" inTime:0.5];
            [[waitingView sharedwaitingView] WarningByMsg:@"登陆失败了，再试一次吧。" haveCancel:NO];
            [[waitingView sharedwaitingView] performSelector:@selector(stopWait) withObject:nil afterDelay:ERR_TIME];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)WXTap:(UIGestureRecognizer*)g{
    if (![WXApi isWXAppInstalled] || ![WXApi isWXAppSupportApi]) {
        UIAlertView* al = [[UIAlertView alloc] initWithTitle:@"未检测到微信" message:@"您可以选择以下操作： \n1、点击并安装微信; 2、点击匿名登录系统(将无法得到历史数据); 3、点击取消，选择其它登录方式; " delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"安装微信",@"匿名登录", nil];
        al.tag = 22;
        [al show];
    } else {
        [TalkingData trackEvent:@"微信登陆"];
        myImageView* btn = (myImageView*)[self.view viewWithTag:102];
        [UIView animateWithDuration:0.1 animations:^{
            [btn changeWithImageName:@"btn_login_weixin_pre" withScale:2.0];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                [btn changeWithImageName:@"btn_login_weixin" withScale:2.0];
            } completion:^(BOOL finished) {
                [self loginwx];
            }];
        }];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
    } else if (buttonIndex == 1) {
        if (alertView.tag == 22) {
            NSURL *url = [NSURL URLWithString:[WXApi getWXAppInstallUrl]];
            [[UIApplication sharedApplication]openURL:url];
        } else {
            NSURL *url = [NSURL URLWithString:[QQApi getQQInstallURL]];
            [[UIApplication sharedApplication]openURL:url];
        }
    } else if (buttonIndex == 2) {
        [self nickLogin];
    }
}
-(void)nickLogin{
    [[waitingView sharedwaitingView] waitByMsg:@"请稍候……" haveCancel:NO];
    NSString *name = @"匿名用户";
    NSString *opneid = [FileManage getUUID];
    [HttpManage registers:name userPwd:@"123456" phoneId:[UDObject getTSID] openId:opneid cb:^(BOOL isOK, NSDictionary *dic) {
        [[waitingView sharedwaitingView] stopWait];
        if (isOK) {
            [TalkingData trackEvent:@"匿名登录"];
            [UDObject setUserInfo:name userName:name token:[dic objectForKey:@"token"]];
            [UDObject setXM:@""];
            [self performSegueWithIdentifier:@"wel2main" sender:nil];
        }else{
            //            [[StatusBar sharedStatusBar] talkMsg:@"登陆失败了，再试一次吧。" inTime:0.5];
            [[waitingView sharedwaitingView] WarningByMsg:@"登陆失败了，再试一次吧。" haveCancel:NO];
            [[waitingView sharedwaitingView] performSelector:@selector(stopWait) withObject:nil afterDelay:ERR_TIME];
        }
    }];
}
-(void)QQTap:(UIGestureRecognizer*)g{
    if (![TencentOAuth iphoneQQInstalled] || ![TencentOAuth iphoneQQSupportSSOLogin]) {
        UIAlertView* al = [[UIAlertView alloc] initWithTitle:@"未检测到QQ" message:@"您可以选择以下操作： \n1、点击并安装手机QQ; 2、点击匿名登录系统(将无法得到历史数据); 3、点击取消，选择其它登录方式; " delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"安装手机QQ",@"匿名登录", nil];
        al.tag = 23;
        [al show];
    } else {
        [TalkingData trackEvent:@"QQ登陆"];
        myImageView* btn = (myImageView*)[self.view viewWithTag:101];
        [UIView animateWithDuration:0.1 animations:^{
            [btn changeWithImageName:@"btn_login_qq_pre" withScale:2.0];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                [btn changeWithImageName:@"btn_login_qq" withScale:2.0];
            } completion:^(BOOL finished) {
                [self loginQQ];
            }];
        }];
    }
}
-(void)DLTap:(UIGestureRecognizer*)g{
    [TalkingData trackEvent:@"手机登陆"];
    myImageView* btn = (myImageView*)[self.view viewWithTag:103];
    [UIView animateWithDuration:0.1 animations:^{
        [btn changeWithImageName:@"btn_login_1_pre" withScale:2.0];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            [btn changeWithImageName:@"btn_login_1" withScale:2.0];
        } completion:^(BOOL finished) {
            [self login];
        }];
    }];
}
-(void)ZCTap:(UIGestureRecognizer*)g{
    [TalkingData trackEvent:@"手机注册"];
    myImageView* btn = (myImageView*)[self.view viewWithTag:104];
    [UIView animateWithDuration:0.1 animations:^{
        [btn changeWithImageName:@"btn_login_2_pre" withScale:2.0];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            [btn changeWithImageName:@"btn_login_2" withScale:2.0];
        } completion:^(BOOL finished) {
            [self regme];
        }];
    }];
}
-(void)regme{
    [self performSegueWithIdentifier:@"registra" sender:nil];
}
-(void)login{
    [self performSegueWithIdentifier:@"login" sender:nil];
}
-(void)loginQQ{
    [[waitingView sharedwaitingView] waitByMsg:@"请稍候……" haveCancel:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"QQ_LOGIN" object:nil];
}
-(void)loginwx{
    [[waitingView sharedwaitingView] waitByMsg:@"请稍候……" haveCancel:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WX_LOGIN" object:nil];
}
-(void)loginDine{
    [self performSegueWithIdentifier:@"wel2main" sender:nil];
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    //    NSRange r = [[dismissed.classForCoder description] rangeOfString:@"createViewController"];
    coverAnimation* ca = [[coverAnimation alloc] initWithPresent:NO];
    return ca;
}
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    //    NSString* name = [presented.classForCoder description];
    //    NSRange r = [name rangeOfString:@"createViewController"];
    coverAnimation* ca = [[coverAnimation alloc] initWithPresent:YES];
    return ca;
}

@end
