//
//  createNewAnimate.m
//  SpeciallyEffect
//
//  Created by wuyangbing on 14/12/2.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

#import "createNewAnimate1.h"
#import "CreateBtn.h"
@implementation createNewAnimate1
- (instancetype)initWithPresent:(BOOL)p
{
    self = [super init];
    if (self) {
        isPresent = p;
    }
    return self;
}
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.6;
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
        anim.duration = 0.68;
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
        transformAnim.duration = 0.2;
        [btnView.layer addAnimation:transformAnim forKey:@"transform"];
        
        CATransform3D t = CATransform3DIdentity;//CATransform3DMakeScale(2.0, 2.0, 2.0);
        UIView* oneView = [toView.view viewWithTag:401];
        CAKeyframeAnimation* alphaAnim1 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        alphaAnim1.values = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:1.0], nil];
        alphaAnim1.removedOnCompletion = NO;
        CAKeyframeAnimation* transformAnim1 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        transformAnim1.values = [[NSArray alloc] initWithObjects:
                                [NSValue valueWithCATransform3D:CATransform3DTranslate(t, -oneView.frame.size.width, -oneView.frame.size.height, 0)],
                                [NSValue valueWithCATransform3D:CATransform3DTranslate(t, -oneView.frame.size.width*9.0/10.0, -oneView.frame.size.height*9.0/10.0, 0)],
                                [NSValue valueWithCATransform3D:CATransform3DTranslate(t, -oneView.frame.size.width*7.0/10.0, -oneView.frame.size.height*7.0/10.0, 0)],
                                [NSValue valueWithCATransform3D:CATransform3DTranslate(t, -oneView.frame.size.width*4.0/10.0, -oneView.frame.size.height*4.0/10.0, 0)],
                                [NSValue valueWithCATransform3D:CATransform3DIdentity],nil];
        transformAnim1.removedOnCompletion = NO;
        CAAnimationGroup* group1 = [CAAnimationGroup animation];
        group1.animations = [[NSArray alloc] initWithObjects:alphaAnim1,transformAnim1, nil];
        group1.duration = 0.4;
        group1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        group1.removedOnCompletion = NO;
        group1.fillMode = kCAFillModeForwards;
        [oneView.layer addAnimation:group1 forKey:@"one"];
        
        UIView* twoView = [toView.view viewWithTag:402];
        CAKeyframeAnimation* alphaAnim2 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        alphaAnim2.values = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:1.0], nil];
        alphaAnim2.removedOnCompletion = NO;
        CAKeyframeAnimation* transformAnim2 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        transformAnim2.values = [[NSArray alloc] initWithObjects:
                                 [NSValue valueWithCATransform3D:CATransform3DTranslate(t, twoView.frame.size.width, -twoView.frame.size.height, 0)],
                                 [NSValue valueWithCATransform3D:CATransform3DTranslate(t, twoView.frame.size.width, -twoView.frame.size.height, 0)],
                                 [NSValue valueWithCATransform3D:CATransform3DTranslate(t, twoView.frame.size.width*9.0/10.0, -twoView.frame.size.height*9.0/10.0, 0)],
                                 [NSValue valueWithCATransform3D:CATransform3DTranslate(t, twoView.frame.size.width*7.0/10.0, -twoView.frame.size.height*7.0/10.0, 0)],
                                 [NSValue valueWithCATransform3D:CATransform3DTranslate(t, twoView.frame.size.width*4.0/10.0, -twoView.frame.size.height*4.0/10.0, 0)],
                                 [NSValue valueWithCATransform3D:CATransform3DIdentity],nil];
        transformAnim2.removedOnCompletion = NO;
        CAAnimationGroup* group2 = [CAAnimationGroup animation];
        group2.animations = [[NSArray alloc] initWithObjects:alphaAnim2,transformAnim2, nil];
        group2.duration = 0.5;
        group2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        group2.removedOnCompletion = NO;
        group2.fillMode = kCAFillModeForwards;
        [twoView.layer addAnimation:group2 forKey:@"two"];
        
        UIView* threeView = [toView.view viewWithTag:403];
        CAKeyframeAnimation* alphaAnim3 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        alphaAnim3.values = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:1.0], nil];
        alphaAnim3.removedOnCompletion = NO;
        CAKeyframeAnimation* transformAnim3 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        transformAnim3.values = [[NSArray alloc] initWithObjects:
                                 [NSValue valueWithCATransform3D:CATransform3DTranslate(t, -threeView.frame.size.width, threeView.frame.size.height, 0)],
                                 [NSValue valueWithCATransform3D:CATransform3DTranslate(t, -threeView.frame.size.width, threeView.frame.size.height, 0)],
                                 [NSValue valueWithCATransform3D:CATransform3DTranslate(t, -threeView.frame.size.width, threeView.frame.size.height, 0)],
                                 [NSValue valueWithCATransform3D:CATransform3DTranslate(t, -threeView.frame.size.width*9.0/10.0, threeView.frame.size.height*9.0/10.0, 0)],
                                 [NSValue valueWithCATransform3D:CATransform3DTranslate(t, -threeView.frame.size.width*7.0/10.0, threeView.frame.size.height*7.0/10.0, 0)],
                                 [NSValue valueWithCATransform3D:CATransform3DTranslate(t, -threeView.frame.size.width*4.0/10.0, threeView.frame.size.height*4.0/10.0, 0)],
                                 [NSValue valueWithCATransform3D:CATransform3DIdentity],nil];
        transformAnim3.removedOnCompletion = NO;
        CAAnimationGroup* group3 = [CAAnimationGroup animation];
        group3.animations = [[NSArray alloc] initWithObjects:alphaAnim3,transformAnim3, nil];
        group3.duration = 0.6;
        group3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        group3.removedOnCompletion = NO;
        group3.fillMode = kCAFillModeForwards;
        [threeView.layer addAnimation:group3 forKey:@"three"];
        
        UIView* fourView = [toView.view viewWithTag:404];
        CAKeyframeAnimation* alphaAnim4 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        alphaAnim4.values = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:1.0], nil];
        alphaAnim4.removedOnCompletion = NO;
        CAKeyframeAnimation* transformAnim4 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        transformAnim4.values = [[NSArray alloc] initWithObjects:
                                 [NSValue valueWithCATransform3D:CATransform3DTranslate(t, fourView.frame.size.width, fourView.frame.size.height, 0)],
                                 [NSValue valueWithCATransform3D:CATransform3DTranslate(t, fourView.frame.size.width, fourView.frame.size.height, 0)],
                                 [NSValue valueWithCATransform3D:CATransform3DTranslate(t, fourView.frame.size.width, fourView.frame.size.height, 0)],
                                 [NSValue valueWithCATransform3D:CATransform3DTranslate(t, fourView.frame.size.width, fourView.frame.size.height, 0)],
                                 [NSValue valueWithCATransform3D:CATransform3DTranslate(t, fourView.frame.size.width*9.0/10.0, fourView.frame.size.height*9.0/10.0, 0)],
                                 [NSValue valueWithCATransform3D:CATransform3DTranslate(t, fourView.frame.size.width*7.0/10.0, fourView.frame.size.height*7.0/10.0, 0)],
                                 [NSValue valueWithCATransform3D:CATransform3DTranslate(t, fourView.frame.size.width*4.0/10.0, fourView.frame.size.height*4.0/10.0, 0)],
                                 [NSValue valueWithCATransform3D:CATransform3DIdentity],nil];
        transformAnim4.removedOnCompletion = NO;
        CAAnimationGroup* group4 = [CAAnimationGroup animation];
        group4.animations = [[NSArray alloc] initWithObjects:alphaAnim4,transformAnim4, nil];
        group4.duration = 0.7;
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
