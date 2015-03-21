//
//  SettingViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "SettingViewController.h"
#import "HttpManage.h"
#import "StatusBar.h"
#import "UDObject.h"
#import "AppDelegate.h"
#import "WXApi.h"
#import "PCHeader.h"
#import "TalkingData.h"
#import "WebViewController.h"
#import "SettingNavBar.h"
#import "myImageView.h"
#import "DataBaseManage.h"
#import "UserInfoViewController.h"
//#import "UMFeedback.h"
@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
    CGFloat h = [[UIScreen mainScreen] bounds].size.height;
    self.view.frame = [UIScreen mainScreen].bounds;
    CGFloat top = 20.0;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        top = 0.0;
        w = 540;
        h = 620;
        self.view.frame = CGRectMake(0, 0, w, h);
    }
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    SettingNavBar* bar = [[SettingNavBar alloc] initWithFrame:CGRectMake(0, 0, w, 88.0/2.0 + top)];
    bar.tag = 501;
    [self.view addSubview:bar];
    [self.view bringSubviewToFront:bar];
    
//    100
    CGFloat h_logo = 100.0;
    CGFloat top_logo = 48.0;
    CGFloat bottom_exit = 60.0;
    CGFloat logo2t = 28.0;
    CGFloat max_h = h+(-128.0-20.0-22.0-24.0-32.0-bottom_exit-5.0*86.0-24.0*2.0-22.0-28.0-logo2t-top_logo)/2.0;
    if (max_h<h_logo) {
        top_logo = 22.0;
        bottom_exit = 24.0;
        logo2t = 24.0/2.0;
        max_h = h+(-128.0-20.0-22.0-24.0-32.0-bottom_exit-5.0*86.0-24.0*2.0-22.0-28.0-logo2t-top_logo)/2.0;
        h_logo = max_h;
    } else {
        h_logo = 100.0;
    }
    myImageView* logo = [[myImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, h_logo, h_logo) andImageName:@"logo" withScale:2.0];
    logo.center = CGPointMake(w/2.0, 128.0/2.0+top_logo/2.0+h_logo/2.0);
    [self.view addSubview:logo];
    
    UILabel* mbtitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.0, w,28.0/2.0)];
    mbtitle.center = CGPointMake(w/2.0, logo.center.y + h_logo/2.0 + 28.0/4.0 + logo2t/2.0);
    [mbtitle setFont:[UIFont systemFontOfSize:14]];
    [mbtitle setTextAlignment:NSTextAlignmentCenter];
    [mbtitle setTextColor:[UIColor lightGrayColor]];
    [mbtitle setBackgroundColor:[UIColor clearColor]];
    [mbtitle setText:@"快，发起邀约吧!"];
    [self.view addSubview:mbtitle];
    
    UIView* info_btn = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 86.0/2.0)];
    info_btn.tag = 512;
    info_btn.backgroundColor = [UIColor whiteColor];
    info_btn.center = CGPointMake(w/2.0, mbtitle.center.y + 28.0/4.0 + 22.0/2.0 + 86.0/4.0);
    [self.view addSubview:info_btn];
    [self zxinfo];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userinfo)];
    [info_btn addGestureRecognizer:tap];
    
    UIView* update_btn = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 86.0/2.0)];
    update_btn.tag = 513;
    update_btn.alpha = 0;
    update_btn.backgroundColor = [UIColor whiteColor];
