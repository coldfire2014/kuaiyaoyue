//
//  coverAnimation.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 14/12/8.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "coverAnimation.h"

@implementation coverAnimation
- (instancetype)initWithPresent:(BOOL)p
{
    self = [super init];
    if (self) {
        isPresent = p;
    }
    return self;
}
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController* toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (isPresent) {
        [[transitionContext containerView] addSubview:toView.view];
        toView.view.alpha = 1;
        CATransform3D t = CATransform3DIdentity;
        t.m34 = -1.0/900.0;
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromView.view.layer.transform = CATransform3DTranslate(t, 0, 0, 600);
            fromView.view.alpha = 0.0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    }else{
        [[transitionContext containerView] addSubview:fromView.view];
        toView.view.alpha = 1;
        fromView.view.alpha = 0;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }
}
@end
