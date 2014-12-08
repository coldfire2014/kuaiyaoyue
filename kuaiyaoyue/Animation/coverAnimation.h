//
//  coverAnimation.h
//  kuaiyaoyue
//
//  Created by wuyangbing on 14/12/8.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface coverAnimation : NSObject<UIViewControllerAnimatedTransitioning>
{
    BOOL isPresent;
}
- (instancetype)initWithPresent:(BOOL)p;
@end
