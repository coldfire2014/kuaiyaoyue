//
//  editSegue.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/2/11.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import "editSegue.h"

@implementation editSegue
-(void) perform{
    UIViewController* src = self.sourceViewController;
    UIViewController* des = self.destinationViewController;
    des.modalPresentationStyle = UIModalPresentationFullScreen;
    des.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    //    des.transitioningDelegate = src;
    [src presentViewController:des animated:YES completion:^{
        
    }];
}
@end
