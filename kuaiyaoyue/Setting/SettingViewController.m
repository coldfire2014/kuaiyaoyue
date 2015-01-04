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

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //asdas
    self.title = @"返回";
    UIColor *color = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    label.text = @"设置";
    [label sizeToFit];
    label.textColor = color;
    label.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    [self.navigationItem setTitleView:label];
    [self.navigationController.navigationBar setTintColor:color];
    
    _xhd_view.layer.cornerRadius = 4.0;
    _tc_view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exit:)];
    [_tc_view addGestureRecognizer:tap];
}

-(void)exit:(UITapGestureRecognizer *)gr{
    [self exit];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [self edition];
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

- (IBAction)checkupdata_onclick:(id)sender {
    //意见反馈
    [self performSegueWithIdentifier:@"YJFK" sender:nil];

}

- (IBAction)ghp_onclick:(id)sender {
    
    if (![_xhd_view isHidden]) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=927884233&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"]];
    }else{
        [[StatusBar sharedStatusBar] talkMsg:@"目前为最新版本" inTime:0.51];
    }
    
}

- (IBAction)gl_onclick:(id)sender {
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=927884233&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"]];
}

- (IBAction)gw_onclick:(id)sender {
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.kyy121.com/"]];
    
}

- (IBAction)wb_onclick:(id)sender {
    weibo = YES;
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"快邀约";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"关注微博" message:@"微博“快邀约”已复制到剪切板。您可以到微博中关注我们,是否打开微博" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.delegate = self;
    [alert show];
}

- (IBAction)gzh_onclick:(id)sender {
    weibo = NO;
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"快邀约";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"关注公众号" message:@"微信号“快邀约”已复制到剪切板。您可以到微信中关注我们,是否打开微信" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.delegate = self;
    [alert show];
    
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
    [HttpManage edition:@"ios" cb:^(BOOL isOK, NSString *URL) {
        if (isOK) {
            if (![URL isEqualToString:@"failure"]) {
                [_xhd_view setHidden:NO];
            }
        }
    }];
}

-(void)exit{
    [HttpManage logout:[UDObject gettoken] cb:^(BOOL isOK, NSDictionary *array) {
        if (isOK) {
            [UDObject setHLContent:@"" xn_name:@"" hltime:@"" bmendtime:@"" address_name:@"" music:@"" musicname:@"" imgarr:@""];
            [UDObject setSWContent:@"" swtime:@"" swbmendtime:@"" address_name:@"" swxlr_name:@"" swxlfs_name:@"" swhd_name:@"" music:@"" musicname:@"" imgarr:@""];
            [UDObject setWLContent:@"" wltime:@"" wlbmendtime:@"" wladdress_name:@"" wllxr_name:@"" wllxfs_name:@"" wlts_name:@"" wlaudio:@"" wlimgarr:@""];
            [UDObject setZDYContent:@"" zdytitle:@"" zdydd:@"" zdytime:@"" zdyendtime:@"" zdymusic:@"" zdymusicname:@"" zdyimgarr:@""];
            [UDObject setUserInfo:@"" userName:@"" token:@""];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"onebyone" object:self userInfo:nil];
            
        }else{
            [[StatusBar sharedStatusBar] talkMsg:@"退出失败" inTime:0.51];
        }
    }];
}

- (IBAction)userinfo_onclick:(id)sender {
    [self performSegueWithIdentifier:@"userinfo" sender:nil];
}
@end
