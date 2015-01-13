//
//  WebViewController.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/1/10.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import "WebViewController.h"
#import "StatusBar.h"
#import "waitingView.h"
#import "TalkingData.h"
#import "WebNavBar.h"
@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"返回";
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    self.view.frame = [UIScreen mainScreen].bounds;
    self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 128.0/2.0, w, h-128.0/2.0)];
    self.webview.scalesPageToFit = YES;
    self.webview.delegate = self;
    [self.view addSubview:self.webview];
    WebNavBar* bar = [[WebNavBar alloc] initWithFrame:CGRectMake(0, 0, w, 128.0/2.0)];
    bar.tag = 501;
    [bar setTitle:self.name];
    [self.view addSubview:bar];
    [self.view bringSubviewToFront:bar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [self reloadweb];
    [super viewDidAppear:animated];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [self.navigationController.navigationBar setHidden:NO];
    [TalkingData trackPageBegin:_viewTitle];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopLoad) name:@"MSG_STOP_WAITING" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(back) name:@"MSG_BACK" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(close) name:@"MSG_CLOSE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"MSG_WEB_REFLASH" object:nil];
}
-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_STOP_WAITING" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_BACK" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_CLOSE" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_WEB_REFLASH" object:nil];
    [super viewDidDisappear:animated];
    [TalkingData trackPageEnd:_viewTitle];
}
-(void)back{
    if(!self.webview.canGoBack){
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else{
        [self.webview goBack];
    }
}
-(void)close{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)refresh{
    [self.webview stopLoading];
    [self.webview reload];
    WebNavBar* bar = (WebNavBar*)[self.view viewWithTag: 501];
    [bar reflashShow:NO];
    [[waitingView sharedwaitingView] waitByMsg:@"正在努力为您加载中……" haveCancel:YES];
}
-(void)stopLoad{
    [self.webview stopLoading];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(reloadweb)];
    //    [self.navigationController popViewControllerAnimated:YES];
}

//页面加载时处理事件
-(void)reloadweb{
    WebNavBar* bar = (WebNavBar*)[self.view viewWithTag: 501];
    [bar reflashShow:NO];
    [[waitingView sharedwaitingView] waitByMsg:@"正在努力为您加载中……" haveCancel:YES];
    NSURL *url =[NSURL URLWithString:_weburl];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [_webview loadRequest:request];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [[waitingView sharedwaitingView] stopWait];
    [[StatusBar sharedStatusBar] talkMsg:@"页面加载失败了" inTime:0.5];
    WebNavBar* bar = (WebNavBar*)[self.view viewWithTag: 501];
    [bar reflashShow:YES];
}

//页面加载完成，导航条显示，预览图隐藏，
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [[waitingView sharedwaitingView] stopWait];
    WebNavBar* bar = (WebNavBar*)[self.view viewWithTag: 501];
    [bar reflashShow:YES];
    if(self.webview.canGoBack){
        [bar closeShow:YES];
    }else{
        [bar closeShow:NO];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString* rurl=[[request URL] resourceSpecifier];
    NSString* scheme = [[request URL] scheme];
    if ([scheme hasPrefix:@"goto"]) {
        NSRange r = [rurl rangeOfString:@"?"];
        NSString* hurl = [rurl substringToIndex:r.location];
        NSString* title_c = [rurl substringFromIndex: r.location+1];
        NSArray* title_a = [title_c componentsSeparatedByString:@"="];
        NSString* newtitel = [[title_a objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        WebNavBar* bar = (WebNavBar*)[self.view viewWithTag: 501];
//        [bar setTitle:newtitel];
        
        NSString* newurl = [[NSString alloc] initWithFormat:@"http:%@",hurl];
        NSURL *url =[NSURL URLWithString:newurl];
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        [_webview loadRequest:request];
        return NO;
    }
    return YES; // 继续对本次请求进行导航
}


@end
