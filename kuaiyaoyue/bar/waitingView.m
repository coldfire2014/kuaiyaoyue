//
//  waitingView.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 14/12/19.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "waitingView.h"

@implementation waitingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (waitingView *)sharedwaitingView
{
    static waitingView *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[waitingView alloc] initWithFrame:CGRectZero];
    });
    
    return _sharedInstance;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = UIWindowLevelAlert + 2.0;
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1;
        self.hidden = NO;
    }
    return self;
}
@end