//    update_btn.center = CGPointMake(w/2.0, info_btn.center.y + 86.0/4.0 + 24.0/2.0 + 86.0/4.0);
    update_btn.center = CGPointMake(w/2.0, info_btn.center.y + 24.0/2.0);
    [self.view addSubview:update_btn];
    [self zxupdate];
    UITapGestureRecognizer *update_btntap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkupdata)];
    [update_btn addGestureRecognizer:update_btntap];
    
    UIView* pl_btn = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 86.0/2.0)];
    pl_btn.tag = 514;
    pl_btn.backgroundColor = [UIColor whiteColor];
    pl_btn.center = CGPointMake(w/2.0, update_btn.center.y + 86.0/4.0 + 86.0/4.0);
    [self.view addSubview:pl_btn];
    [self zxpl];
    UITapGestureRecognizer *pl_btntap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pl)];
    [pl_btn addGestureRecognizer:pl_btntap];
    
    UIView* introduce_btn = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 86.0/2.0)];
    introduce_btn.tag = 515;
    introduce_btn.backgroundColor = [UIColor whiteColor];
    introduce_btn.center = CGPointMake(w/2.0, pl_btn.center.y + 86.0/4.0 + 86.0/4.0);
    [self.view addSubview:introduce_btn];
    [self zxintroduce];
    UITapGestureRecognizer *introduce_btntap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(introduce)];
    [introduce_btn addGestureRecognizer:introduce_btntap];
    
    UIView* exit_btn = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 86.0/2.0)];
    exit_btn.tag = 516;
    exit_btn.backgroundColor = [UIColor whiteColor];
    exit_btn.center = CGPointMake(w/2.0, introduce_btn.center.y + 86.0/4.0 + 24.0/2.0 + 86.0/4.0);
    [self.view addSubview:exit_btn];
    [self zxexit];
    UITapGestureRecognizer *exit_btntap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exit)];
    [exit_btn addGestureRecognizer:exit_btntap];
    
    UILabel* gzh = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90.0, 32.0/2.0)];
    gzh.center = CGPointMake(w/2.0, h-(20.0+22.0+24.0+32.0/2.0)/2.0);
    [gzh setFont:[UIFont systemFontOfSize:16.0]];
    [gzh setTextAlignment:NSTextAlignmentCenter];
    [gzh setTextColor:[[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0]];
    [gzh setBackgroundColor:[UIColor clearColor]];
    [gzh setText:@"微信公众号"];
    gzh.userInteractionEnabled = YES;
    UITapGestureRecognizer *gzh_btntap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gzh)];
    [gzh addGestureRecognizer:gzh_btntap];
    [self.view addSubview:gzh];
    
    UIView* sl1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 32.0/2.0)];
    sl1.backgroundColor = [[UIColor alloc] initWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:0.4];
    sl1.center = CGPointMake(gzh.center.x-gzh.bounds.size.width/2.0, gzh.center.y);
    [self.view addSubview:sl1];
    UIView* sl2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 32.0/2.0)];
    sl2.backgroundColor = [[UIColor alloc] initWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:0.4];
    sl2.center = CGPointMake(gzh.center.x+gzh.bounds.size.width/2.0, gzh.center.y);
    [self.view addSubview:sl2];
    
    UILabel* wb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40.0, 32.0/2.0)];
    wb.center = CGPointMake(gzh.center.x-gzh.bounds.size.width/2.0-21.0, gzh.center.y);
    [wb setFont:[UIFont systemFontOfSize:16.0]];
    [wb setTextAlignment:NSTextAlignmentCenter];
    [wb setTextColor:[[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0]];
    [wb setBackgroundColor:[UIColor clearColor]];
    [wb setText:@"微博"];
    wb.userInteractionEnabled = YES;
    UITapGestureRecognizer *wb_btntap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wb)];
    [wb addGestureRecognizer:wb_btntap];
    [self.view addSubview:wb];
    
    UILabel* gw = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40.0, 32.0/2.0)];
    gw.center = CGPointMake(gzh.center.x+gzh.bounds.size.width/2.0+21.0, gzh.center.y);
    [gw setFont:[UIFont systemFontOfSize:16.0]];
    [gw setTextAlignment:NSTextAlignmentCenter];
    [gw setTextColor:[[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0]];
    [gw setBackgroundColor:[UIColor clearColor]];
    [gw setText:@"官网"];
    gw.userInteractionEnabled = YES;
    UITapGestureRecognizer *gw_btntap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gw)];
    [gw addGestureRecognizer:gw_btntap];
    [self.view addSubview:gw];
    
    UILabel* right = [[UILabel alloc] initWithFrame:CGRectMake(18.0, h-42.0/2.0, w-36.0, 22.0/2.0)];
    [right setFont:[UIFont systemFontOfSize:10]];
    [right setTextAlignment:NSTextAlignmentCenter];
    [right setTextColor:[UIColor colorWithWhite:0.80 alpha:1.0]];
    [right setBackgroundColor:[UIColor clearColor]];
    [right setText:@"Copyright @2014 kyy121.com, All Rights Reserved."];
    [self.view addSubview:right];
}
-(void)zxinfo{
    UIView* btn = [self.view viewWithTag: 512];
    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        w = 540;
    }
    UIView* t_line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 0.5)];
    t_line.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [btn addSubview:t_line];
    UIView* b_line = [[UIView alloc] initWithFrame:CGRectMake(0, btn.bounds.size.height-0.5, w, 0.5)];
    b_line.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [btn addSubview:b_line];

    UILabel* mbtitle = [[UILabel alloc] initWithFrame:CGRectMake(18.0, 0, w-36.0, btn.bounds.size.height)];
    [mbtitle setFont:[UIFont systemFontOfSize:16]];
    [mbtitle setTextAlignment:NSTextAlignmentLeft];
    [mbtitle setTextColor:[[UIColor alloc] initWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1.0]];
    [mbtitle setBackgroundColor:[UIColor clearColor]];
    [mbtitle setText:@"个人信息"];
    [btn addSubview:mbtitle];
    
    UILabel* bbh = [[UILabel alloc] initWithFrame:CGRectMake(18.0, 0, w-50.0, btn.bounds.size.height)];
    [bbh setFont:[UIFont systemFontOfSize:15]];
    [bbh setTextAlignment:NSTextAlignmentRight];
    [bbh setTextColor:[UIColor lightGrayColor]];
    [bbh setBackgroundColor:[UIColor clearColor]];
    
    [bbh setText:[UDObject getXM]];
    [btn addSubview:bbh];
    
    myImageView* arr = [[myImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 32.0/2.0, 32.0/2.0) andImageName:@"arr32" withScale:2.0];
    arr.center = CGPointMake(w - (36.0 + 32.0/2.0)/2.0, btn.bounds.size.height/2.0);
    [btn addSubview:arr];
}
-(void)zxupdate{
    UIView* btn = [self.view viewWithTag: 513];
    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        w = 540;
    }
    UIView* t_line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 0.5)];
    t_line.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [btn addSubview:t_line];
    
    UILabel* mbtitle = [[UILabel alloc] initWithFrame:CGRectMake(18.0, 0, w-36.0, btn.bounds.size.height)];
    [mbtitle setFont:[UIFont systemFontOfSize:16]];
    [mbtitle setTextAlignment:NSTextAlignmentLeft];
    [mbtitle setTextColor:[[UIColor alloc] initWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1.0]];
    [mbtitle setBackgroundColor:[UIColor clearColor]];
    [mbtitle setText:@"检查更新"];
    [btn addSubview:mbtitle];
    
    myImageView* arr = [[myImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 32.0/2.0, 32.0/2.0) andImageName:@"arr32" withScale:2.0];
    arr.center = CGPointMake(w - (36.0 + 32.0/2.0)/2.0, btn.bounds.size.height/2.0);
    [btn addSubview:arr];
    
    UIView* gx = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8.0, 8.0)];
    gx.center = CGPointMake(165.0/2.0, btn.bounds.size.height/2.0 - 8.0);
    gx.backgroundColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
    gx.layer.cornerRadius = 8.0/2.0;
    gx.tag = 610;
    gx.hidden = YES;
    [btn addSubview:gx];
    
    UILabel* bbh = [[UILabel alloc] initWithFrame:CGRectMake(18.0, 0, w-50.0, btn.bounds.size.height)];
    [bbh setFont:[UIFont systemFontOfSize:15]];
    [bbh setTextAlignment:NSTextAlignmentRight];
    [bbh setTextColor:[UIColor lightGrayColor]];
    [bbh setBackgroundColor:[UIColor clearColor]];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    [bbh setText:[infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    [btn addSubview:bbh];
}
-(void)zxpl{
    UIView* btn = [self.view viewWithTag: 514];
    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        w = 540;
    }
//    UIView* t_line = [[UIView alloc] initWithFrame:CGRectMake(8.0, 0, w-16.0, 0.5)];
    UIView* t_line = [[UIView alloc] initWithFrame:CGRectMake(8.0, 0, w, 0.5)];
    t_line.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [btn addSubview:t_line];
    UIView* b_line = [[UIView alloc] initWithFrame:CGRectMake(8.0, btn.bounds.size.height-0.5, w-16.0, 0.5)];
    b_line.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [btn addSubview:b_line];
    
    UILabel* mbtitle = [[UILabel alloc] initWithFrame:CGRectMake(18.0, 0, w-36.0, btn.bounds.size.height)];
    [mbtitle setFont:[UIFont systemFontOfSize:16]];
    [mbtitle setTextAlignment:NSTextAlignmentLeft];
    [mbtitle setTextColor:[[UIColor alloc] initWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1.0]];
    [mbtitle setBackgroundColor:[UIColor clearColor]];
    [mbtitle setText:@"给个好评吧"];
    [btn addSubview:mbtitle];
    
    myImageView* arr = [[myImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 32.0/2.0, 32.0/2.0) andImageName:@"arr32" withScale:2.0];
    arr.center = CGPointMake(w - (36.0 + 32.0/2.0)/2.0, btn.bounds.size.height/2.0);
    [btn addSubview:arr];
}
-(void)zxintroduce{
    UIView* btn = [self.view viewWithTag: 515];
    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        w = 540;
    }
    UIView* b_line = [[UIView alloc] initWithFrame:CGRectMake(0, btn.bounds.size.height-0.5, w, 0.5)];
    b_line.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [btn addSubview:b_line];
    
    UILabel* mbtitle = [[UILabel alloc] initWithFrame:CGRectMake(18.0, 0, w-36.0, btn.bounds.size.height)];
    [mbtitle setFont:[UIFont systemFontOfSize:16]];
    [mbtitle setTextAlignment:NSTextAlignmentLeft];
    [mbtitle setTextColor:[[UIColor alloc] initWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1.0]];
    [mbtitle setBackgroundColor:[UIColor clearColor]];
    [mbtitle setText:@"攻略"];
    [btn addSubview:mbtitle];
    
    myImageView* arr = [[myImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 32.0/2.0, 32.0/2.0) andImageName:@"arr32" withScale:2.0];
    arr.center = CGPointMake(w - (36.0 + 32.0/2.0)/2.0, btn.bounds.size.height/2.0);
    [btn addSubview:arr];
}
-(void)zxexit{
    UIView* btn = [self.view viewWithTag: 516];
    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        w = 540;
    }
    UIView* t_line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 0.5)];
    t_line.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [btn addSubview:t_line];
    UIView* b_line = [[UIView alloc] initWithFrame:CGRectMake(0, btn.bounds.size.height-0.5, w, 0.5)];
    b_line.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [btn addSubview:b_line];
    
    UILabel* mbtitle = [[UILabel alloc] initWithFrame:btn.bounds];
    [mbtitle setFont:[UIFont systemFontOfSize:18]];
    [mbtitle setTextAlignment:NSTextAlignmentCenter];
    [mbtitle setTextColor:[[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0]];
    [mbtitle setBackgroundColor:[UIColor clearColor]];
    [mbtitle setText:@"退出登录"];
    [btn addSubview:mbtitle];
}

