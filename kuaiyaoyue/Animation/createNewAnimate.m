//
//  createNewAnimate.m
//  SpeciallyEffect
//
//  Created by wuyangbing on 14/12/2.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

#import "createNewAnimate.h"
#import "CreateBtn.h"
@implementation createNewAnimate
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
    }
    return 0.3;
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
        transformAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transformAnim.duration = [self transitionDuration:transitionContext];
        [btnView.layer addAnimation:transformAnim forKey:@"transform"];
        
        UIView* oneView = [toView.view viewWithTag:401];
        UIView* twoView = [toView.view viewWithTag:402];
        UIView* threeView = [toView.view viewWithTag:404];
        UIView* fourView = [toView.view viewWithTag:403];
        CGRect sSize = [UIScreen mainScreen].bounds;
        
        CAKeyframeAnimation* alphaAnim1 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        alphaAnim1.values = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:1.0], nil];
        alphaAnim1.removedOnCompletion = YES;
        CABasicAnimation* scaleAnim1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnim1.fromValue = [NSNumber numberWithDouble:0.0];
        scaleAnim1.toValue = [NSNumber numberWithDouble:1.0];
        scaleAnim1.removedOnCompletion = YES;
        
        UIBezierPath* aPath = [UIBezierPath bezierPath];
        aPath.lineWidth = 5.0;
        aPath.lineCapStyle = kCGLineCapRound; //线条拐角
        aPath.lineJoinStyle = kCGLineCapRound; //终点处理
        [aPath moveToPoint:CGPointMake(0, 0)];
        [aPath addQuadCurveToPoint:oneView.center controlPoint:CGPointMake(oneView.center.x, 0)];
        
        CAKeyframeAnimation* positionAnim1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        positionAnim1.path = aPath.CGPath;
        positionAnim1.removedOnCompletion = YES;
        CAAnimationGroup* group1 = [CAAnimationGroup animation];
        group1.animations = [[NSArray alloc] initWithObjects:alphaAnim1,positionAnim1,scaleAnim1, nil];
        group1.duration = [self transitionDuration:transitionContext];
        group1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        group1.removedOnCompletion = YES;
        group1.fillMode = kCAFillModeForwards;
        [oneView.layer addAnimation:group1 forKey:@"one"];
        
        CAKeyframeAnimation* alphaAnim2 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        alphaAnim2.values = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:1.0], nil];
        alphaAnim2.removedOnCompletion = NO;
        CABasicAnimation* scaleAnim2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnim2.fromValue = [NSNumber numberWithDouble:0.0];
        scaleAnim2.toValue = [NSNumber numberWithDouble:1.0];
        scaleAnim2.removedOnCompletion = YES;
        
        UIBezierPath* bPath = [UIBezierPath bezierPath];
        bPath.lineWidth = 5.0;
        bPath.lineCapStyle = kCGLineCapRound; //线条拐角
        bPath.lineJoinStyle = kCGLineCapRound; //终点处理
        [bPath moveToPoint:CGPointMake(sSize.size.width, 0)];
        [bPath addQuadCurveToPoint:twoView.center controlPoint:CGPointMake(sSize.size.width,twoView.center.y)];
        
        CAKeyframeAnimation* positionAnim2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        positionAnim2.path = bPath.CGPath;
        positionAnim2.removedOnCompletion = YES;
        CAAnimationGroup* group2 = [CAAnimationGroup animation];
        group2.animations = [[NSArray alloc] initWithObjects:alphaAnim2,positionAnim2,scaleAnim2, nil];
        group2.duration = [self transitionDuration:transitionContext];
        group2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        group2.removedOnCompletion = NO;
        group2.fillMode = kCAFillModeForwards;
        [twoView.layer addAnimation:group2 forKey:@"two"];
        
        
        CAKeyframeAnimation* alphaAnim3 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        alphaAnim3.values = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:1.0], nil];
        alphaAnim3.removedOnCompletion = NO;
        CABasicAnimation* scaleAnim3 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnim3.fromValue = [NSNumber numberWithDouble:0.0];
        scaleAnim3.toValue = [NSNumber numberWithDouble:1.0];
        scaleAnim3.removedOnCompletion = YES;
        
        UIBezierPath* cPath = [UIBezierPath bezierPath];
        cPath.lineWidth = 5.0;
        cPath.lineCapStyle = kCGLineCapRound; //线条拐角
        cPath.lineJoinStyle = kCGLineCapRound; //终点处理
        [cPath moveToPoint:CGPointMake(sSize.size.width, sSize.size.height)];
        [cPath addQuadCurveToPoint:threeView.center controlPoint:CGPointMake(threeView.center.x, sSize.size.height)];
        
        CAKeyframeAnimation* positionAnim3 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        positionAnim3.path = cPath.CGPath;
        positionAnim3.removedOnCompletion = YES;
        CAAnimationGroup* group3 = [CAAnimationGroup animation];
        group3.animations = [[NSArray alloc] initWithObjects:alphaAnim3,positionAnim3,scaleAnim3, nil];
        group3.duration = [self transitionDuration:transitionContext];
        group3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        group3.removedOnCompletion = NO;
        group3.fillMode = kCAFillModeForwards;
        [threeView.layer addAnimation:group3 forKey:@"three"];
        
        
        CAKeyframeAnimation* alphaAnim4 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        alphaAnim4.values = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:1.0], nil];
        alphaAnim4.removedOnCompletion = NO;
        CABasicAnimation* scaleAnim4 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnim4.fromValue = [NSNumber numberWithDouble:0.0];
        scaleAnim4.toValue = [NSNumber numberWithDouble:1.0];
        scaleAnim4.removedOnCompletion = YES;
        
        UIBezierPath* dPath = [UIBezierPath bezierPath];
        dPath.lineWidth = 5.0;
        dPath.lineCapStyle = kCGLineCapRound; //线条拐角
        dPath.lineJoinStyle = kCGLineCapRound; //终点处理
        [dPath moveToPoint:CGPointMake(0, sSize.size.height)];
        [dPath addQuadCurveToPoint:fourView.center controlPoint:CGPointMake(0,fourView.center.y)];
        
        CAKeyframeAnimation* positionAnim4 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        positionAnim4.path = dPath.CGPath;
        positionAnim4.removedOnCompletion = YES;
        CAAnimationGroup* group4 = [CAAnimationGroup animation];
        group4.animations = [[NSArray alloc] initWithObjects:alphaAnim4,positionAnim4,scaleAnim4, nil];
        group4.duration = [self transitionDuration:transitionContext];
        group4.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
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
    [_transitionContext completeTransition:![_transitionContext transitionWasCancelled]];
}
@end
