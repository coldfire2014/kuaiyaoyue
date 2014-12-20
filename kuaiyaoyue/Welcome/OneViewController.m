//
//  OneViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "OneViewController.h"
#import "ShareView.h"
#import "StatusBar.h"
@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    [self.view addGestureRecognizer:tap];
    
}
-(void)didTap{
    ShareView* share = [ShareView sharedShareView];
    share.fromvc = self;
    share.url = @"http://baidu.com";
    share.msg = @"lailai";
    share.title = @"haha";
    NSBundle* bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"imgBar" ofType:@"bundle"]];
    UIImage* img = [[UIImage alloc] initWithContentsOfFile:[bundle pathForResource:@"T4" ofType:@"png"]];
    share.img = [[UIImage alloc] initWithCGImage:img.CGImage scale:2.0 orientation:UIImageOrientationUp];
    [share show];
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (MFMailComposeResultSent == result || MFMailComposeResultSaved == result) {
        [[StatusBar sharedStatusBar] talkMsg:@"分享成功。" inTime:0.51];
    } else {
        [[StatusBar sharedStatusBar] talkMsg:@"消息未发送。" inTime:0.51];
    }
    [controller dismissViewControllerAnimated:YES completion:^{
        ShareView* share = [ShareView sharedShareView];
        share.fromvc = self;
        share.url = @"http://baidu.com";
        share.msg = @"lailai";
        share.title = @"haha";
        NSBundle* bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"imgBar" ofType:@"bundle"]];
        UIImage* img = [[UIImage alloc] initWithContentsOfFile:[bundle pathForResource:@"T4" ofType:@"png"]];
        share.img = [[UIImage alloc] initWithCGImage:img.CGImage scale:2.0 orientation:UIImageOrientationUp];
        [share show];
    }];
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    if (result == MessageComposeResultSent) {
        [[StatusBar sharedStatusBar] talkMsg:@"分享成功。" inTime:0.51];
    } else {
        [[StatusBar sharedStatusBar] talkMsg:@"消息未发送。" inTime:0.51];
    }
    [controller dismissViewControllerAnimated:YES completion:^{
        ShareView* share = [ShareView sharedShareView];
        share.fromvc = self;
        share.url = @"http://baidu.com";
        share.msg = @"lailai";
        share.title = @"haha";
        NSBundle* bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"imgBar" ofType:@"bundle"]];
        UIImage* img = [[UIImage alloc] initWithContentsOfFile:[bundle pathForResource:@"T4" ofType:@"png"]];
        share.img = [[UIImage alloc] initWithCGImage:img.CGImage scale:2.0 orientation:UIImageOrientationUp];
        [share show];
    }];
    
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

@end
