//
//  CreateBtn.m
//  SpeciallyEffect
//
//  Created by wuyangbing on 14/12/2.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

#import "CreateBtn.h"

@implementation CreateBtn
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [[UIColor alloc] initWithRed:251.0/255.0 green:88.0/255.0 blue:141.0/255.0 alpha:1.0];
        self.layer.cornerRadius = self.frame.size.height/2.0;
        UIView* huan = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
        huan.backgroundColor = [UIColor clearColor];
        huan.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
        huan.layer.borderWidth = 1.0;
        huan.layer.cornerRadius = huan.frame.size.height/2.0;
        huan.layer.borderColor = [UIColor whiteColor].CGColor;
        [self addSubview:huan];
        
        UIView* hen = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 23, 1)];
        hen.backgroundColor = [UIColor whiteColor];
        hen.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
        [self addSubview:hen];
        
        UIView* shu = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 23)];
        shu.backgroundColor = [UIColor whiteColor];
        shu.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
        [self addSubview:shu];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
