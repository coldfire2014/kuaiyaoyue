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
#import "getImgColor.h"
@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSBundle *bundle = [NSBundle mainBundle];
        UIImage* img = [[UIImage alloc] initWithContentsOfFile:[bundle pathForResource:@"1w" ofType:@"jpg"]];
        img = [[UIImage alloc] initWithCGImage:img.CGImage scale:2.0 orientation:UIImageOrientationUp];
        self.view.backgroundColor = [[getImgColor getRGBAsFromImage:img atX:0 andY:0 count:1] objectAtIndex:0];
        myImageView* bg2 = [[myImageView alloc] initWithFrame:self.view.bounds andImageName:@"1w.jpg" withScale:2.0 andAlign:UIImgAlignmentBottom];
        [self.view addSubview:bg2];
        UIImageView* bg = [[UIImageView alloc] initWithImage:img];
        bg.userInteractionEnabled = YES;
        bg.layer.shadowRadius = 3;
        bg.layer.shadowOpacity = 1.0;
        bg.layer.shadowColor = [UIColor grayColor].CGColor;
        bg.layer.shadowOffset = CGSizeMake(2.0, 2.0);
        bg.center = CGPointMake(self.view.bounds.size.width - bg.bounds.size.width, self.view.bounds.size.height/2.0 + 40/2.0);
        [self.view addSubview:bg];
        myImageView* qq_btn = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 227.0/2.0, 59.0/2.0) andImageName:@"btn5s" withScale:2.0];
        
        qq_btn.tag = 101;
        [bg addSubview:qq_btn];
        
        qq_btn.center = CGPointMake(74.0/2.0+227.0/4.0, 700.0/2.0-59.0/4.0);
        UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(QQTap)];
        [qq_btn addGestureRecognizer:tap1];

    } else {
        myImageView* bg = [[myImageView alloc] initWithFrame:self.view.bounds andImageName:@"1w.jpg" withScale:2.0 andAlign:UIImgAlignmentCenter];
        [self.view addSubview:bg];
        myImageView* qq_btn = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 227.0/2.0, 59.0/2.0) andImageName:@"btn5s" withScale:2.0];
        qq_btn.tag = 101;
        [self.view addSubview:qq_btn];
        CGFloat bili = self.view.frame.size.width/320.0;
        
        CGFloat h = 700.0/2.0*bili;
        if (self.view.frame.size.height <= 480.0) {
            h = 700.0/2.0*bili - 44.0;
        }
        qq_btn.center = CGPointMake(74.0/2.0+227.0/4.0, h-59.0/4.0);
        UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(QQTap)];
        [qq_btn addGestureRecognizer:tap1];
    }  
}
-(void)QQTap{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_GO_LOGIN" object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