- (void)introduce {
    //意见反馈
    [TalkingData trackEvent:@"查看攻略"];
    //    [self performSegueWithIdentifier:@"YJFK" sender:nil];
    WebViewController *view = [[WebViewController alloc] init];
    view.name = @"探秘快邀约";
    view.weburl = @"http://appkyy.kyy121.com/invitation/static/gospel.html";
    view.viewTitle = @"攻略";
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        view.modalPresentationStyle = UIModalPresentationFullScreen;
        view.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:view animated:YES completion:^{}];
    } else {
        [self.navigationController pushViewController:view animated:YES];
    }
}

- (void)checkupdata {
    [TalkingData trackEvent:@"点击更新"];
    UIView* gx = [self.view viewWithTag: 610];
    if (![gx isHidden]) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:DURL]];
    }else{
        [[StatusBar sharedStatusBar] talkMsg:@"目前为最新版本" inTime:0.51];
    }
}

- (void)pl {
    [TalkingData trackEvent:@"评论"];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:STOREDIR]];
//    [self presentModalViewController:[UMFeedback feedbackModalViewController] animated:YES];
//    [self.navigationController pushViewController:[UMFeedback feedbackViewController] animated:YES];
    
//    UIViewController *view = [UMFeedback feedbackModalViewController];
//    view.modalPresentationStyle = UIModalPresentationFullScreen;
//    view.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    [self presentViewController:view animated:YES completion:^{}];
}

