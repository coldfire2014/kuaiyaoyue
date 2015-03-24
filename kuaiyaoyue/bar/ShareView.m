//
//  ShareView.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 14/12/19.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "ShareView.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "waitingView.h"
#import "myImageView.h"
#import "TalkingData.h"
#import "PCHeader.h"
@import Accounts;
@implementation ShareView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (ShareView *)sharedShareView
{
    static ShareView *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[ShareView alloc] initWithFrame:CGRectZero];
    });
    
    return _sharedInstance;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = UIWindowLevelStatusBar - 1.0;
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1;
        self.hidden = NO;
        CGRect f = [UIScreen mainScreen].bounds;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            f = IPAD_FRAME;
        }
        self.frame = f;
        [self updateOrientation];
        UIView* bg = [[UIView alloc] initWithFrame:f];
        bg.tag = 799;
        bg.alpha = 0.0;
        bg.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.95];
        [self addSubview:bg];
        UIView* bg2 = [[UIView alloc] initWithFrame:f];
        bg2.tag = 798;
        bg2.backgroundColor = [UIColor clearColor];
        [bg addSubview:bg2];
//        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
//        [bg addGestureRecognizer:tap];
//        UIView* wbj = [[UIView alloc] initWithFrame:CGRectMake(0, f.size.height, f.size.width, f.size.height/2.0)];
        myImageView* pyq = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 128.0/2.0, 128.0/2.0) andImageName:@"ic_s_wxpyq@2x" withScale:2.0 andBundleName:@"shareView"];
        pyq.tag = 800;
        [self addSubview:pyq];
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPyq)];
        [pyq addGestureRecognizer:tap];
        
        myImageView* wx = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 128.0/2.0, 128.0/2.0) andImageName:@"ic_s_wx@2x" withScale:2.0 andBundleName:@"shareView"];
        wx.tag = 801;
        [self addSubview:wx];
        UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapWx)];
        [wx addGestureRecognizer:tap2];
        
        myImageView* sina = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 128.0/2.0, 128.0/2.0) andImageName:@"ic_s_wb@2x" withScale:2.0 andBundleName:@"shareView"];
        sina.tag = 802;
        [self addSubview:sina];
        UITapGestureRecognizer* tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapsinaWb)];
        [sina addGestureRecognizer:tap3];
        
        myImageView* txwb = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 128.0/2.0, 128.0/2.0) andImageName:@"ic_s_qz@2x" withScale:2.0 andBundleName:@"shareView"];
        txwb.tag = 803;//ic_s_txwb@2x
        [self addSubview:txwb];
        UITapGestureRecognizer* tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taptxwb)];
        [txwb addGestureRecognizer:tap4];
        
        myImageView* qq = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 128.0/2.0, 128.0/2.0) andImageName:@"ic_s_qq@2x" withScale:2.0 andBundleName:@"shareView"];
        qq.tag = 804;
        [self addSubview:qq];
        UITapGestureRecognizer* tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapqq)];
        [qq addGestureRecognizer:tap5];
        
        myImageView* sms = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 128.0/2.0, 128.0/2.0) andImageName:@"ic_s_sms@2x" withScale:2.0 andBundleName:@"shareView"];
        sms.tag = 805;
        [self addSubview:sms];
        UITapGestureRecognizer* tap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapsms)];
        [sms addGestureRecognizer:tap6];
        
        myImageView* link = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 128.0/2.0, 128.0/2.0) andImageName:@"ic_s_link@2x" withScale:2.0 andBundleName:@"shareView"];
        link.tag = 806;
        [self addSubview:link];
        UITapGestureRecognizer* tap7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taplink)];
        [link addGestureRecognizer:tap7];
        
        myImageView* mail = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 128.0/2.0, 128.0/2.0) andImageName:@"ic_s_mail@2x" withScale:2.0 andBundleName:@"shareView"];
        mail.tag = 807;
        [self addSubview:mail];
        UITapGestureRecognizer* tap8 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapmail)];
        [mail addGestureRecognizer:tap8];
        
        myImageView* backbtn = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 128.0/2.0, 128.0/2.0) andImageName:@"ic_s_x@2x" withScale:2.0 andBundleName:@"shareView"];
        backbtn.tag = 808;
        [self addSubview:backbtn];
        UITapGestureRecognizer* tap9 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [backbtn addGestureRecognizer:tap9];
        
        [self initBg2];
    }
    return self;
}
-(void)initBg2{
    UIView* bg2 = [self viewWithTag:798];
    bg2.alpha = 0.0;
    UILabel* mbtitle = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 128.0/2.0,16.0)];
    mbtitle.tag = 700;
    [mbtitle setFont:[UIFont systemFontOfSize:15]];
    [mbtitle setTextAlignment:NSTextAlignmentCenter];
    [mbtitle setLineBreakMode:NSLineBreakByClipping];
    [mbtitle setTextColor:[[UIColor alloc] initWithWhite:0.4 alpha:1.0]];
    [mbtitle setBackgroundColor:[UIColor clearColor]];
    [mbtitle setText:@"朋友圈"];
    [bg2 addSubview:mbtitle];
    
    UILabel* mbtitle1 = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 128.0/2.0,16.0)];
    mbtitle1.tag = 701;
    [mbtitle1 setFont:[UIFont systemFontOfSize:15]];
    [mbtitle1 setTextAlignment:NSTextAlignmentCenter];
    [mbtitle1 setLineBreakMode:NSLineBreakByClipping];
    [mbtitle1 setTextColor:[[UIColor alloc] initWithWhite:0.4 alpha:1.0]];
    [mbtitle1 setBackgroundColor:[UIColor clearColor]];
    [mbtitle1 setText:@"微信"];
    [bg2 addSubview:mbtitle1];
    
    UILabel* mbtitle2 = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 128.0/2.0,16.0)];
    mbtitle2.tag = 702;
    [mbtitle2 setFont:[UIFont systemFontOfSize:15]];
    [mbtitle2 setTextAlignment:NSTextAlignmentCenter];
    [mbtitle2 setLineBreakMode:NSLineBreakByClipping];
    [mbtitle2 setTextColor:[[UIColor alloc] initWithWhite:0.4 alpha:1.0]];
    [mbtitle2 setBackgroundColor:[UIColor clearColor]];
    [mbtitle2 setText:@"新浪微博"];
    [bg2 addSubview:mbtitle2];
    
    UILabel* mbtitle3 = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 128.0/2.0,16.0)];
    mbtitle3.tag = 703;
    [mbtitle3 setFont:[UIFont systemFontOfSize:15]];
    [mbtitle3 setTextAlignment:NSTextAlignmentCenter];
    [mbtitle3 setLineBreakMode:NSLineBreakByClipping];
    [mbtitle3 setTextColor:[[UIColor alloc] initWithWhite:0.4 alpha:1.0]];
    [mbtitle3 setBackgroundColor:[UIColor clearColor]];
    [mbtitle3 setText:@"QQ空间"];//腾讯微博
    [bg2 addSubview:mbtitle3];
    
    UILabel* mbtitle4 = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 128.0/2.0,16.0)];
    mbtitle4.tag = 704;
    [mbtitle4 setFont:[UIFont systemFontOfSize:15]];
    [mbtitle4 setTextAlignment:NSTextAlignmentCenter];
    [mbtitle4 setLineBreakMode:NSLineBreakByClipping];
    [mbtitle4 setTextColor:[[UIColor alloc] initWithWhite:0.4 alpha:1.0]];
    [mbtitle4 setBackgroundColor:[UIColor clearColor]];
    [mbtitle4 setText:@"关闭窗口"];
    [bg2 addSubview:mbtitle4];
    
    UILabel* mbtitle5 = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 128.0/2.0,16.0)];
    mbtitle5.tag = 705;
    [mbtitle5 setFont:[UIFont systemFontOfSize:15]];
    [mbtitle5 setTextAlignment:NSTextAlignmentCenter];
    [mbtitle5 setLineBreakMode:NSLineBreakByClipping];
    [mbtitle5 setTextColor:[[UIColor alloc] initWithWhite:0.4 alpha:1.0]];
    [mbtitle5 setBackgroundColor:[UIColor clearColor]];
    [mbtitle5 setText:@"QQ好友"];
    [bg2 addSubview:mbtitle5];
    
    UILabel* mbtitle6 = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 128.0/2.0,16.0)];
    mbtitle6.tag = 706;
    [mbtitle6 setFont:[UIFont systemFontOfSize:15]];
    [mbtitle6 setTextAlignment:NSTextAlignmentCenter];
    [mbtitle6 setLineBreakMode:NSLineBreakByClipping];
    [mbtitle6 setTextColor:[[UIColor alloc] initWithWhite:0.4 alpha:1.0]];
    [mbtitle6 setBackgroundColor:[UIColor clearColor]];
    [mbtitle6 setText:@"短信"];
    [bg2 addSubview:mbtitle6];
    
    UILabel* mbtitle7 = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 128.0/2.0,16.0)];
    mbtitle7.tag = 707;
    [mbtitle7 setFont:[UIFont systemFontOfSize:15]];
    [mbtitle7 setTextAlignment:NSTextAlignmentCenter];
    [mbtitle7 setLineBreakMode:NSLineBreakByClipping];
    [mbtitle7 setTextColor:[[UIColor alloc] initWithWhite:0.4 alpha:1.0]];
    [mbtitle7 setBackgroundColor:[UIColor clearColor]];
    [mbtitle7 setText:@"复制链接"];
    [bg2 addSubview:mbtitle7];
    
    UILabel* mbtitle8 = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 128.0/2.0,16.0)];
    mbtitle8.tag = 708;
    [mbtitle8 setFont:[UIFont systemFontOfSize:15]];
    [mbtitle8 setTextAlignment:NSTextAlignmentCenter];
    [mbtitle8 setLineBreakMode:NSLineBreakByClipping];
    [mbtitle8 setTextColor:[[UIColor alloc] initWithWhite:0.4 alpha:1.0]];
    [mbtitle8 setBackgroundColor:[UIColor clearColor]];
    [mbtitle8 setText:@"邮件"];
    [bg2 addSubview:mbtitle8];
    CGRect f = [UIScreen mainScreen].bounds;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        f = IPAD_FRAME;
    };
    CGFloat h = -12;
    mbtitle.center = CGPointMake(f.size.width/2.0-72.0/2.0-128.0/2.0, f.size.height-368.0/2.0 - 128.0/4.0 - 90.0/2.0+h);
    mbtitle1.center = CGPointMake(f.size.width/2.0, f.size.height-368.0/2.0 - 128.0/4.0 - 90.0/2.0+h);
    mbtitle2.center = CGPointMake(f.size.width/2.0+72.0/2.0+128.0/2.0, f.size.height-368.0/2.0 - 128.0/4.0 - 90.0/2.0+h);
    mbtitle3.center = CGPointMake(f.size.width/2.0-72.0/2.0-128.0/2.0, f.size.height-368.0/2.0 + 128.0/4.0+h);
    mbtitle4.center = CGPointMake(f.size.width/2.0, f.size.height-368.0/2.0 + 128.0/4.0+h);
    mbtitle5.center = CGPointMake(f.size.width/2.0+72.0/2.0+128.0/2.0, f.size.height-368.0/2.0 + 128.0/4.0+h);
    mbtitle6.center = CGPointMake(f.size.width/2.0-72.0/2.0-128.0/2.0, f.size.height-368.0/2.0 + 128.0/4.0 + 90.0/2.0 + 128.0/2.0+h);
    mbtitle7.center = CGPointMake(f.size.width/2.0, f.size.height-368.0/2.0 + 128.0/4.0 + 90.0/2.0 + 128.0/2.0+h);
    mbtitle8.center = CGPointMake(f.size.width/2.0+72.0/2.0+128.0/2.0, f.size.height-368.0/2.0 + 128.0/4.0 + 90.0/2.0 +128.0/2.0+h);
}
-(void)updateOrientation{
    CGRect f = [UIScreen mainScreen].bounds;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        f = IPAD_FRAME;
    }
    self.frame = f;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat pi = (CGFloat)M_PI;
    if (orientation == UIDeviceOrientationPortrait) {
        self.transform = CGAffineTransformIdentity;
    }else if (orientation == UIDeviceOrientationLandscapeLeft) {
        self.transform = CGAffineTransformMakeRotation(pi * (90.f) / 180.0f);
        self.frame = CGRectMake(-self.frame.size.width+self.frame.size.height,0, self.frame.size.width, self.frame.size.height);
    } else if (orientation == UIDeviceOrientationLandscapeRight) {
        self.transform = CGAffineTransformMakeRotation(pi * (-90.f) / 180.0f);
        self.frame = CGRectMake(0,self.frame.size.width-self.frame.size.height, self.frame.size.width, self.frame.size.height);
    } else if (orientation == UIDeviceOrientationPortraitUpsideDown) {
    }
}
-(void)show{
    CGRect f = [UIScreen mainScreen].bounds;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        f = IPAD_FRAME;
    }
    [self updateOrientation];
    UIView* bg = [self viewWithTag:799];
    UIView* bg2 = [self viewWithTag:798];
    bg2.alpha = 0.0;
    UIView* backbtn = [self viewWithTag:808];
    backbtn.center = CGPointMake(f.size.width/2.0, f.size.height+128.0/4.0);
    UIView* btn1 = [self viewWithTag:800];
    btn1.center = CGPointMake(f.size.width/2.0, f.size.height+128.0/4.0);
    UIView* btn2 = [self viewWithTag:801];
    btn2.center = CGPointMake(f.size.width/2.0, f.size.height+128.0/4.0);
    UIView* btn3 = [self viewWithTag:802];
    btn3.center = CGPointMake(f.size.width/2.0, f.size.height+128.0/4.0);
    UIView* btn4 = [self viewWithTag:803];
    btn4.center = CGPointMake(f.size.width/2.0, f.size.height+128.0/4.0);
    UIView* btn5 = [self viewWithTag:804];
    btn5.center = CGPointMake(f.size.width/2.0, f.size.height+128.0/4.0);
    UIView* btn6 = [self viewWithTag:805];
    btn6.center = CGPointMake(f.size.width/2.0, f.size.height+128.0/4.0);
    UIView* btn7 = [self viewWithTag:806];
    btn7.center = CGPointMake(f.size.width/2.0, f.size.height+128.0/4.0);
    UIView* btn8 = [self viewWithTag:807];
    btn8.center = CGPointMake(f.size.width/2.0, f.size.height+128.0/4.0);
    backbtn.alpha = 1.0;
    btn1.alpha = 0.0;
    btn2.alpha = 0.0;
    btn3.alpha = 0.0;
    btn4.alpha = 0.0;
    btn5.alpha = 0.0;
    btn6.alpha = 0.0;
    btn7.alpha = 0.0;
    btn8.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        bg.alpha = 1.0;
        
        backbtn.center = CGPointMake(f.size.width/2.0, f.size.height-368.0/2.0 - 128.0/4.0);
        btn1.center = CGPointMake(f.size.width/2.0, f.size.height-368.0/2.0 - 128.0/4.0);
        btn2.center = CGPointMake(f.size.width/2.0, f.size.height-368.0/2.0 - 128.0/4.0);
        btn3.center = CGPointMake(f.size.width/2.0, f.size.height-368.0/2.0 - 128.0/4.0);
        btn4.center = CGPointMake(f.size.width/2.0, f.size.height-368.0/2.0 - 128.0/4.0);
        btn5.center = CGPointMake(f.size.width/2.0, f.size.height-368.0/2.0 - 128.0/4.0);
        btn6.center = CGPointMake(f.size.width/2.0, f.size.height-368.0/2.0 - 128.0/4.0);
        btn7.center = CGPointMake(f.size.width/2.0, f.size.height-368.0/2.0 - 128.0/4.0);
        btn8.center = CGPointMake(f.size.width/2.0, f.size.height-368.0/2.0 - 128.0/4.0);
    }];
    [UIView animateWithDuration:0.5 delay:0.3 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        btn1.center = CGPointMake(f.size.width/2.0-72.0/2.0-128.0/2.0, f.size.height-368.0/2.0 - 128.0/4.0 - 90.0/2.0 - 128.0/2.0);
        btn1.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.5 delay:0.4 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        btn2.center = CGPointMake(f.size.width/2.0, f.size.height-368.0/2.0 - 128.0/4.0 - 90.0/2.0 - 128.0/2.0);
        btn2.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.5 delay:0.5 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        btn3.center = CGPointMake(f.size.width/2.0+72.0/2.0+128.0/2.0, f.size.height-368.0/2.0 - 128.0/4.0 - 90.0/2.0 - 128.0/2.0);
        btn3.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.5 delay:1.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        btn4.center = CGPointMake(f.size.width/2.0-72.0/2.0-128.0/2.0, f.size.height-368.0/2.0 - 128.0/4.0);
        btn4.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.5 delay:0.6 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        btn5.center = CGPointMake(f.size.width/2.0+72.0/2.0+128.0/2.0, f.size.height-368.0/2.0 - 128.0/4.0);
        btn5.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.5 delay:0.9 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        btn6.center = CGPointMake(f.size.width/2.0-72.0/2.0-128.0/2.0, f.size.height-368.0/2.0 - 128.0/4.0 + 90.0/2.0 + 128.0/2.0);
        btn6.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.5 delay:0.8 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        btn7.center = CGPointMake(f.size.width/2.0, f.size.height-368.0/2.0 - 128.0/4.0 + 90.0/2.0 + 128.0/2.0);
        btn7.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.5 delay:0.7 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        btn8.center = CGPointMake(f.size.width/2.0+72.0/2.0+128.0/2.0, f.size.height-368.0/2.0 - 128.0/4.0 + 90.0/2.0 +128.0/2.0);
        btn8.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            bg2.alpha = 1.0;
        }];
    }];
}
-(void)hide{
    UIView* bg = [self viewWithTag:799];
    UIView* btn0 = [self viewWithTag:800];
    UIView* btn1 = [self viewWithTag:801];
    UIView* btn2 = [self viewWithTag:802];
    UIView* btn3 = [self viewWithTag:803];
    UIView* btn4 = [self viewWithTag:804];
    UIView* btn5 = [self viewWithTag:805];
    UIView* btn6 = [self viewWithTag:806];
    UIView* btn7 = [self viewWithTag:807];
    UIView* btn8 = [self viewWithTag:808];
    [UIView animateWithDuration:0.3 animations:^{
        bg.alpha = 0.0;
        btn0.alpha = 0.0;
        btn1.alpha = 0.0;
        btn2.alpha = 0.0;
        btn3.alpha = 0.0;
        btn4.alpha = 0.0;
        btn5.alpha = 0.0;
        btn6.alpha = 0.0;
        btn7.alpha = 0.0;
        btn8.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.frame = CGRectZero;
    }];
}
-(void)tapWx{
    [TalkingData trackEvent:@"分享" label:@"微信"];
    [self shareWXWithTitle:self.title andDes:self.msg andURL:self.url andHeadImg:self.img];
}
-(void)tapPyq{
    [TalkingData trackEvent:@"分享" label:@"朋友圈"];
    [self shareWXPYWithTitle:self.title andDes:self.msg andURL:self.url andHeadImg:self.img];
}
-(void)tapsinaWb{
    [TalkingData trackEvent:@"分享" label:@"新浪微博"];
    [self shareSinaWeiboWithTitle:self.title andDes:self.msg andURL:self.url andHeadImg:self.img];
}
-(void)taptxwb{
    [TalkingData trackEvent:@"分享" label:@"QQZone"];
//    [self shareTencentWeiboWithTitle:self.title andDes:self.msg andURL:self.url andHeadImg:self.img];
    [self shareQQZoneWithTitle:self.title andDes:self.msg andURL:self.url andHeadImg:self.imgUrl];
}
-(void)taplink{
    [TalkingData trackEvent:@"分享" label:@"复制链接"];
    NSString* msg = [[NSString alloc] initWithFormat:@"%@ %@ %@",self.title,self.msg,self.url];
    [self copyWithMsg:msg];
}
-(void)tapsms{
    [TalkingData trackEvent:@"分享" label:@"短信"];
    NSString* msg = [[NSString alloc] initWithFormat:@"%@ %@ %@",self.title,self.msg,self.url];
    [self shareMsgWithMsg:msg];
}
-(void)tapqq{
    [TalkingData trackEvent:@"分享" label:@"QQ"];
    [self shareQQWithTitle:self.title andDes:self.msg andURL:self.url andHeadImg:self.imgUrl];
}
-(void)tapmail{
    [TalkingData trackEvent:@"分享" label:@"邮箱"];
    [self shareMailWithTitle:self.title andDes:self.msg andURL:self.url andHeadImg:self.img];
}

