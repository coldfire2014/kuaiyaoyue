//
//  UINavigationController (StatusBarStyle).m
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/1/4.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import "UINavigationController+StatusBarStyle.h"

@implementation UINavigationController (StatusBarStyle)
-(UIViewController *)childViewControllerForStatusBarStyle {
    return self.visibleViewController;
}

-(UIViewController *)childViewControllerForStatusBarHidden {
    return self.visibleViewController;
}
@end
