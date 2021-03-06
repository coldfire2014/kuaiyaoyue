//
//  StatusBar.m
//  SpeciallyEffect
//
//  Created by wuyangbing on 14/12/7.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

#import "StatusBar.h"
#import "PCHeader.h"
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
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            statusBarFrame = CGRectMake(0, 0, MAX(statusBarFrame.size.height, statusBarFrame.size.width),MIN(statusBarFrame.size.height, statusBarFrame.size.width));
        }
        statusBarFrame.size.height = (statusBarFrame.size.height == 40.0) ? 20.0:statusBarFrame.size.height;
        self.windowLevel = UIWindowLevelStatusBar + 1.0;
        self.frame = statusBarFrame;
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1;
        self.hidden = NO;
        bk = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
        bk.backgroundColor =[[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
//        bk.layer.cornerRadius = 10.0;
        [self addSubview:bk];
        msg1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
        msg1.font = [UIFont systemFontOfSize:13.0];
        msg1.textAlignment = NSTextAlignmentCenter;
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
-(void)updateOrientation{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    CGRect f = IPAD_FRAME;
    CGFloat h = f.size.height-20.0;
    CGFloat pi = (CGFloat)M_PI;
    if (orientation == UIDeviceOrientationPortrait) {
        self.transform = CGAffineTransformIdentity;
    }else if (orientation == UIDeviceOrientationLandscapeLeft) {
        self.transform = CGAffineTransformMakeRotation(pi * (90.f) / 180.0f);
        self.frame = CGRectMake(h,0, self.frame.size.width, self.frame.size.height);
    } else if (orientation == UIDeviceOrientationLandscapeRight) {
        self.transform = CGAffineTransformMakeRotation(pi * (-90.f) / 180.0f);
        self.frame = CGRectMake(0,0, self.frame.size.width, self.frame.size.height);
    } else if (orientation == UIDeviceOrientationPortraitUpsideDown) {
    }
}

- (void)talkMsg:(NSString*)msg inTime:(double)time{
    [self updateOrientation];
    self.alpha = 1.0;
    msg1.text = msg;
    CATransform3D t = CATransform3DIdentity;
    t.m34 = -1.0/900.0;
    bk.layer.transform = CATransform3DTranslate(t, 0, -10, -10);
    bk.layer.transform = CATransform3DRotate(bk.layer.transform, M_PI_2, 1, 0, 0);
    [UIView animateWithDuration:0.5 animations:^{
        bk.layer.transform = t;
    }];
//    CAKeyframeAnimation* moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    moveAnim.values = [[NSArray alloc] initWithObjects:
//                       [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width*1.5, 10.0)],
//                       [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width*1.5-ww-12.0, 10.0)],
//                       [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width*1.5-ww+6.0, 10.0)],
//                       [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width*1.5-ww, 10.0)],nil];
//    moveAnim.removedOnCompletion = YES;
//    moveAnim.duration = 0.5;
//    moveAnim.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
//    moveAnim.fillMode = kCAFillModeForwards;
//    [bk.layer addAnimation:moveAnim forKey:@"s"];
    [self goout:0.5+time];
}

@end
