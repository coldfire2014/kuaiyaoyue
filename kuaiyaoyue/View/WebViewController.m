//
//  WebViewController.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/1/10.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import "WebViewController.h"
#import "waitingView.h"
#import "TalkingData.h"
#import "WebNavBar.h"
#import "PCHeader.h"
@interface WebViewController ()

@end

@implementation WebViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        CGFloat w = 320;
        CGFloat h = 620;
        self.preferredContentSize = CGSizeMake(w, h);
//        self.view.backgroundColor = [UIColor clearColor];
        self.navColor = [[UIColor alloc] initWithWhite:1 alpha:0.95];
        self.navtextColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
    }
    return self;
}
- (void)NavColor:(UIColor *)navColor andtextColor:(UIColor *)textColor{
    self.navColor = navColor;
    self.navtextColor = textColor;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"返回";
    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
    CGFloat h = [[UIScreen mainScreen] bounds].size.height;
    self.view.frame = [UIScreen mainScreen].bounds;
    CGFloat top = 20.0;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if ([_viewTitle compare:@"生成后预览"] == NSOrderedSame) {
            top = 0.0;
            if (ISIOS8LATER) {
                w = 320;
            } else {
                w = 540;
            }
            h = 620;
            self.view.frame = CGRectMake(0, 0, w, h);
        } else if ([_viewTitle compare:@"攻略"] == NSOrderedSame) {
            top = 0.0;
            w = 540;
            h = 620;
            self.view.frame = CGRectMake(0, 0, w, h);
        } else {
            w=IPAD_FRAME.size.width;
            h=IPAD_FRAME.size.height;
            self.view.frame = CGRectMake(0, 0, w, h);
        }
    }
    self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 88.0/2.0+top, w, h-88.0/2.0-top)];
    self.webview.scalesPageToFit = YES;
    self.webview.delegate = self;
    
    [self.view addSubview:self.webview];
    WebNavBar* bar = [[WebNavBar alloc] initWithFrame:CGRectMake(0, 0, w, 88.0/2.0+top) andBgColor:self.navColor andTitleColor:self.navtextColor];
    bar.tag = 501;
    [bar setTitle:_name];
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }
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
        if (nil != self.navigationController) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self dismissViewControllerAnimated:YES completion:^{}];
        }
    }else{
        [self.webview goBack];
    }
}
-(void)close{
    if (nil != self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
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
    WebNavBar* bar = (WebNavBar*)[self.view viewWithTag: 501];
    [bar reflashShow:YES];
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
//    [[StatusBar sharedStatusBar] talkMsg:@"页面加载失败了" inTime:0.5];
    [[waitingView sharedwaitingView] WarningByMsg:@"页面加载失败了" haveCancel:NO];
    [[waitingView sharedwaitingView] performSelector:@selector(stopWait) withObject:nil afterDelay:ERR_TIME];
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
- (BOOL)donotJump:(NSString*)url{
    NSRange range = [url rangeOfString:@"kyy121.com"];
    if (range.length > 0) {
        return YES; // 继续对本次请求进行导航
    }else if([url rangeOfString:@"blank"].length > 0){
        return YES;
    }else if([url rangeOfString:@"t.cn"].length > 0){
        return YES;
    }else if([url rangeOfString:@"map.baidu"].length > 0){
        return YES;
    }else if([url rangeOfString:@"mp.weixin.qq.com"].length > 0){
        return YES;
    }else if([url rangeOfString:@"//"].length == 0){
        return YES;
    }
    return NO;
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString* rurl=[[request URL] resourceSpecifier];
    NSString* scheme = [[request URL] scheme];
    if ([scheme hasPrefix:@"goto"]) {
        
        NSRange r = [rurl rangeOfString:@"?"];
        NSString* hurl = [rurl substringToIndex:r.location];
//        NSString* title_c = [rurl substringFromIndex: r.location+1];
//        NSArray* title_a = [title_c componentsSeparatedByString:@"="];
//        NSString* newtitel = [[title_a objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        WebNavBar* bar = (WebNavBar*)[self.view viewWithTag: 501];
//        [bar setTitle:newtitel];
        NSString* newurl = [[NSString alloc] initWithFormat:@"http:%@",hurl];
        NSURL *url =[NSURL URLWithString:newurl];
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        [_webview loadRequest:request];
        return NO;
    }
    if ([self donotJump:rurl]) {
        return YES; // 继续对本次请求进行导航
    }else{
        [[UIApplication sharedApplication] openURL:[request URL]];
        [TalkingData trackEvent:@"跳转购买" label:rurl];
        return NO;
    }
}

@end
