//
//  modelListAnimate.m
//  SpeciallyEffect
//
//  Created by wuyangbing on 14/12/4.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

#import "modelListAnimate.h"
@implementation modelListAnimate
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
        return 0.5;
    } else {
        return 0.3;
    }
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController* toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (isPresent) {
        [[transitionContext containerView] addSubview:toView.view];
        UIView* oneView = [fromView.view viewWithTag:401];
        UIView* twoView = [fromView.view viewWithTag:402];
        UIView* threeView = [fromView.view viewWithTag:403];
        UIView* fourView = [fromView.view viewWithTag:404];
        
        CAKeyframeAnimation* anim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        anim.values = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:0.3],[NSNumber numberWithDouble:1.0], nil];
        anim.removedOnCompletion = YES;
        anim.duration = [self transitionDuration:transitionContext];
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anim.fillMode = kCAFillModeForwards;
        [toView.view.layer addAnimation:anim forKey:@"anim"];

        CABasicAnimation* scaleAnim1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnim1.fromValue = [NSNumber numberWithDouble:1.0];
        scaleAnim1.toValue = [NSNumber numberWithDouble:0.05];
        scaleAnim1.removedOnCompletion = YES;

        CABasicAnimation* positionAnim1 = [CABasicAnimation animationWithKeyPath:@"position"];
        positionAnim1.fromValue = [NSValue valueWithCGPoint:oneView.center];
        positionAnim1.toValue = [NSValue valueWithCGPoint:CGPointMake(27,42)];
        positionAnim1.removedOnCompletion = YES;
        
        CAAnimationGroup* group1 = [CAAnimationGroup animation];
        group1.animations = [[NSArray alloc] initWithObjects:scaleAnim1,positionAnim1, nil];
        group1.duration = [self transitionDuration:transitionContext];
        group1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        group1.removedOnCompletion = YES;
        group1.fillMode = kCAFillModeForwards;
        group1.delegate = self;
        [oneView.layer addAnimation:group1 forKey:@"one"];
        
        CABasicAnimation* scaleAnim2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnim2.fromValue = [NSNumber numberWithDouble:1.0];
        scaleAnim2.toValue = [NSNumber numberWithDouble:0.05];
        scaleAnim2.removedOnCompletion = YES;
        
        CABasicAnimation* positionAnim2 = [CABasicAnimation animationWithKeyPath:@"position"];
        positionAnim2.fromValue = [NSValue valueWithCGPoint:twoView.center];
        positionAnim2.toValue = [NSValue valueWithCGPoint:CGPointMake(37,42)];
        positionAnim2.removedOnCompletion = YES;
        
        CAAnimationGroup* group2 = [CAAnimationGroup animation];
        group2.animations = [[NSArray alloc] initWithObjects:scaleAnim2,positionAnim2, nil];
        group2.duration = [self transitionDuration:transitionContext];
        group2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        group2.removedOnCompletion = YES;
        group2.fillMode = kCAFillModeForwards;
        [twoView.layer addAnimation:group2 forKey:@"two"];

        CABasicAnimation* scaleAnim3 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnim3.fromValue = [NSNumber numberWithDouble:1.0];
        scaleAnim3.toValue = [NSNumber numberWithDouble:0.05];
        scaleAnim3.removedOnCompletion = YES;
        
        CABasicAnimation* positionAnim3 = [CABasicAnimation animationWithKeyPath:@"position"];
        positionAnim3.fromValue = [NSValue valueWithCGPoint:threeView.center];
        positionAnim3.toValue = [NSValue valueWithCGPoint:CGPointMake(27,54)];
        positionAnim3.removedOnCompletion = YES;
        
        CAAnimationGroup* group3 = [CAAnimationGroup animation];
        group3.animations = [[NSArray alloc] initWithObjects:scaleAnim3,positionAnim3, nil];
        group3.duration = [self transitionDuration:transitionContext];
        group3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        group3.removedOnCompletion = YES;
        group3.fillMode = kCAFillModeForwards;
        [threeView.layer addAnimation:group3 forKey:@"three"];
        
        CABasicAnimation* scaleAnim4 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnim4.fromValue = [NSNumber numberWithDouble:1.0];
        scaleAnim4.toValue = [NSNumber numberWithDouble:0.05];
        scaleAnim4.removedOnCompletion = YES;
        
        CABasicAnimation* positionAnim4 = [CABasicAnimation animationWithKeyPath:@"position"];
        positionAnim4.fromValue = [NSValue valueWithCGPoint:fourView.center];
        positionAnim4.toValue = [NSValue valueWithCGPoint:CGPointMake(37,54)];
        positionAnim4.removedOnCompletion = YES;
        
        CAAnimationGroup* group4 = [CAAnimationGroup animation];
        group4.animations = [[NSArray alloc] initWithObjects:scaleAnim4,positionAnim4, nil];
        group4.duration = [self transitionDuration:transitionContext];
        group4.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        group4.removedOnCompletion = YES;
        group4.fillMode = kCAFillModeForwards;
        [fourView.layer addAnimation:group4 forKey:@"four"];
        _transitionContext = transitionContext;
    }else{
        [[transitionContext containerView] addSubview:toView.view];
        toView.view.alpha = 0.0;
//        UIView* bgView = [fromView.view viewWithTag:301];
//        CreateBtn* btnView = (CreateBtn*)[fromView.view viewWithTag:302];
//        btnView.layer.transform = CATransform3DMakeRotation(3.0*M_PI_4,0,0,1);
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//            bgView.alpha = 0;
//            btnView.layer.transform = CATransform3DIdentity;
            
        } completion:^(BOOL finished) {
            toView.view.alpha = 1.0;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [_transitionContext completeTransition:![_transitionContext transitionWasCancelled]];
}
@end
