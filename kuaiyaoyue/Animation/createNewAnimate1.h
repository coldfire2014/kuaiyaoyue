//
//  createNewAnimate.h
//  SpeciallyEffect
//
//  Created by wuyangbing on 14/12/2.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface createNewAnimate1 : NSObject<UIViewControllerAnimatedTransitioning>
{
    BOOL isPresent;
}
@property (nonatomic,weak) id <UIViewControllerContextTransitioning> transitionContext;
- (instancetype)initWithPresent:(BOOL)p;
@end
