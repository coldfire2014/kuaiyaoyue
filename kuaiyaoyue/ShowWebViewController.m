//
//  ShowWebViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/24.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "ShowWebViewController.h"
#import "TalkingData.h"
#import "waitingView.h"
#import "StatusBar.h"
@interface ShowWebViewController (){
    NSString *newtitel;
    NSString *newurl;
}

@end

@implementation ShowWebViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"返回";
    _webview.scalesPageToFit = YES;
    _webview.delegate = self;
    UIColor *color = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    label.text = _name;
    [label sizeToFit];
    label.textColor = color;
    label.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    [self.navigationItem setTitleView:label];
    
    [self.navigationController.navigationBar setTintColor:color];
    
    [self reloadweb];
    
}

-(void)initContent:(NSString *)name weburl:(NSString *)weburl{
    _weburl = weburl;
    _name = name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [self.navigationController.navigationBar setHidden:NO];
    [TalkingData trackPageBegin:@"生成后预览"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopLoad) name:@"MSG_STOP_WAITING" object:nil];
}
-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_STOP_WAITING" object:nil];
    [super viewDidDisappear:animated];
    [TalkingData trackPageEnd:@"生成后预览"];
}
-(void)stopLoad{
    [self.webview stopLoading];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(reloadweb)];
//    [self.navigationController popViewControllerAnimated:YES];
}

//页面加载时处理事件
-(void)reloadweb{
    self.navigationItem.rightBarButtonItem = nil;
    [[waitingView sharedwaitingView] waitByMsg:@"正在努力为您加载中……" haveCancel:YES];
    NSURL *url =[NSURL URLWithString:_weburl];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [_webview loadRequest:request];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [[waitingView sharedwaitingView] stopWait];
    [[StatusBar sharedStatusBar] talkMsg:@"页面加载失败了" inTime:0.5];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(reloadweb)];
//    [self.navigationController popViewControllerAnimated:YES];
}

//页面加载完成，导航条显示，预览图隐藏，
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [[waitingView sharedwaitingView] stopWait];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(reloadweb)];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString* rurl=[[request URL] resourceSpecifier];
    NSString* scheme = [[request URL] scheme];
    if ([scheme hasPrefix:@"goto"]) {
        NSRange r = [rurl rangeOfString:@"?"];
        NSString* hurl = [rurl substringToIndex:r.location];
        NSString* title_c = [rurl substringFromIndex: r.location+1];
        NSArray* title_a = [title_c componentsSeparatedByString:@"="];
        newtitel = [[title_a objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        newurl = [[NSString alloc] initWithFormat:@"http:%@",hurl];
        
        [self performSegueWithIdentifier:@"showurl" sender:nil];
        //
        //用newURL跳转新的 浏览器 title是标题
        //
        return NO;
    }
    return YES; // 继续对本次请求进行导航
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier compare:@"showurl"] == NSOrderedSame){
        ShowWebViewController *view = (ShowWebViewController*)segue.destinationViewController;
        [view initContent:newtitel weburl:newurl];
    }
    
}


@end
