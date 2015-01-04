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
#import "StatusBar.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "TalkingData.h"
@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    myImageView* bg = [[myImageView alloc] initWithFrame:self.view.bounds andImageName:@"bg_login@2x.jpg" withScale:2.0 andAlign:UIImgAlignmentCenter];
    [self.view addSubview:bg];
    myImageView* logo = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 318.0/2.0, 344.0/2.0) andImageName:@"logo_login@2x" withScale:2.0 andAlign:UIImgAlignmentCenter];
    logo.center = CGPointMake(self.view.bounds.size.width/2.0, (self.view.bounds.size.height - 478.0/2.0)/2.0);
    [self.view addSubview:logo];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 164.0/2.0, self.view.bounds.size.width, 1.0)];
    line.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.1];
    [self.view addSubview:line];
    
    myImageView* login_btn = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 160.0/2.0, 64.0/2.0) andImageName:@"btn_login_1" withScale:2.0];
    login_btn.tag = 103;
    [self.view addSubview:login_btn];
    myImageView* reg_btn = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 160.0/2.0, 64.0/2.0) andImageName:@"btn_login_2" withScale:2.0];
    reg_btn.tag = 104;
    [self.view addSubview:reg_btn];
    login_btn.center = CGPointMake(self.view.bounds.size.width/2.0-11.0-160.0/4.0, self.view.bounds.size.height-50.0/2.0-64.0/4.0);
    reg_btn.center = CGPointMake(self.view.bounds.size.width/2.0+11.0+160.0/4.0, self.view.bounds.size.height-50.0/2.0-64.0/4.0);
    myImageView* qq_btn = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 360.0/2.0, 84.0/2.0) andImageName:@"btn_login_qq" withScale:2.0];
    qq_btn.tag = 101;
    [self.view addSubview:qq_btn];
    myImageView* wx_btn = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 360.0/2.0, 84.0/2.0) andImageName:@"btn_login_weixin" withScale:2.0];
    wx_btn.tag = 102;
    [self.view addSubview:wx_btn];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(void)QQTap:(UIGestureRecognizer*)g{
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
//    [[StatusBar sharedStatusBar] talkMsg:@"尽请期待，请移步微信登陆。" inTime:0.51];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_Regme" object:nil];
}
-(void)login{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_PTLOGIN" object:nil];
    
//    [[StatusBar sharedStatusBar] talkMsg:@"尽请期待，请移步微信登陆。" inTime:0.51];
}
-(void)loginQQ{
//    [[StatusBar sharedStatusBar] talkMsg:@"尽请期待，请移步微信登陆。" inTime:0.51];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"QQ_LOGIN" object:nil];
}
-(void)loginwx{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_LOGIN" object:nil];
}
- (IBAction)login_onclick:(id)sender {
//    [UDObject setOPEN];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_LOGIN" object:nil];
//    [self performSegueWithIdentifier:@"wel2main" sender:nil];
    
   
}


@end
