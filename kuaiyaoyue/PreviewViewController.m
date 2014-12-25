//
//  PreviewViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "PreviewViewController.h"
#import "UDObject.h"
#import "FileManage.h"
#import "TalkingData.h"
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
    _webview.alpha = 0;
    tempView = [[ChangeTempView alloc] initWithFrame:CGRectZero];
    tempView.delegate = self;
    tempView.type = _type;//0婚礼,1商务,2玩乐,3自定义
    [tempView loadDate];
    tempView.alpha = 0;
    [self.view addSubview:tempView];
}
-(void)didSelectTemplate:(Template*)items{
    [TalkingData trackEvent:@"更换模版预览"];
//    NSLog(@"Template%@",items);
    [self.delegate didSelectID:[[NSString alloc] initWithFormat:@"%@",items.nefid] andNefmbdw:items.nefmbdw];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *urlpath = [documentsDirectory stringByAppendingString:items.nefmbdw];
    NSString *zipurl = [documentsDirectory stringByAppendingPathComponent:items.nefzipurl];
    [UDObject setWebUrl:zipurl];
    UIImage *bgimg = [self.delegate getimg:urlpath];
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuid= (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
    uuid = [NSString stringWithFormat:@"%@.jpg",uuid];
    NSString *imgpath = [[[FileManage sharedFileManage] imgDirectory] stringByAppendingPathComponent:uuid];
    [UDObject setMbimg:[NSString stringWithFormat:@"../Image/%@",uuid]];
    [UIImageJPEGRepresentation(bgimg,0.8) writeToFile:imgpath atomically:YES];
    [self reloadweb];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [TalkingData trackPageEnd:@"生成前预览"];
    tempView.alpha = 0;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [TalkingData trackPageBegin:@"生成前预览"];
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
    [UIView animateWithDuration:0.4 animations:^{
        _webview.alpha = 1;
        tempView.alpha = 1;
    }];
}

-(NSString *)changevalue{
    NSDictionary *dic = nil;
    //0婚礼,1商务,2玩乐,3自定义
    if (_type == 0) {
        NSString *img = [UDObject gethlimgarr];
        NSArray *arr;
        if ([img length] > 0) {
            arr = [img componentsSeparatedByString:NSLocalizedString(@",", nil)];
        }else{
            arr = [[NSArray alloc] init];
        }
        NSString *musicUrl = [NSString stringWithFormat:@"../Audio/%@",[UDObject gethlmusicname]];
        
        dic = [[NSDictionary alloc] initWithObjectsAndKeys:
               [UDObject getaddress_name],@"address",
               arr,@"images",
               [UDObject getMbimg],@"backgroundImage",
               musicUrl,@"musicUrl",
               nil];
        
    }else if (_type == 1){
        NSString *img = [UDObject getsw_imgarr];
        NSArray *arr;
        if ([img length] > 0) {
            arr = [img componentsSeparatedByString:NSLocalizedString(@",", nil)];
        }else{
            arr = [[NSArray alloc] init];
        }
        NSString *musicUrl = [NSString stringWithFormat:@"../Audio/%@",[UDObject getsw_musicname]];
        dic = [[NSDictionary alloc] initWithObjectsAndKeys:
               [UDObject getswaddress_name],@"address",
               arr,@"images",
               [UDObject getMbimg],@"backgroundImage",
               musicUrl,@"tape",
               [UDObject getswxlr_name],@"contact",
               [UDObject getswxlfs_name],@"telephone",
               nil];
    
    }else if (_type == 2){
        NSString *img = [UDObject getwlimgarr];
        NSArray *arr;
        if ([img length] > 0) {
            arr = [img componentsSeparatedByString:NSLocalizedString(@",", nil)];
        }else{
            arr = [[NSArray alloc] init];
        }
        dic = [[NSDictionary alloc] initWithObjectsAndKeys:
               [UDObject getwladdress_name],@"address",
               arr,@"images",
               [UDObject getMbimg],@"backgroundImage",
               [UDObject getwlaudio],@"tape",
               [UDObject getwllxr_name],@"contact",
               [UDObject getwllxfs_name],@"telephone",
               nil];
    }else if (_type == 3){
        NSString *img = [UDObject getzdyimgarr];
        NSArray *arr;
        if ([img length] > 0) {
            arr = [img componentsSeparatedByString:NSLocalizedString(@",", nil)];
        }else{
            arr = [[NSArray alloc] init];
        }
        
        NSString *musicUrl = [NSString stringWithFormat:@"../Audio/%@",[UDObject getzdymusicname]];
        dic = [[NSDictionary alloc] initWithObjectsAndKeys:
               musicUrl,@"musicUrl",
               arr,@"images",
               nil];
    }
    
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
