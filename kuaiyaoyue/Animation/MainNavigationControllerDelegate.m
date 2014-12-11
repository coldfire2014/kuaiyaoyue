//
//  MainNavigationControllerDelegate.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 14/12/9.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "MainNavigationControllerDelegate.h"
#import "coverAnimation.h"
#import "createNewAnimate.h"
#import "createNewAnimate1.h"
#import "createNewAnimate2.h"
#import "modelListAnimate.h"
@implementation MainNavigationControllerDelegate
- (void)awakeFromNib
{
    [super awakeFromNib];
    
}
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        NSString *str = [toVC.classForCoder description];
        if ([str isEqualToString:@"MenuViewController"]) {
            return [[createNewAnimate2 alloc] initWithPresent:YES];
        } else if ([str isEqualToString:@"TemplateViewController"]) {
            return [[modelListAnimate alloc] initWithPresent:YES];
        } else if ([str isEqualToString:@"ThreeViewController"]) {
            
        } else if ([str isEqualToString:@"FourViewController"]) {
            
        } else {
            return nil;
        }
    } else {
        NSString *str = [fromVC.classForCoder description];
        if ([str isEqualToString:@"MenuViewController"]) {
            return [[createNewAnimate2 alloc] initWithPresent:NO];
        } else if ([str isEqualToString:@"TemplateViewController"]) {
            return [[modelListAnimate alloc] initWithPresent:NO];
        } else if ([str isEqualToString:@"ThreeViewController"]) {
            
        } else if ([str isEqualToString:@"FourViewController"]) {
            
        } else {
            return nil;
        }
    }
    return nil;
}
@end
