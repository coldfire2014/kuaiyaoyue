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

#import <ImageIO/ImageIO.h>
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
-(void)updateOrientation{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    CGFloat pi = (CGFloat)M_PI;
    if (orientation == UIDeviceOrientationPortrait) {
        self.transform = CGAffineTransformIdentity;
    }else if (orientation == UIDeviceOrientationLandscapeLeft) {
        self.transform = CGAffineTransformMakeRotation(pi * (90.f) / 180.0f);
        self.frame = CGRectMake(0,0, self.frame.size.width, self.frame.size.height);
    } else if (orientation == UIDeviceOrientationLandscapeRight) {
        self.transform = CGAffineTransformMakeRotation(pi * (-90.f) / 180.0f);
        self.frame = CGRectMake(0,0, self.frame.size.width, self.frame.size.height);
    } else if (orientation == UIDeviceOrientationPortraitUpsideDown) {
    }
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = UIWindowLevelAlert + 2.0;
        self.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.2];
        self.alpha = 1;
        self.hidden = NO;
        CGRect mainScreenFrame = [[UIScreen mainScreen] applicationFrame];
        
        CGFloat subTap = -20;
        if (ISIOS7LATER) {
            mainScreenFrame = [[UIScreen mainScreen] bounds];//568,667
            subTap = 0;
        }
        self.frame = mainScreenFrame;
        [self updateOrientation];
        myImageView* backall = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 54.0/2.0, 54.0/2.0) andImageName:@"ic_54_x@2x" withScale:2.0];
        backall.center = CGPointMake(mainScreenFrame.size.width-31.0, 20.0+subTap + 24.0);
        backall.tag = 304;
        [self addSubview:backall];
        UITapGestureRecognizer* panall = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAll)];
        [backall addGestureRecognizer:panall];
        
        UIView* bk = [[UIView alloc] initWithFrame:CGRectMake(0, 0.0, 148,88.0)];
        bk.tag = 303;
        bk.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
        bk.backgroundColor = [[UIColor alloc] initWithWhite:0.4 alpha:0.8];
        bk.layer.cornerRadius = 8;
//        bk.alpha = 0;
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
        
        UILabel *gth = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.0, mainScreenFrame.size.width,mainScreenFrame.size.width)];
        gth.tag = 604;
        [gth setFont:[UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:44]];
        [gth setTextAlignment:NSTextAlignmentCenter];
        [gth setLineBreakMode:NSLineBreakByClipping];
        [gth setTextColor:[[UIColor alloc] initWithWhite:1.0 alpha:1.0]];
        [gth setBackgroundColor:[UIColor clearColor]];
        [gth setText:@"!"];
        gth.alpha = 0;
        gth.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0-15);
        [self addSubview:gth];
////        {
//            NSString *gifFilePath = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"];
//            NSData *gifData = [NSData dataWithContentsOfFile: gifFilePath];
//            NSMutableArray *frames = nil;
//            CGImageSourceRef src = CGImageSourceCreateWithData((CFDataRef)CFBridgingRetain(gifData), NULL);
//            double total = 0;
//            NSTimeInterval gifAnimationDuration;
//            if (src) {
//                size_t l = CGImageSourceGetCount(src);
//                if (l > 1){
//                    frames = [NSMutableArray arrayWithCapacity: l];
//                    for (size_t i = 0; i < l; i++) {
//                        CGImageRef img = CGImageSourceCreateImageAtIndex(src, i, NULL);
//                        //                CGImageRef img2 = [UIImage imageWithCGImage:img scale:2 orientation:UIImageOrientationUp].CGImage;
//                        NSDictionary *dict = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(src, 0, NULL));
//                        if (dict){
//                            NSDictionary *tmpdict = [dict objectForKey: @"{GIF}"];
//                            total += [[tmpdict objectForKey: @"DelayTime"] doubleValue] * 50;
//                        }
//                        if (img) {
//                            [frames addObject: [UIImage imageWithCGImage: img]];
//                            //                    CGImageRelease(img2);
//                            CGImageRelease(img);
//                        }
//                    }
//                }
//            }
////        }
//        loading = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 132.0 , 18.0)];
//        loading.animationImages = frames;
//        
//        loading.animationDuration = 35.0*0.03;
//        loading.animationRepeatCount = 0;
        
        
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
    UIView* gth = [self viewWithTag:604];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        gth.alpha = 0;
    } completion:^(BOOL finished) {
        loading.alpha = 0;
        [loading stopAnimating];
    }];
}
- (void)changeWord:(NSString*)msg{
    UILabel *add = (UILabel*)[self viewWithTag:305];
    add.text = msg;
}
- (void)WarningByMsg:(NSString*)msg haveCancel:(BOOL)cancel inTime:(double)time{
    [self WarningByMsg:msg haveCancel:cancel];
    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(stopWait) userInfo:nil repeats:NO];
}
- (void)WarningByMsg:(NSString*)msg haveCancel:(BOOL)cancel{
    [self updateOrientation];
    UIView* btn = [self viewWithTag:304];
    btn.hidden = !cancel;
    UILabel *add = (UILabel*)[self viewWithTag:305];
    add.text = msg;
    CGSize s = [add sizeThatFits:add.bounds.size];
    if (msg.length > 0) {
        loading.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0-15);
    } else {
        loading.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    }
    UIView* gth = [self viewWithTag:604];
    gth.alpha = 1;
//    [loading startAnimating];
    UIView* bk = [self viewWithTag:303];
    if (s.width + 44.0 > 148.0) {
        bk.bounds = CGRectMake(0, 0, s.width + 44.0, 88.0);
    } else {
        bk.bounds = CGRectMake(0, 0, 148.0, 88.0);
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        
    } completion:^(BOOL finished) {
        
    }];
}
- (void)waitByMsg:(NSString*)msg haveCancel:(BOOL)cancel{
    [self updateOrientation];
    UIView* btn = [self viewWithTag:304];
    btn.hidden = !cancel;
    UIView* bk = [self viewWithTag:303];
    bk.bounds = CGRectMake(0, 0, 148.0, 88.0);
    UILabel *add = (UILabel*)[self viewWithTag:305];
    add.text = msg;
    CGSize s = [add sizeThatFits:add.bounds.size];
    if (s.width + 44.0 > 148.0) {
        bk.bounds = CGRectMake(0, 0, s.width + 44.0, 88.0);
    } else {
        bk.bounds = CGRectMake(0, 0, 148.0, 88.0);
    }
    if (msg.length > 0) {
        loading.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0-15);
    } else {
        loading.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    }
    loading.alpha = 1;
    [loading startAnimating];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}
@end
