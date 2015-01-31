//
//  TwoViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "TwoViewController.h"
#import "myImageView.h"
@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    myImageView* bg = [[myImageView alloc] initWithFrame:self.view.bounds andImageName:@"2w.jpg" withScale:2.0 andAlign:UIImgAlignmentCenter];
    [self.view addSubview:bg];
    myImageView* qq_btn = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 227.0/2.0, 59.0/2.0) andImageName:@"btn5s" withScale:2.0];
    qq_btn.tag = 101;
    [self.view addSubview:qq_btn];
    CGFloat bili = self.view.frame.size.width/320.0;
    
    CGFloat h = 700.0/2.0*bili;
    if (self.view.frame.size.height <= 480.0) {
        h = 700.0/2.0*bili - 44.0;
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        h = 700.0/2.0*bili - 64.0*bili;
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        h = 520.0/2.0*bili - 64.0*bili;
        qq_btn.center = CGPointMake(74.0/2.0+227.0/4.0, h-59.0/4.0);
    }else{
        qq_btn.center = CGPointMake(74.0/2.0+227.0/4.0, h-59.0/4.0);
    }
    UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(QQTap)];
    [qq_btn addGestureRecognizer:tap1];
}
-(void)QQTap{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_GO_LOGIN" object:nil];
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
