//
//  modelSegue.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/1/26.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import "modelSegue.h"

@implementation modelSegue
-(void) perform{
    UIViewController* src = self.sourceViewController;
    UIViewController* des = self.destinationViewController;
    des.modalPresentationStyle = UIModalPresentationFormSheet;
    des.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    des.transitioningDelegate = src;
    [src presentViewController:des animated:YES completion:^{
        
    }];
}
@end
