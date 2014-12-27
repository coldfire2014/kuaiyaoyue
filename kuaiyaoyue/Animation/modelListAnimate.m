//
//  modelListAnimate.m
//  SpeciallyEffect
//
//  Created by wuyangbing on 14/12/4.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

#import "modelListAnimate.h"
#import "MenuBackBtn.h"
#import "MenuViewController.h"
#import "ctView.h"
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
        return 1.3;
    } else {
        return 0.5;
    }
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController* toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (isPresent) {
        [[transitionContext containerView] addSubview:toView.view];
        MenuViewController* mvc = (MenuViewController*)fromView;
        int tapID = mvc.tapID;
        UIView* btnBack = [fromView.view viewWithTag:302];
        UIView* bg = [fromView.view viewWithTag:301];
        UIView* bk = [toView.view viewWithTag:289];
        bk.layer.opacity = 0;
        ctView* tempView = (ctView*)[toView.view viewWithTag:404];
        tempView.layer.opacity = 0;
        UIView* backall = [toView.view viewWithTag:304];
        backall.layer.opacity = 0;
        MenuBackBtn* backBtn = (MenuBackBtn*)[toView.view viewWithTag:303];
        backBtn.layer.opacity = 0;
        UIView* btnEdit = [toView.view viewWithTag:302];
        btnEdit.layer.opacity = 0;
        CGSize tempSize = tempView.itemSize;
        CGPoint tempCenter = tempView.center;
        CAKeyframeAnimation* animopacity = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        animopacity.values = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:1.0],[NSNumber numberWithDouble:0.0], nil];
        animopacity.removedOnCompletion = YES;
        UIView* theView;
        for (int i = 1; i < 5; i++) {
            
            if (tapID == 400+i) {
                theView = [fromView.view viewWithTag:tapID];
                [bg bringSubviewToFront: theView];
                double scalex = tempSize.width/theView.frame.size.width;
                double scaley = tempSize.height/theView.frame.size.height;
                CABasicAnimation* scaleAnimx = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
                scaleAnimx.fromValue = [NSNumber numberWithDouble:1.0];
                scaleAnimx.toValue = [NSNumber numberWithDouble:scalex];
                scaleAnimx.removedOnCompletion = NO;
                CABasicAnimation* scaleAnimy = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
                scaleAnimy.fromValue = [NSNumber numberWithDouble:1.0];
                scaleAnimy.toValue = [NSNumber numberWithDouble:scaley];
                scaleAnimy.removedOnCompletion = NO;
                CABasicAnimation* positionAnim = [CABasicAnimation animationWithKeyPath:@"position"];
                positionAnim.fromValue = [NSValue valueWithCGPoint:theView.center];
                positionAnim.toValue = [NSValue valueWithCGPoint:tempCenter];
                positionAnim.removedOnCompletion = NO;
                CAAnimationGroup* group1 = [CAAnimationGroup animation];
                group1.animations = [[NSArray alloc] initWithObjects:scaleAnimx,scaleAnimy,positionAnim, nil];
                group1.duration = 0.4;
                group1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
                group1.removedOnCompletion = NO;
                group1.fillMode = kCAFillModeForwards;
//                group1.delegate = self;
                [theView.layer addAnimation:group1 forKey:@"one"];
            } else {
                UIView* otherView = [fromView.view viewWithTag:400+i];
                CABasicAnimation* scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
                scaleAnim.fromValue = [NSNumber numberWithDouble:1.0];
                scaleAnim.toValue = [NSNumber numberWithDouble:0.05];
                scaleAnim.removedOnCompletion = YES;
                CAAnimationGroup* group1 = [CAAnimationGroup animation];
                group1.animations = [[NSArray alloc] initWithObjects:animopacity,scaleAnim, nil];
                group1.duration = 0.4;
                group1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                group1.removedOnCompletion = YES;
                group1.fillMode = kCAFillModeForwards;
                [otherView.layer addAnimation:group1 forKey:@"one"];
            }
        }
        CABasicAnimation* scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnim.fromValue = [NSNumber numberWithDouble:1.0];
        scaleAnim.toValue = [NSNumber numberWithDouble:0.05];
        scaleAnim.removedOnCompletion = YES;
        CAAnimationGroup* group1 = [CAAnimationGroup animation];
        group1.animations = [[NSArray alloc] initWithObjects:animopacity,scaleAnim, nil];
        group1.duration = 0.4;
        group1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        group1.removedOnCompletion = YES;
        group1.fillMode = kCAFillModeForwards;
        [btnBack.layer addAnimation:group1 forKey:@"one"];
        CATransform3D t = CATransform3DIdentity;
        t.m34 = -1.0/900.0;
        btnEdit.layer.transform = CATransform3DTranslate(t, 0, 0, -900);
        
        CAKeyframeAnimation* animopacity2 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        animopacity2.values = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:1.0],[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:0.0], nil];
        animopacity2.removedOnCompletion = YES;
        animopacity2.duration = [self transitionDuration:transitionContext];
        animopacity2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animopacity2.fillMode = kCAFillModeForwards;
        [btnBack.layer addAnimation:animopacity2 forKey:@"two"];
        for (int i = 1; i < 5; i++) {
            if (tapID != 400+i) {
                UIView* otherView = [fromView.view viewWithTag:400+i];
                [otherView.layer addAnimation:animopacity2 forKey:@"two"];
            }
        }
        [UIView animateWithDuration:0.5 delay:0.4 options:UIViewAnimationOptionCurveLinear animations:^{
            theView.layer.opacity = 0;
            tempView.layer.opacity = 1;
            btnEdit.layer.opacity = 1;
            
            btnEdit.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            
        }];
        
        backall.layer.transform = CATransform3DTranslate(t, 0, 0, 500);
        backBtn.layer.transform = CATransform3DTranslate(t, 0, 0, 500);
        
        [UIView animateWithDuration:0.4 delay:0.9 options:UIViewAnimationOptionCurveEaseIn animations:^{
            bk.layer.opacity = 1;
            backall.layer.opacity = 1;
            backall.layer.transform = CATransform3DIdentity;
            backBtn.layer.opacity = 1;
            backBtn.layer.transform = CATransform3DIdentity;
            
        } completion:^(BOOL finished) {
            [theView.layer removeAllAnimations];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
    }else{
        [[transitionContext containerView] addSubview:toView.view];
        toView.view.alpha = 1.0;
        fromView.view.alpha = 1.0;
        UIView* btnBack = [toView.view viewWithTag:302];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            for (int i = 1; i < 5; i++) {
                UIView* otherView = [toView.view viewWithTag:400+i];
                otherView.layer.opacity = 1;
                otherView.layer.transform = CATransform3DIdentity;
            }
            btnBack.layer.opacity = 1;
//            btnBack.layer.transform = CATransform3DIdentity;
            toView.view.alpha = 1.0;
            fromView.view.alpha = 0.0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [_transitionContext completeTransition:![_transitionContext transitionWasCancelled]];
}
@end
