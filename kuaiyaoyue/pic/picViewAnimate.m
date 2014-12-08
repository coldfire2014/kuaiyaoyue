//
//  picViewAnimate.m
//  SpeciallyEffect
//
//  Created by wuyangbing on 14/12/7.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

#import "picViewAnimate.h"

@implementation picViewAnimate
- (instancetype)initWithPresent:(BOOL)p
{
    self = [super init];
    if (self) {
        isPresent = p;
    }
    return self;
}
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    if (isPresent) {
        return 0.1;
    } else {
        return 0.1;
    }
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController* toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (isPresent) {
        [[transitionContext containerView] addSubview:toView.view];
        toView.view.alpha = 1;
        fromView.view.alpha = 0;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }else{
        [[transitionContext containerView] addSubview:fromView.view];
        toView.view.alpha = 1;
        fromView.view.alpha = 0;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }
}
@end
