//
//  WelComeViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "WelComeViewController.h"
#import "UDObject.h"
#import "picViewAnimate.h"
#import "coverAnimation.h"
#import "ZipDown.h"
#import "TalkingData.h"
#import "myImageView.h"
@interface WelComeViewController ()

@end

@implementation WelComeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    myImageView* bg = [[myImageView alloc] initWithFrame:self.view.bounds andImageName:@"bg_login.jpg" withScale:2.0 andAlign:UIImgAlignmentCenter];
//    [self.view addSubview:bg];
//    myImageView* logo = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 318.0/2.0, 344.0/2.0) andImageName:@"logo_login" withScale:2.0 andAlign:UIImgAlignmentCenter];
//    logo.center = CGPointMake(self.view.bounds.size.width/2.0, (self.view.bounds.size.height - 478.0/2.0)/2.0);
//    [self.view addSubview:logo];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
-(BOOL)prefersStatusBarHidden{
    return NO;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    downloadDone = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doneZip) name:@"ZIP_DONE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doneDownload) name:@"DOWNLOAD_DONE" object:nil];
}
-(void)viewDidDisappear:(BOOL)animated{
    [TalkingData trackPageEnd:@"加载页面"];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ZIP_DONE" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"DOWNLOAD_DONE" object:nil];
}
-(void)doneDownload{
    downloadDone = YES;
    NSString *name = nil;
    if (downloadDone && zipDone) {
        NSLog(@"%@",[UDObject gettoken]);
        if ([[UDObject gettoken] length] > 0) {
            name = @"main";
        }else{
            name = @"wel";
        }
        [self performSegueWithIdentifier:name sender:nil];
    }
}
-(void)doneZip{
    zipDone = YES;
    NSString *name = nil;
    if (downloadDone && zipDone) {
        if ([[UDObject gettoken] length] > 0) {
            name = @"main";
        }else{
            name = @"wel";
        }
        [self performSegueWithIdentifier:name sender:nil];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    [TalkingData trackPageBegin:@"加载页面"];
    NSString *name = nil;
    if ([[UDObject gettoken] length] > 0) {
        zipDone = YES;
        name = @"main";
    }else{
        name = @"wel";
        zipDone = NO;
        [ZipDown Unzip];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier compare:@"imgSelect"] == NSOrderedSame ) {
        ImgCollectionViewController* des = (ImgCollectionViewController*)segue.destinationViewController;
        des.maxCount = 2;
        des.needAnimation = YES;
        des.delegate = self;
    } else {
//        createViewController* des = (createViewController*)segue.destinationViewController;
//        des.bgimg = (UIImage*)sender;
    }
}


- (IBAction)onclick:(id)sender {
//    [self performSegueWithIdentifier:@"main" sender:nil];
    [self performSegueWithIdentifier:@"imgSelect" sender:nil];

}
-(void)didSelectAssets:(NSArray*)items{
    
    for (ALAsset* asset in items) {
        UIImage* img = [ASSETHELPER getImageFromAsset:asset type:ASSET_PHOTO_SCREEN_SIZE];
        NSLog(@"%@",img);
    }
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    NSRange r = [[dismissed.classForCoder description] rangeOfString:@"ImgCollectionViewController"];
    if (r.length > 0 ) {
        picViewAnimate* ca = [[picViewAnimate alloc] initWithPresent:NO];
        return ca;
    } else {
        coverAnimation* ca = [[coverAnimation alloc] initWithPresent:NO];
        return ca;
    }
    return nil;
}
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    NSString* name = [presented.classForCoder description];
    NSRange r = [name rangeOfString:@"ImgCollectionViewController"];
    if (r.length > 0 ) {
        picViewAnimate* ca = [[picViewAnimate alloc] initWithPresent:YES];
        return ca;
    } else {
        coverAnimation* ca = [[coverAnimation alloc] initWithPresent:YES];
        return ca;
    }
    return nil;
}
@end
