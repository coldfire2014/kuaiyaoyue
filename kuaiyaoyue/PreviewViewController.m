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
#import "TimeTool.h"
#import "WebNavBar.h"
@interface PreviewViewController ()

@end

@implementation PreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    self.view.frame = [UIScreen mainScreen].bounds;
    self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 128.0/2.0, w, h-128.0/2.0)];
    self.webview.scalesPageToFit = YES;
    self.webview.delegate = self;
    [self.view addSubview:self.webview];
    WebNavBar* bar = [[WebNavBar alloc] initWithFrame:CGRectMake(0, 0, w, 128.0/2.0)];
    bar.tag = 501;
    [bar setTitle:@"预览"];
    [bar setRight:@"完成"];
    [self.view addSubview:bar];
    [self.view bringSubviewToFront:bar];
    
    tempView = [[ChangeTempView alloc] initWithFrame:self.view.frame];
    tempView.delegate = self;
    tempView.type = _type;//0婚礼,1商务,2玩乐,3自定义
    [tempView loadDate];
    tempView.alpha = 0;
    [self.view addSubview:tempView];    
}

-(void)rightonclick{
     if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
         UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                        delegate:self
                               cancelButtonTitle:@"取消"
                          destructiveButtonTitle:nil
                               otherButtonTitles:@"生成", @"生成并发送", nil];
    
         [sheet showInView:self.view];
     }else{
         UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"生成", @"生成并发送", nil];
         [sheet showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
     }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            [self dismissViewControllerAnimated:YES completion:^{
                [self.delegate didSendType:0];
            }];
            break;
        }
        case 1:
        {
            [self dismissViewControllerAnimated:YES completion:^{
                [self.delegate didSendType:1];
            }];
            break;
        }
        default:
            break;
    }
}


-(void)didSelectTemplate:(Template*)items{
    [TalkingData trackEvent:@"预览时更换模版"];
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
    [UIImageJPEGRepresentation(bgimg,C_JPEG_SIZE) writeToFile:imgpath atomically:YES];
    [self reloadweb];
//    NSFileManager* manager = [NSFileManager defaultManager];
//    unsigned long long size = [[manager attributesOfItemAtPath:imgpath error:nil] fileSize];
//    NSLog(@"%llu",size);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [TalkingData trackPageEnd:@"生成前预览"];
    tempView.alpha = 0;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_BACK" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_CLOSE" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_WEB_REFLASH" object:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [TalkingData trackPageBegin:@"生成前预览"];
    [self reloadweb];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rightonclick) name:@"MSG_WEB_REFLASH" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(close) name:@"MSG_CLOSE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(back) name:@"MSG_BACK" object:nil];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    
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
    WebNavBar* bar = (WebNavBar*)[self.view viewWithTag: 501];
    if(self.webview.canGoBack){
        [bar closeShow:YES];
    }else{
        [bar closeShow:NO];
    }
    [UIView animateWithDuration:0.4 animations:^{
        _webview.alpha = 1;
        if(self.type == 3){
            tempView.alpha = 0;
        }else{
            tempView.alpha = 1;
        }
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
        
        NSString *musicname = [UDObject gethlmusic];
        NSString *musicUrl = @"";
        if (musicname.length > 0) {
            NSArray *array = [musicname componentsSeparatedByString:@"/"];
            musicname = [array objectAtIndex:([array count] - 1)];
            musicUrl = [NSString stringWithFormat:@"../musicFiles/%@",musicname];
        }
        
        
        NSString *title = [NSString stringWithFormat:@"%@ & %@",[UDObject getxl_name],[UDObject getxn_name]];
        NSString *timestamp = [TimeTool getFullTimeStr:[[UDObject gethltime] longLongValue]/1000];
        
        
        dic = [[NSDictionary alloc] initWithObjectsAndKeys:
               [UDObject getaddress_name],@"address",
               arr,@"images",
               [UDObject getMbimg],@"backgroundImage",
               musicUrl,@"musicUrl",
               title,@"title",
               timestamp,@"timestamp",
               nil];
        
    }else if (_type == 1){
        NSString *img = [UDObject getsw_imgarr];
        NSArray *arr;
        if ([img length] > 0) {
            arr = [img componentsSeparatedByString:NSLocalizedString(@",", nil)];
        }else{
            arr = [[NSArray alloc] init];
        }
        NSString *musicname = [UDObject getsw_music];
        NSString *musicUrl = @"";
        if (musicname.length > 0) {
            NSArray *array = [musicname componentsSeparatedByString:@"/"];
            musicname = [array objectAtIndex:([array count] - 1)];
            musicUrl = [NSString stringWithFormat:@"../musicFiles/%@",musicname];
        }
        
        NSString *timestamp = [TimeTool getFullTimeStr:[[UDObject getswtime] longLongValue]/1000];
        
        dic = [[NSDictionary alloc] initWithObjectsAndKeys:
               [UDObject getswaddress_name],@"address",
               arr,@"images",
               [UDObject getMbimg],@"backgroundImage",
               musicUrl,@"tape",
               [UDObject getswxlr_name],@"contact",
               [UDObject getswxlfs_name],@"telephone",
               [UDObject getjhname],@"title",
               timestamp,@"timestamp",
               nil];
    
    }else if (_type == 2){
        NSString *img = [UDObject getwlimgarr];
        NSArray *arr;
        if ([img length] > 0) {
            arr = [img componentsSeparatedByString:NSLocalizedString(@",", nil)];
        }else{
            arr = [[NSArray alloc] init];
        }
        NSString *timestamp = [TimeTool getFullTimeStr:[[UDObject gewltime] longLongValue]/1000];
        NSString *audio = [UDObject getwlaudio];
        if ([audio isEqualToString:@"../Audio/"]) {
            audio = @"";
        }
        
        dic = [[NSDictionary alloc] initWithObjectsAndKeys:
               [UDObject getwladdress_name],@"address",
               arr,@"images",
               [UDObject getMbimg],@"backgroundImage",
               audio,@"tape",
               [UDObject getwllxr_name],@"contact",
               [UDObject getwllxfs_name],@"telephone",
               [UDObject getwljh_name],@"title",
               timestamp,@"timestamp",
               nil];
    }else if (_type == 3){
        NSString *img = [UDObject getzdyimgarr];
        NSArray *arr;
        if ([img length] > 0) {
            arr = [img componentsSeparatedByString:NSLocalizedString(@",", nil)];
        }else{
            arr = [[NSArray alloc] init];
        }
        
        NSString *musicname = [UDObject getzdymusic];
        NSString *musicUrl = @"";
        if (musicname.length > 0) {
            NSArray *array = [musicname componentsSeparatedByString:@"/"];
            musicname = [array objectAtIndex:([array count] - 1)];
            musicUrl = [NSString stringWithFormat:@"../musicFiles/%@",musicname];
        }
        NSString *timestamp = [TimeTool getFullTimeStr:[[UDObject getzdytime] longLongValue]/1000];
        
        dic = [[NSDictionary alloc] initWithObjectsAndKeys:
               musicUrl,@"musicUrl",
               arr,@"images",
               [UDObject getzdytitle],@"title",
               timestamp,@"timestamp",
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
