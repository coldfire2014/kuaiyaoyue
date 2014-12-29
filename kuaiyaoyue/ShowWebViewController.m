//
//  ShowWebViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/24.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "ShowWebViewController.h"
#import "TalkingData.h"
#import "SVProgressHUD.h"

@interface ShowWebViewController ()

@end

@implementation ShowWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    label.text = @"预览";
    [label sizeToFit];
    label.textColor = [[UIColor alloc] initWithRed:1 green:1 blue:1 alpha:1.0];
    label.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    [self.navigationItem setTitleView:label];
    
    UIColor *color = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1];
    [self.navigationController.navigationBar setTintColor:color];
    _webview.scalesPageToFit = YES;
    _webview.delegate = self;
    [self reloadweb];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [TalkingData trackPageBegin:@"生成后预览"];
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeBlack];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [TalkingData trackPageEnd:@"生成后预览"];
}

//页面加载时处理事件
-(void)reloadweb{
    NSURL *url =[NSURL URLWithString:_weburl];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [_webview loadRequest:request];
}

//页面加载完成，导航条显示，预览图隐藏，
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
