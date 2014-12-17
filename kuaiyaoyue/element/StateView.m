//
//  StateView.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 14/12/9.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "StateView.h"

@implementation StateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        
        goingColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        getColor = [[UIColor alloc] initWithRed:103.0/255.0 green:164.0/255.0 blue:219.0/255.0 alpha:1.0];
        goneColor = [[UIColor alloc] initWithWhite:0.5 alpha:1.0];
        
        UILabel *add = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-7,17.0)];
        add.tag = 1301;
        [add setFont:[UIFont systemFontOfSize:13]];
        [add setTextAlignment:NSTextAlignmentRight];
        [add setLineBreakMode:NSLineBreakByClipping];
        [add setTextColor:[[UIColor alloc] initWithRed:76.0/255.0 green:196.0/255.0 blue:134.0/255.0 alpha:1.0]];
        [add setBackgroundColor:[UIColor clearColor]];
        [add setText:@"+9"];
        [self addSubview:add];
        
        UIView* huan = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
        huan.backgroundColor = [UIColor clearColor];
        huan.center = CGPointMake(self.bounds.size.width/2.0-6.0, self.bounds.size.height/2.0+5.0);
        huan.layer.borderWidth = 1.0;
        huan.layer.cornerRadius = huan.frame.size.height/2.0;
        huan.layer.borderColor = [[UIColor alloc] initWithWhite:0.7 alpha:0.4].CGColor;
        [self addSubview:huan];
        
        UILabel *all = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
        all.tag = 1302;
        all.center = CGPointMake(self.bounds.size.width/2.0-6.0, self.bounds.size.height/2.0+5.0);
        [all setFont:[UIFont systemFontOfSize:14]];
        [all setTextAlignment:NSTextAlignmentCenter];
        [all setLineBreakMode:NSLineBreakByClipping];
        [all setTextColor:getColor];
        [all setBackgroundColor:[UIColor clearColor]];
        [all setText:@"319"];
        [self addSubview:all];
        
        UIView* gone = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        gone.tag = 1303;
        gone.alpha = 0;
        gone.backgroundColor = [UIColor clearColor];
        gone.center = CGPointMake(self.bounds.size.width/2.0-6.0, self.bounds.size.height/2.0+5.0);
        gone.layer.borderWidth = 2.0;
        gone.layer.cornerRadius = gone.frame.size.height/2.0;
        gone.layer.borderColor = [[UIColor alloc] initWithWhite:0.8 alpha:1.0].CGColor;
        [self addSubview:gone];
        
        UIView* get = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        get.tag = 1304;
        get.alpha = 0;
        get.backgroundColor = [UIColor clearColor];
        get.center = CGPointMake(self.bounds.size.width/2.0-6.0, self.bounds.size.height/2.0+5.0);
        get.layer.borderWidth = 2.0;
        get.layer.cornerRadius = get.frame.size.height/2.0;
        get.layer.borderColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0].CGColor;
        [self addSubview:get];
        UIBezierPath* aPath = [UIBezierPath bezierPath];
        racetrack = [CAShapeLayer layer];
        racetrack.opacity = NO;
        racetrack.path = aPath.CGPath;
        racetrack.strokeColor = goingColor.CGColor;
        racetrack.fillColor = [UIColor clearColor].CGColor;
        racetrack.lineWidth = 2.0;
        [self.layer addSublayer:racetrack];
        nowState = StateGoing;
    }
    return self;
}
-(void)nowGet{
    UILabel* addv = (UILabel*)[self viewWithTag:1301];
    addv.alpha = 0;
    UIView* get = [self viewWithTag: 1304];
    get.alpha = 1;
    UIView* gone = [self viewWithTag: 1303];
    gone.alpha = 0;
    UILabel* allv = (UILabel*)[self viewWithTag:1302];
    [allv setTextColor:getColor];
    racetrack.opacity = NO;
}
-(void)nowGone{
    UILabel* addv = (UILabel*)[self viewWithTag:1301];
    addv.alpha = 0;
    UIView* get = [self viewWithTag: 1304];
    get.alpha = 0;
    UIView* gone = [self viewWithTag: 1303];
    gone.alpha = 1;
    UILabel* allv = (UILabel*)[self viewWithTag:1302];
    [allv setTextColor:goneColor];
    racetrack.opacity = NO;
}
-(void)setStartTime:(NSDate*)startT EndTime:(NSDate*)endT andGoneTime:(NSDate*)goneT{
    NSDate* now = [NSDate date];
    NSTimeInterval alli = [endT timeIntervalSinceDate:startT];
    NSTimeInterval nowi = [now timeIntervalSinceDate:startT];
    NSTimeInterval gonei = [goneT timeIntervalSinceDate:startT];
    if (gonei <= nowi) {
        return [self nowGone];
    }
    if (alli <= nowi) {
        return [self nowGet];
    }
    if (StateGoing == nowState) {
        UIBezierPath* aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2.0-6.0, self.bounds.size.height/2.0+5.0)
                                                             radius:17
                                                         startAngle:-M_PI_2
                                                           endAngle:2*M_PI*(nowi/alli)-M_PI_2
                                                          clockwise:YES];
        aPath.lineCapStyle = kCGLineCapRound; //线条拐角
        aPath.lineJoinStyle = kCGLineCapRound; //终点处理
        racetrack.path = aPath.CGPath;
        racetrack.opacity = YES;
    }
}
-(void)setState:(ItemState)state withAll:(NSString*) all andAdd:(NSString*) add{
    nowState = state;
    UILabel* addv = (UILabel*)[self viewWithTag:1301];
    addv.alpha = 0;
    addv.text = add;
    UILabel* allv = (UILabel*)[self viewWithTag:1302];
    allv.text = all;
    UIView* gone = [self viewWithTag: 1303];
    gone.alpha = 0;
    UIView* get = [self viewWithTag: 1304];
    get.alpha = 0;
    switch (state) {
        case StateGoing:
            racetrack.opacity = YES;
            addv.alpha = 1.0;
            [allv setTextColor:goingColor];
            break;
        case StateGet:
            racetrack.opacity = NO;
            get.alpha = 1.0;
            [allv setTextColor:getColor];
            break;
        case StateDone:
            racetrack.opacity = NO;
            gone.alpha = 1.0;
            [allv setTextColor:goneColor];
            break;
        default:
            break;
    }
}

@end
