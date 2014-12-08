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

@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.dataSource = self;
    
    UIViewController* start = [self viewControllerAtIndex:0];
    NSArray* arr = [[NSArray alloc] initWithObjects:start, nil];
    [self setViewControllers:arr direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIViewController *)viewControllerAtIndex:(int) index{
    if ((index < 0) || (index >= 4)) {
        return nil;
    }
    UIViewController *dataViewController = nil;
    if (index == 0) {
        dataViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"OneViewController"];
    } else if (1 == index) {
        dataViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TwoViewController"];
    } else if (2 == index) {
        dataViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ThreeViewController"];
    } else if (3 == index) {
        dataViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FourViewController"];
    } else {
        return nil;
    }
    // Create a new view controller and pass suitable data.
    return dataViewController;
}

-(int)indexOfViewController:(UIViewController *)viewController{
    NSString *str = [viewController.classForCoder description];
    if ([str isEqualToString:@"OneViewController"]) {
        return 0;
    } else if ([str isEqualToString:@"TwoViewController"]) {
        return 1;
    } else if ([str isEqualToString:@"ThreeViewController"]) {
        return 2;
    } else if ([str isEqualToString:@"FourViewController"]) {
        return 3;
    } else {
        return -1;
    }

}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    int index = [self indexOfViewController:viewController];
    if ((index == 0) || (index == -1)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];

}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    int index = [self indexOfViewController:viewController];
    if ((index == 0) || (index == -1)) {
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
