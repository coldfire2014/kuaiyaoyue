//
//  StatusBar.m
//  SpeciallyEffect
//
//  Created by wuyangbing on 14/12/7.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

#import "StatusBar.h"

@implementation StatusBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (StatusBar *)sharedStatusBar
{
    static StatusBar *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[StatusBar alloc] initWithFrame:CGRectZero];
    });
    
    return _sharedInstance;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
        statusBarFrame.size.height = (statusBarFrame.size.height == 40.0) ? 20.0:statusBarFrame.size.height;
        self.windowLevel = UIWindowLevelStatusBar + 1.0;
        self.frame = statusBarFrame;
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1;
        self.hidden = NO;
        bk = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, 20)];
        bk.backgroundColor =[[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        bk.layer.cornerRadius = 10.0;
        [self addSubview:bk];
        msg1 = [[UILabel alloc] initWithFrame:CGRectMake(7, 0, 140, 20)];
        msg1.font = [UIFont systemFontOfSize:13.0];
        msg1.textAlignment = NSTextAlignmentLeft;
        msg1.textColor = [UIColor whiteColor];
        msg1.backgroundColor = [UIColor clearColor];
        msg1.text = @"";
        [bk addSubview:msg1];
        UITapGestureRecognizer* panGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didtap)];
        [bk addGestureRecognizer:panGesture];
    }
    return self;
}
-(void)didtap{
    [self goout:0];
}
-(void)goout:(double)time{
    if (self.alpha == 1.0) {
        [UIView animateWithDuration:0.3 delay:time options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            
        }];
    }
}
- (void)talkMsg:(NSString*)msg inTime:(double)time{
    self.alpha = 1.0;
    msg1.frame = CGRectMake( msg1.frame.origin.x,  msg1.frame.origin.y, self.frame.size.width, msg1.frame.size.height);
    msg1.text = msg;
    [msg1 sizeToFit];
    msg1.frame = CGRectMake( msg1.frame.origin.x,  msg1.frame.origin.y, msg1.frame.size.width, 20.0);
    CGFloat ww = msg1.frame.size.width + 16.0;
    bk.frame = CGRectMake(self.frame.size.width-ww, 0, self.frame.size.width, 20);
    
    CAKeyframeAnimation* moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.values = [[NSArray alloc] initWithObjects:
                       [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width*1.5, 10.0)],
                       [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width*1.5-ww-12.0, 10.0)],
                       [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width*1.5-ww+6.0, 10.0)],
                       [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width*1.5-ww, 10.0)],nil];
    moveAnim.removedOnCompletion = YES;
    moveAnim.duration = 0.5;
    moveAnim.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    moveAnim.fillMode = kCAFillModeForwards;
    [bk.layer addAnimation:moveAnim forKey:@"s"];
    [self goout:0.5+time];
}

@end
