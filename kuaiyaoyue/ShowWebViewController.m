//
//  ShowWebViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/24.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "ShowWebViewController.h"

@interface ShowWebViewController ()

@end

@implementation ShowWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIColor *color = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1];
    [self.navigationController.navigationBar setTintColor:color];
    _webview.scalesPageToFit = YES;
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
}

//页面加载时处理事件
-(void)reloadweb{
    NSURL *url =[NSURL URLWithString:_weburl];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [_webview loadRequest:request];
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
