//
//  coverSegue.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 14/12/8.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "coverSegue.h"
#import "PCHeader.h"
#import "WelComeViewController.h"
@implementation coverSegue
-(void) perform{
    WelComeViewController* src = self.sourceViewController;
    UIViewController* des = self.destinationViewController;
    des.modalPresentationStyle = UIModalPresentationCustom;
    des.transitioningDelegate = src;
    [src presentViewController:des animated:YES completion:^{
        
    }];
}
@end
