//
//  MenuViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "MenuViewController.h"
#import "CreateBtn.h"
#import "myImageView.h"
#import "TemplateViewController.h"
#import "UIImageView+LBBlurredImage.h"


@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    UIImageView* bk = [[UIImageView alloc] initWithImage:self.bgimg];
    
    UIVisualEffectView* all = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    all.frame = bk.bounds;
    all.tag = 299;
    [bk addSubview:all];
    UIColor* bgCover;
    if (nil != all) {
        bgCover = [UIColor clearColor];
    } else {
        bgCover = [[UIColor alloc] initWithWhite:0.9 alpha:0.95];
//        bgCover = [UIColor clearColor];
//        [bk setImageToBlur:self.bgimg blurRadius:10.0 completionBlock:^(NSError *error) {
//            
//        }];
        
//        GPUImagePicture *picture = [[GPUImagePicture alloc] initWithImage:img];
//        GPUImageView *webbg2 = [[GPUImageView alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
//        webbg2.layer.contentsGravity = kCAGravityTop;
//        webbg2.clipsToBounds = YES;
//        //        webbg2.layer.cornerRadius = radiu;
//        GPUImageGaussianBlurFilter *_blurFilter = [[GPUImageGaussianBlurFilter alloc] init];//毛玻璃
//        _blurFilter.blurRadiusInPixels = 2.0f;
//        [picture addTarget:_blurFilter];
//        [_blurFilter addTarget:webbg2];
//        [picture processImage];
//        [self.view addSubview:webbg2];
    }
    [self.view addSubview:bk];
    UIView* bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    bgView.backgroundColor = bgCover;
    bgView.layer.opacity = 1;
    bgView.tag = 301;
    [self.view addSubview:bgView];
    CreateBtn* btnView = [[CreateBtn alloc] initWithFrame:CGRectMake(0, 0, 47, 47)];
    btnView.tag = 302;
    btnView.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height-btnView.frame.size.height/2.0 - 12.0);
    btnView.layer.transform = CATransform3DMakeRotation(-M_PI*2.0-M_PI_4,0,0,1);
    [self.view addSubview:btnView];
    CGFloat h = self.view.frame.size.height;
    CGFloat w = self.view.frame.size.width;
    CGFloat ih = 478.0/2.0*(h-80.0)/488.0;
    CGFloat iw = 296.0/2.0*w/320.0;
    if (h == 480.0) {
        ih = 478.0/2.0 - 44.0;
        iw = 296.0/2.0;
    }
//    CGFloat ih = 334.0/2.0*h/568.0;
//    CGFloat iw = 230.0/2.0*w/320.0;
//    if (h == 480.0) {
//        ih = 334.0/2.0;
//        iw = 230.0/2.0;
//    }
    UIView* one = [[UIView alloc] initWithFrame:CGRectMake(w/2.0-3.0-iw, h-62.0-2.0*ih-6.0, iw, ih)];
    
    one.clipsToBounds = YES;
    one.layer.cornerRadius = 3;
    one.tag = 401;
    one.backgroundColor = [UIColor clearColor];
    
    myImageView* oneImg = [[myImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, iw, ih) andImageName:@"card_o" withScale:2.0 andAlign:UIImgAlignmentCenter];
    [one addSubview:oneImg];
    [bgView addSubview:one];
    
    UIView* two = [[UIView alloc] initWithFrame:CGRectMake(w/2.0+3.0, h-62.0-2.0*ih-6.0, iw, ih)];
    two.clipsToBounds = YES;
    two.layer.cornerRadius = 3;
    two.tag = 402;
    two.backgroundColor = [UIColor clearColor];
    
    myImageView* twoImg = [[myImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, iw, ih) andImageName:@"card_b" withScale:2.0 andAlign:UIImgAlignmentCenter];
    [two addSubview:twoImg];
    [bgView addSubview:two];
    
    UIView* three = [[UIView alloc] initWithFrame:CGRectMake(w/2.0-3.0-iw, h-62.0-ih, iw, ih)];
    three.clipsToBounds = YES;
    three.layer.cornerRadius = 3;
    three.tag = 403;
    three.backgroundColor = [UIColor clearColor];
    myImageView* threeImg = [[myImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, iw, ih) andImageName:@"card_r" withScale:2.0 andAlign:UIImgAlignmentCenter];
    [three addSubview:threeImg];
    [bgView addSubview:three];
    
    UIView* four = [[UIView alloc] initWithFrame:CGRectMake(w/2.0+3.0, h-62.0-ih, iw, ih)];
    four.clipsToBounds = YES;
    four.layer.cornerRadius = 3;
    four.tag = 404;
    four.backgroundColor = [UIColor clearColor];
    myImageView* fourImg = [[myImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, iw, ih) andImageName:@"card_g" withScale:2.0 andAlign:UIImgAlignmentCenter];
    [four addSubview:fourImg];
    [bgView addSubview:four];
    
    [self.view bringSubviewToFront:btnView];
    UITapGestureRecognizer* pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [btnView addGestureRecognizer:pan];
    
    UITapGestureRecognizer* tapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOne)];
    [one addGestureRecognizer:tapOne];
    UITapGestureRecognizer* tapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapTwo)];
    [two addGestureRecognizer:tapTwo];
    UITapGestureRecognizer* tapThree = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapThree)];
    [three addGestureRecognizer:tapThree];
    UITapGestureRecognizer* tapFour = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapFour)];
    [four addGestureRecognizer:tapFour];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)back{
//    UIVisualEffectView* all = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
//    all.frame = self.view.bounds;
//    [self.view addSubview:all];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didTapOne{
    self.tapID = 401;
    [self performSegueWithIdentifier:@"showTemplate" sender:@"cihe"];
}
- (void)didTapTwo{
    self.tapID = 402;
    [self performSegueWithIdentifier:@"showTemplate" sender:@"sanwu"];
}
- (void)didTapThree{
    self.tapID = 403;
    [self performSegueWithIdentifier:@"showTemplate" sender:@"hunli"];
}
- (void)didTapFour{
    self.tapID = 404;
    [self performSegueWithIdentifier:@"showTemplate" sender:@"zdy"];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    TemplateViewController* des = (TemplateViewController*)segue.destinationViewController;
    des.bgimg = (UIImage*)self.bgimg;
    des.type = (NSString*)sender;
    NSLog(@"%@",(NSString*)sender);
    
}

@end