-(void)changeHidden:(BOOL)hide completion:(void (^)(BOOL finished))completion{
    UIView* bg = [self viewWithTag:799];
    UIView* btn0 = [self viewWithTag:800];
    UIView* btn1 = [self viewWithTag:801];
    UIView* btn2 = [self viewWithTag:802];
    UIView* btn3 = [self viewWithTag:803];
    UIView* btn4 = [self viewWithTag:804];
    UIView* btn5 = [self viewWithTag:805];
    UIView* btn6 = [self viewWithTag:806];
    UIView* btn7 = [self viewWithTag:807];
    UIView* btn8 = [self viewWithTag:808];
    if (hide) {
        [UIView animateWithDuration:0.3 animations:^{
            bg.alpha = 0;
            btn0.alpha = 0.0;
            btn1.alpha = 0.0;
            btn2.alpha = 0.0;
            btn3.alpha = 0.0;
            btn4.alpha = 0.0;
            btn5.alpha = 0.0;
            btn6.alpha = 0.0;
            btn7.alpha = 0.0;
            btn8.alpha = 0.0;
        } completion:completion];
        //        self.hidden = YES;
    } else {
        [self show];
    }
}
-(void)shareMsgWithMsg:(NSString*)msg{
    if( [MFMessageComposeViewController canSendText] ){
        
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init]; //autorelease];
        controller.body = msg;
        controller.messageComposeDelegate = self.fromvc;
        [self changeHidden:YES completion:^(BOOL finished){
            self.frame = CGRectZero;
            [self.fromvc presentViewController:controller animated:YES completion:nil];
        }];
        
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"信息发送"];//修改短信界面标题
    }
}
-(void)shareTencentWeiboWithTitle:(NSString*)title andDes:(NSString*)des andURL:(NSString*)url andHeadImg:(UIImage*)img{
    // 首先判断服务器是否可以访问
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
        NSLog(@"Available");
        
        // 使用SLServiceTypeSinaWeibo来创建一个新浪微博view Controller
        SLComposeViewController *socialVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTencentWeibo];//
        
        // 写一个bolck，用于completionHandler的初始化
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result) {
            if (result == SLComposeViewControllerResultCancelled) {
                NSLog(@"cancelled");
            } else
            {
                NSLog(@"done");
            }
            [socialVC dismissViewControllerAnimated:YES completion:^(){
                [self changeHidden:NO completion:nil];
            }];
        };
        // 初始化completionHandler，当post结束之后（无论是done还是cancell）该blog都会被调用
        socialVC.completionHandler = myBlock;
        
        // 给view controller初始化默认的图片，url，文字信息

        NSURL *URL = [NSURL URLWithString:url];
        
        [socialVC setInitialText:[[NSString alloc] initWithFormat:@"%@\n%@",title,des]];
        [socialVC addImage:img];
        [socialVC addURL:URL];
        
        // 以模态的方式展现view controller
        [self changeHidden:YES completion:^(BOOL finished){
            self.frame = CGRectZero;
            [self.fromvc presentViewController:socialVC animated:YES completion:nil];
        }];
        
    } else {
//        [[StatusBar sharedStatusBar] talkMsg:@"请在手机设置中添加您的腾讯微博账号。" inTime:0.51];
        [[waitingView sharedwaitingView] WarningByMsg:@"请在手机设置中添加您的腾讯微博账号。" haveCancel:NO];
        [[waitingView sharedwaitingView] performSelector:@selector(stopWait) withObject:nil afterDelay:LONG_TIME];
    }
}

