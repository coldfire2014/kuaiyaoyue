//
//  BigStateView.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 14/12/9.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "BigStateView.h"
#import "TimeTool.h"
@implementation BigStateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        
        goingColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        getColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        goneColor = [[UIColor alloc] initWithWhite:0.5 alpha:1.0];
        
        UILabel *add = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-3,27.0)];
        add.tag = 1301;
        [add setFont:[UIFont systemFontOfSize:27]];
        [add setTextAlignment:NSTextAlignmentRight];
        [add setLineBreakMode:NSLineBreakByClipping];
        [add setTextColor:[[UIColor alloc] initWithRed:76.0/255.0 green:196.0/255.0 blue:134.0/255.0 alpha:1.0]];
        [add setBackgroundColor:[UIColor clearColor]];
        [add setText:@"+9"];
        [self addSubview:add];
        
        UIView* bk = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 98, 98)];
        bk.backgroundColor = [UIColor whiteColor];
        bk.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
        bk.layer.cornerRadius = bk.frame.size.height/2.0;
        [self addSubview:bk];
        
        UIView* huan = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 88, 88)];
        huan.backgroundColor = [UIColor clearColor];
        huan.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
        huan.layer.borderWidth = 1.5;
        huan.layer.cornerRadius = huan.frame.size.height/2.0;
        huan.layer.borderColor = [[UIColor alloc] initWithWhite:0.7 alpha:0.4].CGColor;
        [self addSubview:huan];
        
        UILabel *all = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 84, 84)];
        all.tag = 1302;
        all.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
        [all setFont:[UIFont systemFontOfSize:40]];
        [all setTextAlignment:NSTextAlignmentCenter];
        [all setLineBreakMode:NSLineBreakByClipping];
        [all setTextColor:getColor];
        [all setBackgroundColor:[UIColor clearColor]];
        [all setText:@"319"];
        [self addSubview:all];
        
        UILabel *peo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 14, 28)];
        peo.tag = 1312;
        peo.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
        [peo setFont:[UIFont boldSystemFontOfSize:9]];
        [peo setTextAlignment:NSTextAlignmentCenter];
        [peo setLineBreakMode:NSLineBreakByClipping];
        [peo setTextColor:[UIColor blackColor]];
        [peo setBackgroundColor:[UIColor clearColor]];
        [peo setText:@"人"];
        peo.alpha = 0;
        [self addSubview:peo];
        
        UIView* gone = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
        gone.tag = 1303;
        gone.alpha = 0;
        gone.backgroundColor = [UIColor clearColor];
        gone.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
        gone.layer.borderWidth = 3.0;
        gone.layer.cornerRadius = gone.frame.size.height/2.0;
        gone.layer.borderColor = [[UIColor alloc] initWithWhite:0.8 alpha:1.0].CGColor;
        [self addSubview:gone];
        
        UIView* get = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
        get.tag = 1304;
        get.alpha = 0;
        get.backgroundColor = [UIColor clearColor];
        get.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
        get.layer.borderWidth = 3.0;
        get.layer.cornerRadius = get.frame.size.height/2.0;
        get.layer.borderColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0].CGColor;
        [self addSubview:get];
        UIBezierPath* aPath = [UIBezierPath bezierPath];
        racetrack = [CAShapeLayer layer];
        racetrack.opacity = NO;
        racetrack.path = aPath.CGPath;
        racetrack.strokeColor = goingColor.CGColor;
        racetrack.fillColor = [UIColor clearColor].CGColor;
        racetrack.lineWidth = 3.0;
        [self.layer addSublayer:racetrack];
        nowState = StateGoing;
        UIView* endTip = [[UIView alloc] initWithFrame:CGRectMake(0, -11, self.bounds.size.width/2.0, 18)];
        endTip.backgroundColor = [UIColor clearColor];
        endTip.tag = 1314;
        [self addSubview:endTip];
        endTip.alpha = 0;
        UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(0, 2.0, self.bounds.size.width/2.0, 14)];
        time.tag = 1317;
//        time.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
        [time setFont:[UIFont boldSystemFontOfSize:9]];
        [time setTextAlignment:NSTextAlignmentLeft];
        [time setLineBreakMode:NSLineBreakByClipping];
        [time setTextColor:[UIColor blackColor]];
        [time setBackgroundColor:[UIColor clearColor]];
        [time setText:@""];
        [endTip addSubview:time];
        [self setendTip];
        
        [self showTip];
        UITapGestureRecognizer* didTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTip)];
        [self addGestureRecognizer:didTap];
    }
    return self;
}
-(void)setendTip{
    UIView* end = [self viewWithTag:1314];
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    [aPath moveToPoint:CGPointMake(0, end.frame.size.height-4)];
    [aPath addLineToPoint:CGPointMake(end.frame.size.width-8, end.frame.size.height-4)];
    [aPath addLineToPoint:CGPointMake(end.frame.size.width, end.frame.size.height-1.5)];
    CAShapeLayer* vl = [CAShapeLayer layer];
    vl.frame = end.bounds;
//    vl.opacity = YES;
    vl.path = aPath.CGPath;
    vl.strokeColor = getColor.CGColor;
    vl.fillColor = [UIColor clearColor].CGColor;
    vl.lineWidth = 1.0;
    [end.layer addSublayer:vl];
}
-(void)showTip{
    UIView* end = [self viewWithTag:1314];
    UILabel* time = (UILabel*)[self viewWithTag:1317];
    if (time.text.length>0) {
        end.alpha = 1;
    }
    UILabel* ren = (UILabel*)[self viewWithTag:1312];
    ren.alpha = 1;
    [self performSelector:@selector(hideTip) withObject:nil afterDelay:1.0];
}
-(void)hideTip{
    UIView* end = [self viewWithTag:1314];
    UILabel* ren = (UILabel*)[self viewWithTag:1312];
    [UIView animateWithDuration:0.5 animations:^{
        end.alpha = 0;
        ren.alpha = 0;
    }];
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
        UIBezierPath* aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0)
                                                             radius:44
                                                         startAngle:-M_PI_2
                                                           endAngle:2*M_PI*(nowi/alli)-M_PI_2
                                                          clockwise:YES];
        aPath.lineCapStyle = kCGLineCapSquare; //线条拐角
        aPath.lineJoinStyle = kCGLineCapSquare; //终点处理
        racetrack.path = aPath.CGPath;
        racetrack.opacity = YES;
    }
    UILabel* time = (UILabel*)[self viewWithTag:1317];
    time.text = [TimeTool endTime:endT];
    [self showTip];
}
-(void)setState:(ItemState)state withAll:(NSString*) all andAdd:(NSString*) add{
    nowState = state;
    UILabel* addv = (UILabel*)[self viewWithTag:1301];
    addv.alpha = 0;
    addv.text = add;
    UILabel* allv = (UILabel*)[self viewWithTag:1302];
    allv.frame = CGRectMake(0, 0, 84, 84);
    allv.text = [[NSString alloc] initWithFormat:@"%@",all];//all;
    allv.adjustsFontSizeToFitWidth = YES;
    [allv sizeToFit];
    allv.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    UILabel* ren = (UILabel*)[self viewWithTag:1312];
    ren.frame = CGRectMake(allv.frame.origin.x + allv.frame.size.width, allv.frame.origin.y + allv.frame.size.height - ren.frame.size.height, ren.frame.size.width, ren.frame.size.height);
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
