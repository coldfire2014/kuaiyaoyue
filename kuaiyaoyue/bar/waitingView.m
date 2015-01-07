//
//  waitingView.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 14/12/19.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "waitingView.h"
#import "myImageView.h"
#import "PCHeader.h"
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
        self.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.5];
        self.alpha = 1;
        self.hidden = NO;
        CGRect mainScreenFrame = [[UIScreen mainScreen] applicationFrame];
        
        CGFloat subTap = -20;
        if (ISIOS7LATER) {
            mainScreenFrame = [[UIScreen mainScreen] bounds];//568,667
            subTap = 0;
        }
        self.frame = mainScreenFrame;
        myImageView* backall = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 54.0/2.0, 54.0/2.0) andImageName:@"ic_54_x@2x" withScale:2.0];
        backall.center = CGPointMake(mainScreenFrame.size.width-31.0, 20.0+subTap + 29.0);
        backall.tag = 304;
        [self addSubview:backall];
        UITapGestureRecognizer* panall = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAll)];
        [backall addGestureRecognizer:panall];
        
        UIView* bk = [[UIView alloc] initWithFrame:CGRectMake(0, 0.0, mainScreenFrame.size.width-188,88.0)];
        bk.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
        bk.backgroundColor = [[UIColor alloc] initWithWhite:0.7 alpha:0.8];
        bk.layer.cornerRadius = 8;
        [self addSubview:bk];
        
        UILabel *add = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.0, mainScreenFrame.size.width,20.0)];
        add.tag = 305;
        [add setFont:[UIFont systemFontOfSize:13]];
        [add setTextAlignment:NSTextAlignmentCenter];
        [add setLineBreakMode:NSLineBreakByClipping];
        [add setTextColor:[[UIColor alloc] initWithWhite:1.0 alpha:1.0]];
        [add setBackgroundColor:[UIColor clearColor]];
        [add setText:@""];
        add.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0+25);
        [self addSubview:add];
        
        loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self addSubview: loading];
        
        loading.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0-15);
        [self bringSubviewToFront:loading];
    }
    return self;
}
- (void)backAll{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_STOP_WAITING" object:nil];
    [self stopWait];
}
- (void)startWait{
    [self waitByMsg:@"" haveCancel:NO];
}
- (void)stopWait{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [loading stopAnimating];
    }];
}
- (void)changeWord:(NSString*)msg{
    UILabel *add = (UILabel*)[self viewWithTag:305];
    add.text = msg;
}
- (void)waitByMsg:(NSString*)msg haveCancel:(BOOL)cancel{
    UIView* btn = [self viewWithTag:304];
    btn.hidden = !cancel;
    UILabel *add = (UILabel*)[self viewWithTag:305];
    add.text = msg;
    if (msg.length > 0) {
        loading.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0-15);
    } else {
        loading.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        [loading startAnimating];
    }];
}
@end