-(void)shareSinaWeiboWithTitle:(NSString*)title andDes:(NSString*)des andURL:(NSString*)url andHeadImg:(UIImage*)img{
    // 首先判断服务器是否可以访问
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
        NSLog(@"Available");
        
        // 使用SLServiceTypeSinaWeibo来创建一个新浪微博view Controller
        SLComposeViewController *socialVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
        
        // 写一个bolck，用于completionHandler的初始化
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result) {
            if (result == SLComposeViewControllerResultCancelled) {
                NSLog(@"cancelled");
            } else
            {
                NSLog(@"done");
            }
            [socialVC dismissViewControllerAnimated:YES completion:^(){
                [self changeHidden:NO completion:nil];
            }];
        };
        // 初始化completionHandler，当post结束之后（无论是done还是cancell）该blog都会被调用
        socialVC.completionHandler = myBlock;
        
        // 给view controller初始化默认的图片，url，文字信息
        NSURL *URL = [NSURL URLWithString:url];
        
        [socialVC setInitialText:[[NSString alloc] initWithFormat:@"%@\n%@",title,des]];
        [socialVC addImage:img];
        [socialVC addURL:URL];
        
        // 以模态的方式展现view controller
        [self changeHidden:YES completion:^(BOOL finished){
            self.frame = CGRectZero;
            [self.fromvc presentViewController:socialVC animated:YES completion:nil];
        }];
        
    } else {
//        [[StatusBar sharedStatusBar] talkMsg:@"请在手机设置中添加您的新浪微博账号。" inTime:0.51];
        [[waitingView sharedwaitingView] WarningByMsg:@"请在手机设置中添加您的新浪微博账号。" haveCancel:NO];
        [[waitingView sharedwaitingView] performSelector:@selector(stopWait) withObject:nil afterDelay:LONG_TIME];
    }
}
-(void)shareWXWithTitle:(NSString*)title andDes:(NSString*)des andURL:(NSString*)url andHeadImg:(UIImage*)img{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = des;
    CGSize size = CGSizeMake(120, 120);
    img = [self imageWithImageSimple:img scaledToSize:size];
    [message setThumbImage:img];
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = url;
    message.mediaObject = ext;
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
}
-(void)shareWXPYWithTitle:(NSString*)title andDes:(NSString*)des andURL:(NSString*)url andHeadImg:(UIImage*)img{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = des;
    CGSize size = CGSizeMake(120, 120);
    img = [self imageWithImageSimple:img scaledToSize:size];
    [message setThumbImage:img];
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = url;
    message.mediaObject = ext;
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    [WXApi sendReq:req];
}
-(void)copyWithMsg:(NSString*)msg{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = msg;
//    [[StatusBar sharedStatusBar] talkMsg:@"已复制到剪贴板。" inTime:1.51];
    [[waitingView sharedwaitingView] WarningByMsg:@"已复制到剪贴板。" haveCancel:NO];
    [[waitingView sharedwaitingView] performSelector:@selector(stopWait) withObject:nil afterDelay:WAITING_TIME];
}

