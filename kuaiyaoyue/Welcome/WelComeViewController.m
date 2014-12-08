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
@interface WelComeViewController ()

@end

@implementation WelComeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSString *name = nil;
    if ([[UDObject getOPEN] length] > 0) {
        name = @"main";
    }else{
        name = @"wel";
    }
    [self performSegueWithIdentifier:name sender:nil];

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
    NSRange r = [[dismissed.classForCoder description] rangeOfString:@"createViewController"];
    if (r.length == 0 ) {
        picViewAnimate* ca = [[picViewAnimate alloc] initWithPresent:NO];
        return ca;
    } else {
//        createNewAnimate2* ca = [[createNewAnimate2 alloc] initWithPresent:NO];
//        return ca;
    }
    return nil;
}
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    NSString* name = [presented.classForCoder description];
    NSRange r = [name rangeOfString:@"createViewController"];
    if (r.length == 0 ) {
        picViewAnimate* ca = [[picViewAnimate alloc] initWithPresent:YES];
        return ca;
    } else {
        //        static int i = 0;
        //        if (i == 0) {
        //            i++;
        //            createNewAnimate* ca = [[createNewAnimate alloc] initWithPresent:YES];//曲线
        //            return ca;
        //        }
        //        //    else if (i == 1) {
        //        //        i++;
        //        //        createNewAnimate1* ca = [[createNewAnimate1 alloc] initWithPresent:YES];//直线加速
        //        //        return ca;
        //        //    }
        //        else {
        //            i=0;
//        createNewAnimate2* ca = [[createNewAnimate2 alloc] initWithPresent:YES];//弹出（中心弹出）
//        return ca;
        //        }
    }
    return nil;
}
@end
