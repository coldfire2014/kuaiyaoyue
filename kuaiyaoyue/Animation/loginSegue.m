//
//  loginSegue.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/1/26.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import "loginSegue.h"

@implementation loginSegue
-(void) perform{
    UIViewController* src = self.sourceViewController;
    UIViewController* des = self.destinationViewController;
    des.modalPresentationStyle = UIModalPresentationFormSheet;
    des.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    des.transitioningDelegate = src;
    [src presentViewController:des animated:YES completion:^{
        
    }];
}
@end