-(void)shareQQZoneWithTitle:(NSString*)title andDes:(NSString*)des andURL:(NSString*)url andHeadImg:(NSString*)img{
    NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:title,@"title",des,@"des",url,@"url",img,@"imgUrl", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"QQZONE_SENDTO" object:dic];
}
-(void)shareQQWithTitle:(NSString*)title andDes:(NSString*)des andURL:(NSString*)url andHeadImg:(NSString*)img{
    NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:title,@"title",des,@"des",url,@"url",img,@"imgUrl", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"QQ_SENDTO" object:dic];
}
-(void)shareMailWithTitle:(NSString*)title andDes:(NSString*)des andURL:(NSString*)url andHeadImg:(UIImage*)img{
    if( [MFMailComposeViewController canSendMail] ){
        
        MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
        mailPicker.mailComposeDelegate = self.fromvc;
        
        //设置主题
        [mailPicker setSubject: title];
        NSString *emailBody = [[NSString alloc] initWithFormat:@"%@\n%@",des,url];
        [mailPicker setMessageBody:emailBody isHTML:NO];
        [self changeHidden:YES completion:^(BOOL finished){
            self.frame = CGRectZero;
            [self.fromvc presentViewController:mailPicker animated:YES completion:nil];
        }];
    }else{
//        [[StatusBar sharedStatusBar] talkMsg:@"您还没有设置iOS邮件账户。" inTime:1.51];
        [[waitingView sharedwaitingView] WarningByMsg:@"您还没有设置iOS邮件账户。" haveCancel:NO];
        [[waitingView sharedwaitingView] performSelector:@selector(stopWait) withObject:nil afterDelay:ERR_TIME];
    }
}

- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

@end
