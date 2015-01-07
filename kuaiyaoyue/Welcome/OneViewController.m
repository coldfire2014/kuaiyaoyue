//
//  OneViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "OneViewController.h"
#import "waitingView.h"
#import "myImageView.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    myImageView* bg = [[myImageView alloc] initWithFrame:self.view.bounds andImageName:@"1w.jpg" withScale:2.0 andAlign:UIImgAlignmentCenter];
    [self.view addSubview:bg];
    // Do any additional setup after loading the view.
//    UIView* v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 22)];
//    v.backgroundColor = [[UIColor alloc] initWithRed:1 green:0 blue:0 alpha:1];
//    [self.view addSubview:v];
//    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
//    [self.view addGestureRecognizer:tap];
//    tempView = [[ChangeTempView alloc] initWithFrame:CGRectZero];
//    tempView.delegate = self;
//    tempView.type = 1;//0婚礼,1商务,2玩乐,3自定义
//    [tempView loadDate];
//    [self.view addSubview:tempView];
}
-(void)didTap{
    [[waitingView sharedwaitingView] waitByMsg:@"努力加载" haveCancel:YES];
//    [[waitingView sharedwaitingView] startWait];
//    [[StatusBar sharedStatusBar] talkMsg:@"hahah哈哈" inTime:0.5];
//    ShareView* share = [ShareView sharedShareView];
//    share.fromvc = self;
//    share.url = @"http://baidu.com";
//    share.msg = @"lailai";
//    share.title = @"haha";
//    share.imgUrl = @"http://pp.myapp.com/ma_icon/0/icon_11251614_19813241_1418702475/96";
//    NSBundle* bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"imgBar" ofType:@"bundle"]];
//    UIImage* img = [[UIImage alloc] initWithContentsOfFile:[bundle pathForResource:@"T4" ofType:@"png"]];
//    share.img = [[UIImage alloc] initWithCGImage:img.CGImage scale:2.0 orientation:UIImageOrientationUp];
//    [share show];
}
//-(void)didSelectTemplate:(Template*)items{
//    NSLog(@"Template%@",items);
//}


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
