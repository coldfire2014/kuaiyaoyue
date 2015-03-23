//
//  ThreeViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "ThreeViewController.h"
#import "myImageView.h"
#import "PCHeader.h"
@interface ThreeViewController ()

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSBundle *bundle = [NSBundle mainBundle];
        UIImage* img = [[UIImage alloc] initWithContentsOfFile:[bundle pathForResource:@"3w" ofType:@"jpg"]];
        img = [[UIImage alloc] initWithCGImage:img.CGImage scale:2.0 orientation:UIImageOrientationUp];
        self.view.backgroundColor = [[myImageView getRGBAsFromImage:img atX:0 andY:0 count:1] objectAtIndex:0];
        CGRect f = IPAD_FRAME;
        myImageView* bg2 = [[myImageView alloc] initWithFrame:f andImageName:@"3w.jpg" withScale:2.0 andAlign:UIImgAlignmentBottom];
        [self.view addSubview:bg2];
        CIImage *ciImage = [[CIImage alloc] initWithImage:bg2.image];
        CIVector *center = [CIVector vectorWithX:180 Y:220];
        CIFilter *filter = [CIFilter filterWithName:@"CIVignetteEffect"
                                      keysAndValues:kCIInputImageKey, ciImage,kCIInputRadiusKey,[NSNumber numberWithDouble:100.0],kCIInputCenterKey,center, nil];
//        [filter setDefaults];
        
        CIContext *context = [CIContext contextWithOptions:nil];
        CIImage *outputImage = [filter outputImage];
        CGImageRef cgImage = [context createCGImage:outputImage
                                           fromRect:[outputImage extent]];
        
        bg2.image = [UIImage imageWithCGImage:cgImage];
        
        CGImageRelease(cgImage);
        UIImageView* bg = [[UIImageView alloc] initWithImage:img];
        CGFloat w = f.size.height*320.0/568.0;
        bg.frame = CGRectMake(f.size.width - w, 0, w, f.size.height);
        bg.userInteractionEnabled = YES;
        bg.layer.shadowRadius = 3;
        bg.layer.shadowOpacity = 1.0;
        bg.layer.shadowColor = [UIColor grayColor].CGColor;
        bg.layer.shadowOffset = CGSizeMake(2.0, 2.0);
        
        [self.view addSubview:bg];
        myImageView* qq_btn = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 227.0/2.0, 59.0/2.0) andImageName:@"btn5s" withScale:2.0];
        
        qq_btn.tag = 101;
        [bg addSubview:qq_btn];
        
        qq_btn.center = CGPointMake(74.0/2.0+227.0/4.0, 700.0*f.size.height/568.0/2.0-59.0/4.0);
        UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(QQTap)];
        [qq_btn addGestureRecognizer:tap1];
        
    } else {
        myImageView* bg = [[myImageView alloc] initWithFrame:self.view.bounds andImageName:@"3w.jpg" withScale:2.0 andAlign:UIImgAlignmentCenter];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
