//
//  createNewAnimate.m
//  SpeciallyEffect
//
//  Created by wuyangbing on 14/12/2.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

#import "createNewAnimate2.h"
#import "CreateBtn.h"
@implementation createNewAnimate2
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
        return 0.8;
    }
    return 0.4;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController* toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (isPresent) {
        [[transitionContext containerView] addSubview:toView.view];
        toView.view.layer.opacity = 1.0;
        fromView.view.layer.opacity = 1.0;
        
        CAKeyframeAnimation* anim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        anim.values = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:1.0],[NSNumber numberWithDouble:1.0], nil];
        anim.removedOnCompletion = NO;
        anim.duration = [self transitionDuration:transitionContext];
        anim.delegate = self;
        [fromView.view.layer addAnimation:anim forKey:@"opacity"];
        
        UIView* bgView = [toView.view viewWithTag:301];
        CreateBtn* btnView = (CreateBtn*)[toView.view viewWithTag:302];
        CAKeyframeAnimation* alphaAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        alphaAnim.values = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:1.0], nil];
        alphaAnim.removedOnCompletion = NO;
        alphaAnim.duration = 0.2;
        [bgView.layer addAnimation:alphaAnim forKey:@"opacity"];
        CAKeyframeAnimation* transformAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        transformAnim.values = [[NSArray alloc] initWithObjects:
                                [NSValue valueWithCATransform3D:CATransform3DIdentity],
                                [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2 + M_PI_4,0,0,1)],nil];
        transformAnim.removedOnCompletion = NO;
        transformAnim.duration = [self transitionDuration:transitionContext]-0.3;
        [btnView.layer addAnimation:transformAnim forKey:@"transform"];
        
        UIView* oneView = [toView.view viewWithTag:401];
        CAKeyframeAnimation* alphaAnim1 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        alphaAnim1.values = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:1.0], nil];
        alphaAnim1.removedOnCompletion = NO;
        CAKeyframeAnimation* transformAnim1 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        transformAnim1.values = [[NSArray alloc] initWithObjects:
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.4, 0.4, 1.0)],
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3, 1.3, 1.0)],
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)],
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.04, 1.04, 1.0)],
                                [NSValue valueWithCATransform3D:CATransform3DIdentity],nil];
        transformAnim1.removedOnCompletion = NO;
        CAAnimationGroup* group1 = [CAAnimationGroup animation];
        group1.animations = [[NSArray alloc] initWithObjects:alphaAnim1,transformAnim1, nil];
        group1.duration = [self transitionDuration:transitionContext]-0.3;
        group1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        group1.removedOnCompletion = NO;
        group1.fillMode = kCAFillModeForwards;
        [oneView.layer addAnimation:group1 forKey:@"one"];
        
        UIView* twoView = [toView.view viewWithTag:402];
        CAKeyframeAnimation* alphaAnim2 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        alphaAnim2.values = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:1.0], nil];
        alphaAnim2.removedOnCompletion = NO;
        CAKeyframeAnimation* transformAnim2 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        transformAnim2.values = [[NSArray alloc] initWithObjects:
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.4, 0.4, 1.0)],
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.4, 0.4, 1.0)],
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3, 1.3, 1.0)],
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)],
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.04, 1.04, 1.0)],
                                 [NSValue valueWithCATransform3D:CATransform3DIdentity],nil];
        transformAnim2.removedOnCompletion = NO;
        CAAnimationGroup* group2 = [CAAnimationGroup animation];
        group2.animations = [[NSArray alloc] initWithObjects:alphaAnim2,transformAnim2, nil];
        group2.duration = [self transitionDuration:transitionContext]-0.2;
        group2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        group2.removedOnCompletion = NO;
        group2.fillMode = kCAFillModeForwards;
        [twoView.layer addAnimation:group2 forKey:@"two"];
        
        UIView* threeView = [toView.view viewWithTag:404];
        CAKeyframeAnimation* alphaAnim3 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        alphaAnim3.values = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:0.33],[NSNumber numberWithDouble:0.66],[NSNumber numberWithDouble:1.0], nil];
        alphaAnim3.removedOnCompletion = NO;
        CAKeyframeAnimation* transformAnim3 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        transformAnim3.values = [[NSArray alloc] initWithObjects:
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.4, 0.4, 1.0)],
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.4, 0.4, 1.0)],
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.4, 0.4, 1.0)],
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3, 1.3, 1.0)],
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)],
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.04, 1.04, 1.0)],
                                 [NSValue valueWithCATransform3D:CATransform3DIdentity],nil];
        transformAnim3.removedOnCompletion = NO;
        CAAnimationGroup* group3 = [CAAnimationGroup animation];
        group3.animations = [[NSArray alloc] initWithObjects:alphaAnim3,transformAnim3, nil];
        group3.duration = [self transitionDuration:transitionContext]-0.1;
        group3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        group3.removedOnCompletion = NO;
        group3.fillMode = kCAFillModeForwards;
        [threeView.layer addAnimation:group3 forKey:@"three"];
        
        UIView* fourView = [toView.view viewWithTag:403];
        CAKeyframeAnimation* alphaAnim4 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        alphaAnim4.values = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:0.5],[NSNumber numberWithDouble:1.0], nil];
        alphaAnim4.removedOnCompletion = NO;
        CAKeyframeAnimation* transformAnim4 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        transformAnim4.values = [[NSArray alloc] initWithObjects:
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.4, 0.4, 1.0)],
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.4, 0.4, 1.0)],
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.4, 0.4, 1.0)],
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.4, 0.4, 1.0)],
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3, 1.3, 1.0)],
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)],
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.04, 1.04, 1.0)],
                                 [NSValue valueWithCATransform3D:CATransform3DIdentity],nil];
        transformAnim4.removedOnCompletion = NO;
        CAAnimationGroup* group4 = [CAAnimationGroup animation];
        group4.animations = [[NSArray alloc] initWithObjects:alphaAnim4,transformAnim4, nil];
        group4.duration = [self transitionDuration:transitionContext];
        group4.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        group4.removedOnCompletion = NO;
        group4.fillMode = kCAFillModeForwards;
        [fourView.layer addAnimation:group4 forKey:@"four"];
        
        _transitionContext = transitionContext;
    } else {
        [[transitionContext containerView] addSubview:toView.view];
        toView.view.alpha = 0.0;
        UIView* bgView = [fromView.view viewWithTag:301];
        CreateBtn* btnView = (CreateBtn*)[fromView.view viewWithTag:302];
        btnView.layer.transform = CATransform3DMakeRotation(3.0*M_PI_4,0,0,1);
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            bgView.alpha = 0;
            btnView.layer.transform = CATransform3DIdentity;
            
        } completion:^(BOOL finished) {
            toView.view.alpha = 1.0;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    UIViewController* fromView = [_transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    fromView.view.layer.opacity = 1.0;
    fromView.view.alpha = 1.0;
    fromView.view.transform = CGAffineTransformIdentity;
    [_transitionContext completeTransition:![_transitionContext transitionWasCancelled]];
}
@end
