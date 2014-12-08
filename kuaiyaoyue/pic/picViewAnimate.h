//
//  picViewAnimate.h
//  SpeciallyEffect
//
//  Created by wuyangbing on 14/12/7.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface picViewAnimate : NSObject<UIViewControllerAnimatedTransitioning>
{
    BOOL isPresent;
}
- (instancetype)initWithPresent:(BOOL)p;
@end
