//
//  imgSegue.m
//  SpeciallyEffect
//
//  Created by wuyangbing on 14/12/7.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

#import "imgSegue.h"
//#import "WelComeViewController.h"
@implementation imgSegue
-(void) perform{
    UIViewController* src = self.sourceViewController;
    UIViewController* des = self.destinationViewController;
    des.modalPresentationStyle = UIModalPresentationCustom;
//    des.transitioningDelegate = src;
    [src presentViewController:des animated:YES completion:^{
        
    }];
}
@end
