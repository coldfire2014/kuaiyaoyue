//
//  PageViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "PageViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "SiViewController.h"
#import "WXApi.h"
#import "coverAnimation.h"
#import "HttpManage.h"
#import "UDObject.h"
#import "DataBaseManage.h"
#import "UDObject.h"
#import "StatusBar.h"
#import "waitingView.h"
#import "PCHeader.h"
#import "DatetimeInput.h"
@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.dataSource = self;
    self.title = @"返回";
    UIViewController* start = [self viewControllerAtIndex:0];
    NSArray* arr = [[NSArray alloc] initWithObjects:start, nil];
    [self setViewControllers:arr direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gologin) name:@"MSG_GO_LOGIN" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginDine) name:@"MSG_LOGIN_DONE" object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_GO_LOGIN" object:nil];
}
-(void)gologin{
//    commonLogin
    [[DatetimeInput sharedDatetimeInput] show];
//    if ([YINGLOUURL compare:@""] != NSOrderedSame) {
//        [self performSegueWithIdentifier:@"login" sender:nil];
//    } else {
//        [self performSegueWithIdentifier:@"commonLogin" sender:nil];
//    }
}
-(void)loginDine{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_LOGIN_DONE" object:nil];
    [self performSegueWithIdentifier:@"wel2main" sender:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIViewController *)viewControllerAtIndex:(NSInteger) index{
    if ((index < 0) || (index >= 5)) {
        return nil;
    }
    UIViewController *dataViewController = nil;
    if (index == 0) {
//        dataViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"OneViewController"];
        dataViewController = [[OneViewController alloc] init];
    } else if (1 == index) {
        dataViewController = [[TwoViewController alloc] init];
    } else if (2 == index) {
        dataViewController = [[ThreeViewController alloc] init];
    } else if (3 == index) {
        dataViewController = [[SiViewController alloc] init];
    } else {
        return nil;
    }
    // Create a new view controller and pass suitable data.
    return dataViewController;
}

-(NSInteger)indexOfViewController:(UIViewController *)viewController{
    NSString *str = [viewController.classForCoder description];
    if ([str isEqualToString:@"OneViewController"]) {
        return 0;
    } else if ([str isEqualToString:@"TwoViewController"]) {
        return 1;
    } else if ([str isEqualToString:@"ThreeViewController"]) {
        return 2;
    } else if ([str isEqualToString:@"SiViewController"]) {
        return 3;
    } else {
        return NSNotFound;
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [self indexOfViewController:viewController];
    if ((index == 0) || (index == -1)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];

}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [self indexOfViewController:viewController];
    if (index == -1) {
        return nil;
    }
    
    index++;
    return [self viewControllerAtIndex:index];
}

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation{
    NSArray *viewControllers = self.viewControllers[0];
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    self.doubleSided = false;
    return UIPageViewControllerSpineLocationMin;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
//    NSRange r = [[dismissed.classForCoder description] rangeOfString:@"createViewController"];
    coverAnimation* ca = [[coverAnimation alloc] initWithPresent:NO];
    return ca;
}
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
//    NSString* name = [presented.classForCoder description];
//    NSRange r = [name rangeOfString:@"createViewController"];
    coverAnimation* ca = [[coverAnimation alloc] initWithPresent:YES];
    return ca;
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
