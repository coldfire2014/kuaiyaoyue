//
//  UIPhoneWindow.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/1/7.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import "UIPhoneWindow.h"
#import "myImageView.h"
#import "PCHeader.h"
@implementation UIPhoneWindow

+ (UIPhoneWindow *)sharedwaitingView{
    static UIPhoneWindow *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[UIPhoneWindow alloc] initWithFrame:CGRectZero];
    });
    
    return _sharedInstance;

}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = UIWindowLevelNormal + 2.0;
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1;
        self.hidden = NO;
        CGRect mainScreenFrame = [UIScreen mainScreen].bounds;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            mainScreenFrame = IPAD_FRAME;
        }
        self.frame = mainScreenFrame;
        UIImageView* imgbk = [[UIImageView alloc] initWithFrame:mainScreenFrame];
        
        imgbk.tag = 302;
        [self addSubview:imgbk];
    }
    return self;
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

- (void)hide{
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
    }];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_PHONE_BACK" object:nil];
}
- (void)callPhone:(NSString*)num andBK:(UIImage*)bk{
    [self updateOrientation];
    UIImageView* imgbk = (UIImageView*)[self viewWithTag:302];
    imgbk.image = bk;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hide) name:@"MSG_PHONE_BACK" object:nil];
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",num]];
        if ( !phoneCallWebView ) {
            phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];// 这个webView只是一个后台的View 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的
        }
        [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];

    }];
}
@end
