//
//  modelListAnimate.h
//  SpeciallyEffect
//
//  Created by wuyangbing on 14/12/4.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface modelListAnimate : NSObject<UIViewControllerAnimatedTransitioning>
{
    BOOL isPresent;
    id <UIViewControllerContextTransitioning> _transitionContext;
}
- (instancetype)initWithPresent:(BOOL)p;
@end
