//
//  w2mainSegue.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 14/12/8.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "w2mainSegue.h"
#import "PageViewController.h"
@implementation w2mainSegue
-(void) perform{
    PageViewController* src = self.sourceViewController;
    UIViewController* des = self.destinationViewController;
    des.modalPresentationStyle = UIModalPresentationCustom;
    des.transitioningDelegate = src;
    [src presentViewController:des animated:YES completion:^{
        
    }];
}
@end
