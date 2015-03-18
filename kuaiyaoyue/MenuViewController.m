//
//  MenuViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "MenuViewController.h"
#import "EditViewController.h"
#import "CreateBtn.h"
#import "myImageView.h"
#import "TemplateViewController.h"
#import "UIImageView+LBBlurredImage.h"
#import "StatusBar.h"
#import "TalkingData.h"
#import "DataBaseManage.h"
#import "Template.h"
#import "UDObject.h"
#import "PCHeader.h"
@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"返回";
    self.view.backgroundColor = [UIColor redColor];
    UIImageView* bk = [[UIImageView alloc] initWithImage:_bgimg];
    
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
//        [bk setImageToBlur:self.bgimg blurRadius:10.0 completionBlock:^(NSError *error) {}];
    }
    [self.view addSubview:bk];
    CGRect mainframe = [[UIScreen mainScreen] bounds];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        mainframe = IPAD_FRAME;
    }
    
    UIView* bgView = [[UIView alloc] initWithFrame:mainframe];
    bgView.backgroundColor = bgCover;
    bgView.layer.opacity = 1;
    bgView.tag = 301;
    [self.view addSubview:bgView];
    CreateBtn* btnView = [[CreateBtn alloc] initWithFrame:CGRectMake(0, 0, 47, 47)];
    btnView.tag = 302;
    btnView.center = CGPointMake(mainframe.size.width/2.0, mainframe.size.height-btnView.frame.size.height/2.0 - 12.0);
    btnView.layer.transform = CATransform3DMakeRotation(-M_PI*2.0-M_PI_4,0,0,1);
    [bgView addSubview:btnView];
    CGFloat h = mainframe.size.height;
    CGFloat w = mainframe.size.width;
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
    
    CAGradientLayer* layer = [CAGradientLayer layer];
    CGRect f = CGRectMake(0, 0, one.bounds.size.width, one.bounds.size.height);
    layer.frame = f;
    layer.colors = [[NSArray alloc] initWithObjects:
                    (id)[[UIColor alloc] initWithRed:255.0/255.0 green:154.0/255.0 blue:36.0/255.0 alpha:1.0].CGColor,
                    (id)[[UIColor alloc] initWithRed:255.0/255.0 green:126.0/255.0 blue:00.0/255.0 alpha:1.0].CGColor, nil];
    layer.locations = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:1.0], nil];
    [one.layer addSublayer:layer];
    
    myImageView* oneImg = [[myImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 232.0/2.0, 360.0/2.0) andImageName:@"card_o" withScale:2.0];
    oneImg.center = CGPointMake(one.bounds.size.width/2.0, one.bounds.size.height/2.0);
    [one addSubview:oneImg];
    [bgView addSubview:one];
    
    UIView* two = [[UIView alloc] initWithFrame:CGRectMake(w/2.0+3.0, h-62.0-2.0*ih-6.0, iw, ih)];
    two.clipsToBounds = YES;
    two.layer.cornerRadius = 3;
    two.tag = 402;
    two.backgroundColor = [UIColor clearColor];
    
    CAGradientLayer* layer2 = [CAGradientLayer layer];
    layer2.frame = f;
    layer2.colors = [[NSArray alloc] initWithObjects:
                    (id)[[UIColor alloc] initWithRed:53.0/255.0 green:167.0/255.0 blue:238.0/255.0 alpha:1.0].CGColor,
                    (id)[[UIColor alloc] initWithRed:75.0/255.0 green:105.0/255.0 blue:217.0/255.0 alpha:1.0].CGColor, nil];
    layer2.locations = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:1.0], nil];
    [two.layer addSublayer:layer2];
    
    myImageView* twoImg = [[myImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 232.0/2.0, 360.0/2.0) andImageName:@"card_b" withScale:2.0 andAlign:UIImgAlignmentCenter];
    twoImg.center = CGPointMake(one.bounds.size.width/2.0, one.bounds.size.height/2.0);
    [two addSubview:twoImg];
    [bgView addSubview:two];
    
    UIView* three = [[UIView alloc] initWithFrame:CGRectMake(w/2.0-3.0-iw, h-62.0-ih, iw, ih)];
    three.clipsToBounds = YES;
    three.layer.cornerRadius = 3;
    three.tag = 403;
    three.backgroundColor = [UIColor clearColor];
    
    CAGradientLayer* layer3 = [CAGradientLayer layer];
    layer3.frame = f;
    layer3.colors = [[NSArray alloc] initWithObjects:
                     (id)[[UIColor alloc] initWithRed:255.0/255.0 green:103.0/255.0 blue:154.0/255.0 alpha:1.0].CGColor,
                     (id)[[UIColor alloc] initWithRed:255.0/255.0 green:109.0/255.0 blue:110.0/255.0 alpha:1.0].CGColor, nil];
    layer3.locations = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:1.0], nil];
    [three.layer addSublayer:layer3];
    
    myImageView* threeImg = [[myImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 232.0/2.0, 360.0/2.0) andImageName:@"card_r" withScale:2.0 andAlign:UIImgAlignmentCenter];
    threeImg.center = CGPointMake(one.bounds.size.width/2.0, one.bounds.size.height/2.0);
    [three addSubview:threeImg];
    [bgView addSubview:three];
    
    UIView* four = [[UIView alloc] initWithFrame:CGRectMake(w/2.0+3.0, h-62.0-ih, iw, ih)];
    four.clipsToBounds = YES;
    four.layer.cornerRadius = 3;
    four.tag = 404;
    four.backgroundColor = [UIColor clearColor];
    
    CAGradientLayer* layer4 = [CAGradientLayer layer];
    layer4.frame = f;
    layer4.colors = [[NSArray alloc] initWithObjects:
                     (id)[[UIColor alloc] initWithRed:38.0/255.0 green:214.0/255.0 blue:90.0/255.0 alpha:1.0].CGColor,
                     (id)[[UIColor alloc] initWithRed:40.0/255.0 green:216.0/255.0 blue:143.0/255.0 alpha:1.0].CGColor, nil];
    layer4.locations = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:1.0], nil];
    [four.layer addSublayer:layer4];
    
    myImageView* fourImg = [[myImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 232.0/2.0, 360.0/2.0) andImageName:@"card_g" withScale:2.0 andAlign:UIImgAlignmentCenter];
    fourImg.center = CGPointMake(one.bounds.size.width/2.0, one.bounds.size.height/2.0);
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
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [TalkingData trackPageBegin:@"新建菜单"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [TalkingData trackPageEnd:@"新建菜单"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
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
    _tapID = 401;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self performSegueWithIdentifier:@"newedit" sender:@"3"];
    } else {
        [self performSegueWithIdentifier:@"showTemplate" sender:@"cihe"];
    }
    [TalkingData trackEvent:@"开启吃喝玩乐编辑"];
}
- (void)didTapTwo{
    _tapID = 402;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self performSegueWithIdentifier:@"newedit" sender:@"2"];
    } else {
        [self performSegueWithIdentifier:@"showTemplate" sender:@"sanwu"];
    }
    [TalkingData trackEvent:@"开启商务编辑"];
}
- (void)didTapThree{
    _tapID = 403;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self performSegueWithIdentifier:@"newedit" sender:@"1"];
    } else {
        [self performSegueWithIdentifier:@"showTemplate" sender:@"hunli"];
    }
    [TalkingData trackEvent:@"开启婚礼编辑"];
}
- (void)didTapFour{
    _tapID = 404;
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self performSegueWithIdentifier:@"newedit" sender:@"4"];
//    } else {
//        [self performSegueWithIdentifier:@"zdyedit" sender:nil];
//    }
    [TalkingData trackEvent:@"开启自定义编辑"];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier compare:@"newedit"] == NSOrderedSame){
        EditViewController* edit = (EditViewController*)segue.destinationViewController;
        edit.typeid = (NSString*)sender;
        if ([edit.typeid compare:@"1"] == NSOrderedSame) {//婚礼
            
        }else if([edit.typeid compare:@"2"] == NSOrderedSame) {//商务
            
        }else if([edit.typeid compare:@"3"] == NSOrderedSame) {//玩乐
            
        }else if([edit.typeid compare:@"4"] == NSOrderedSame) {//自定义
            NSArray *data = [[DataBaseManage getDataBaseManage] GetTemplate:@"4"];
            Template *info = [data objectAtIndex:0];
            edit.tempId = [NSString stringWithFormat:@"%@",info.nefid];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *zipurl = [documentsDirectory stringByAppendingPathComponent:info.nefzipurl];
            [UDObject setWebUrl:zipurl];
            edit.tempLoc = @"";
        }
    }
    else{
        TemplateViewController* des = (TemplateViewController*)segue.destinationViewController;
        des.bgimg = _bgimg;
        des.type = (NSString*)sender;
        NSLog(@"%@",(NSString*)sender);
    }
}

@end