- (void)gw {
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.kyy121.com/"]];
    [TalkingData trackEvent:@"官网"];
}

- (void)wb {
    [TalkingData trackEvent:@"关注微博"];
    weibo = YES;
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"快邀约";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"关注微博" message:@"微博“快邀约”已复制到剪切板。您可以到微博中关注我们,是否打开微博" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.delegate = self;
    [alert show];
}

- (void)gzh {
    [TalkingData trackEvent:@"关注公众号"];
    weibo = NO;
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"快邀约";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"关注公众号" message:@"微信号“快邀约”已复制到剪切板。您可以到微信中关注我们,是否打开微信" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.delegate = self;
    [alert show];
    
}
-(void)exit{
    [TalkingData trackEvent:@"退出登录"];
    [HttpManage logout:[UDObject gettoken] cb:^(BOOL isOK, NSDictionary *array) {
        if (isOK) {
            [[DataBaseManage getDataBaseManage] CleanUserdata];
            [UDObject setHLContent:@"" xn_name:@"" hltime:@"" bmendtime:@"" address_name:@"" music:@"" musicname:@"" imgarr:@""];
            [UDObject setSWContent:@"" swtime:@"" swbmendtime:@"" address_name:@"" swxlr_name:@"" swxlfs_name:@"" swhd_name:@"" music:@"" musicname:@"" imgarr:@""];
            [UDObject setWLContent:@"" wltime:@"" wlbmendtime:@"" wladdress_name:@"" wllxr_name:@"" wllxfs_name:@"" wlts_name:@"" wlmusicname:@"" wlmusic:@"" wlimgarr:@""];
            [UDObject setZDYContent:@"" zdytitle:@"" zdydd:@"" zdytime:@"" zdyendtime:@"" zdymusic:@"" zdymusicname:@"" zdyimgarr:@""];
            [UDObject setUserInfo:@"" userName:@"" token:@""];
            [UDObject setTimestamp:@""];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"onebyone" object:self userInfo:nil];
            
        }else{
            [[StatusBar sharedStatusBar] talkMsg:@"退出失败" inTime:0.51];
        }
    }];
}
- (void)userinfo {
    [TalkingData trackEvent:@"个人信息修改"];
//    [self performSegueWithIdentifier:@"userinfo" sender:nil];
    UserInfoViewController* setting = [[UserInfoViewController alloc] init];
//    setting.modalPresentationStyle = UIModalPresentationFullScreen;
//    setting.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    [self presentViewController:setting animated:YES completion:^{
//        
//    }];
    [self.navigationController pushViewController:setting animated:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self edition];
    [TalkingData trackPageBegin:@"设置"];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(back) name:@"MSG_BACK" object:nil];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [TalkingData trackPageEnd:@"设置"];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_BACK" object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSURL *url;
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
            if (weibo) {
                url = [NSURL URLWithString:@"http://weibo.com/"];//跳微博
                
            } else {
                url = [NSURL URLWithString:@"weixin:"];//跳微信
            }
            [[UIApplication sharedApplication] openURL:url];
            break;
        default:
            break;
    }
}

-(void)edition{
    UIView* gx = [self.view viewWithTag: 610];
    [HttpManage edition:@"ios" cb:^(BOOL isOK, BOOL update) {
        if (isOK) {
            if (update) {
                gx.hidden = NO;
            }else{
                gx.hidden = YES;
            }
        }
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//    if ([segue.identifier compare:@"showurl"] == NSOrderedSame){
    
//    }
}

@end
