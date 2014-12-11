//
//  MenuBackBtn.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 14/12/9.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "MenuBackBtn.h"

@implementation MenuBackBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame andType:(NSString*)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
//        UIView* t = [[UIView alloc] initWithFrame:CGRectMake(22.0, 18.0, 18.0, 22.0)];
//        t.backgroundColor = [UIColor blueColor];
//        [self addSubview:t];
        
        UIView* one = [[UIView alloc] initWithFrame:CGRectMake(22.0, 18.0, 18.0/2.0-1.0, 22.0/2.0-1.0)];
        one.backgroundColor = [UIColor clearColor];
        one.layer.borderColor = [[UIColor alloc] initWithRed:251.0/255.0 green:88.0/255.0 blue:141.0/255.0 alpha:1.0].CGColor;
        one.layer.borderWidth = 1.0;
        [self addSubview:one];
        
        UIView* two = [[UIView alloc] initWithFrame:CGRectMake(22.0 + 18.0/2.0+1.0, 18.0, 18.0/2.0-1.0, 22.0/2.0-1.0)];
        two.backgroundColor = [UIColor clearColor];
        two.layer.borderColor = [[UIColor alloc] initWithRed:251.0/255.0 green:88.0/255.0 blue:141.0/255.0 alpha:1.0].CGColor;
        two.layer.borderWidth = 1.0;
        [self addSubview:two];
        
        UIView* three = [[UIView alloc] initWithFrame:CGRectMake(22.0, 18.0 + 22.0/2.0+1.0, 18.0/2.0-1.0, 22.0/2.0-1.0)];
        three.backgroundColor = [UIColor clearColor];
        three.layer.borderColor = [[UIColor alloc] initWithRed:251.0/255.0 green:88.0/255.0 blue:141.0/255.0 alpha:1.0].CGColor;
        three.layer.borderWidth = 1.0;
        [self addSubview:three];
        
        UIView* four = [[UIView alloc] initWithFrame:CGRectMake(22.0 + 18.0/2.0+1.0, 18.0 + 22.0/2.0+1.0, 18.0/2.0-1.0, 22.0/2.0-1.0)];
        four.backgroundColor = [UIColor clearColor];
        four.layer.borderColor = [[UIColor alloc] initWithRed:251.0/255.0 green:88.0/255.0 blue:141.0/255.0 alpha:1.0].CGColor;
        four.layer.borderWidth = 1.0;
        [self addSubview:four];
        
        if ([type compare:@"sanwu"] == NSOrderedSame) {
            one.backgroundColor = [[UIColor alloc] initWithRed:251.0/255.0 green:88.0/255.0 blue:141.0/255.0 alpha:1.0];
        } else if ([type compare:@"cihe"] == NSOrderedSame) {
            two.backgroundColor = [[UIColor alloc] initWithRed:251.0/255.0 green:88.0/255.0 blue:141.0/255.0 alpha:1.0];
        } else if ([type compare:@"hunli"] == NSOrderedSame) {
            three.backgroundColor = [[UIColor alloc] initWithRed:251.0/255.0 green:88.0/255.0 blue:141.0/255.0 alpha:1.0];
        } else if ([type compare:@"zdy"] == NSOrderedSame) {
            four.backgroundColor = [[UIColor alloc] initWithRed:251.0/255.0 green:88.0/255.0 blue:141.0/255.0 alpha:1.0];
        }
    }
    return self;
}
@end
