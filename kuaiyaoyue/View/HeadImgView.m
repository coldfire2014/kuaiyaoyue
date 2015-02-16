//
//  HeadImgView.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/2/13.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import "HeadImgView.h"

@implementation HeadImgView

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 120.0/2.0, 120.0/2.0)];
    if (self) {
        self.backgroundColor = [[UIColor alloc] initWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0];
        UIView* shu = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, 80.0/2.0)];
        shu.backgroundColor = [[UIColor alloc] initWithRed:222.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1.0];
        shu.center = CGPointMake(120.0/4.0, 120.0/4.0);
        [self addSubview:shu];
        
        UIView* heng = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80.0/2.0, 3)];
        heng.backgroundColor = [[UIColor alloc] initWithRed:222.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1.0];
        heng.center = CGPointMake(120.0/4.0, 120.0/4.0);
        [self addSubview:heng];
        self.imgContext = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120.0/2.0, 120.0/2.0)];
        self.imgContext.backgroundColor = [UIColor clearColor];
        self.imgContext.image = self.img;
        [self addSubview:self.imgContext];
    }
    return self;
}

@end
