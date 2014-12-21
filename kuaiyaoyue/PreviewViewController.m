//
//  PreviewViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "PreviewViewController.h"
#import "UDObject.h"

@interface PreviewViewController ()

@end

@implementation PreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIColor *color = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    label.text = @"预览";
    [label sizeToFit];
    label.textColor = color;
    label.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    [self.navigationItem setTitleView:label];
    
    _webview.scalesPageToFit = YES;
    _webview.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self reloadweb];
}

//页面加载时处理事件
-(void)reloadweb{
    NSString *urlpath = [UDObject getWebUrl];
    urlpath = [[NSString alloc] initWithFormat:@"%@/%@",urlpath,@"index.html"];
    NSString *htmlString = [[NSString alloc] initWithContentsOfFile:urlpath encoding:NSUTF8StringEncoding error:nil];
    [_webview loadHTMLString:htmlString baseURL:[NSURL URLWithString:urlpath]];
}

#pragma mark - web
//接收页面js消息，其实就是页面跳转到一个不可能的链接
//如nef://callback/class/method/params，链接中可以包含我们需要的信息
//我想在这里隐藏导航条等控件。
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES; // 继续对本次请求进行导航
}

//页面加载完成，导航条显示，预览图隐藏，
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_webview stringByEvaluatingJavaScriptFromString:[self changevalue]];
}

-(NSString *)changevalue{
    
    NSString *img = [UDObject gethlimgarr];
    
    NSArray *arr;
    if ([img length] > 0) {
        arr = [img componentsSeparatedByString:NSLocalizedString(@",", nil)];
    }else{
        arr = [[NSArray alloc] init];
    }
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:
                         @"",@"groom",
                         @"",@"bride",
                         @"",@"date",
                         @"",@"address",
                         @"",@"location",
                         arr,@"images",
                         [UDObject getMbimg],@"backgroundImage",
                         nil];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    content = [NSString stringWithFormat:@"changeUserInfo('%@');",content];
    NSLog(@"%@",content);
    return content;
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
