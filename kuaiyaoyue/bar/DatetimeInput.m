//
//  DatetimeInput.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/1/27.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import "DatetimeInput.h"
#import "PCHeader.h"
@implementation DatetimeInput

+ (DatetimeInput *)sharedDatetimeInput{
    static DatetimeInput *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[DatetimeInput alloc] initWithFrame:CGRectZero];
    });
    
    return _sharedInstance;
}
-(void)updateOrientation{
    CGRect f = [UIScreen mainScreen].bounds;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        f = IPAD_FRAME;
    }
    CGFloat subTap = -20;
    if (ISIOS7LATER) {
        subTap = 0;
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
        CGFloat subTap = -20;
        if (ISIOS7LATER) {
            subTap = 0;
        }
        self.frame = f;
        [self updateOrientation];
        UIView* bg = [[UIView alloc] initWithFrame:f];
        bg.tag = 799;
        bg.alpha = 0.0;
        bg.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
        [self addSubview:bg];
        UIView* bg2 = [[UIView alloc] initWithFrame:f];
        bg2.tag = 798;
        bg2.backgroundColor = [UIColor clearColor];
        [bg addSubview:bg2];
        UIDatePicker* oneDatePicker = [[UIDatePicker alloc] init];
        oneDatePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        oneDatePicker.backgroundColor = [[UIColor alloc] initWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
        oneDatePicker.date = [NSDate date];
        oneDatePicker.datePickerMode = UIDatePickerModeDate; // 设置样式
        oneDatePicker.frame = CGRectMake(0, 0, 230, 216);
        CGFloat bkw = 324.0;
        CGFloat clockLeft = 0;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            bkw = f.size.width+4.0;
            clockLeft = (bkw - 324.0)/2.0;
        }
        UIView* bk = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bkw, oneDatePicker.bounds.size.height+48.0)];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            bk.center = CGPointMake(f.size.width/2.0, f.size.height/2.0);
        }else{
            bk.center = CGPointMake(f.size.width/2.0, f.size.height - bk.bounds.size.height/2.0);
        }
        bk.clipsToBounds = YES;
        bk.layer.cornerRadius = 4.0;
        bk.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        [bg2 addSubview:bk];
        oneDatePicker.center = CGPointMake(oneDatePicker.frame.size.width/2.0-6.0 + clockLeft, bk.bounds.size.height/2.0 + 22.0);
        [oneDatePicker addTarget:self action:@selector(DatePickerValueChanged:) forControlEvents:UIControlEventValueChanged]; // 添加监听器
        oneDatePicker.tag = 899;
        [bk addSubview:oneDatePicker];
        
        UIDatePicker* twoDatePicker = [[UIDatePicker alloc] init];
        twoDatePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        twoDatePicker.backgroundColor = [[UIColor alloc] initWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
        twoDatePicker.date = [NSDate date];
        twoDatePicker.datePickerMode = UIDatePickerModeTime; // 设置样式
        twoDatePicker.frame = CGRectMake(0, 0, 140, 216);

        twoDatePicker.center = CGPointMake(bk.bounds.size.width - twoDatePicker.frame.size.width/2.0+10.0 - clockLeft, bk.bounds.size.height/2.0 + 22.0);
        [twoDatePicker addTarget:self action:@selector(DatePickerValueChanged:) forControlEvents:UIControlEventValueChanged]; // 添加监听器
        twoDatePicker.tag = 889;
        [bk addSubview:twoDatePicker];
        
        UITapGestureRecognizer* tapOther = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [bg2 addGestureRecognizer:tapOther];
        /////////////////////////////////////////////////////////////
        UIView* btnl = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 44)];
        btnl.backgroundColor = [UIColor clearColor];
        [bk addSubview:btnl];
        UILabel* lbl_OK = [[UILabel alloc] initWithFrame:btnl.bounds];
        lbl_OK.font = [UIFont systemFontOfSize:18];
        lbl_OK.text = @"取消";
        lbl_OK.textAlignment = NSTextAlignmentCenter;
        lbl_OK.textColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        [btnl addSubview:lbl_OK];
        UITapGestureRecognizer* tapl = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [btnl addGestureRecognizer:tapl];
        
        UIView* btnr = [[UIView alloc] initWithFrame:CGRectMake(bk.bounds.size.width-70.0, 0, 70, 44)];
        btnr.backgroundColor = [UIColor clearColor];
        [bk addSubview:btnr];
        UILabel* lbl_OK2 = [[UILabel alloc] initWithFrame:btnl.bounds];
        lbl_OK2.font = [UIFont systemFontOfSize:18];
        lbl_OK2.text = @"确定";
        lbl_OK2.textAlignment = NSTextAlignmentCenter;
        lbl_OK2.textColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        [btnr addSubview:lbl_OK2];
        UITapGestureRecognizer* tapr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ok)];
        [btnr addGestureRecognizer:tapr];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, bk.frame.size.width, 0.5)];
        line.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.5];
        [bk addSubview:line];
    }
    return self;
}
- (void)DatePickerValueChanged:(UIDatePicker *) sender {
    UIDatePicker* oneDatePicker = (UIDatePicker*)[self viewWithTag:899];
    UIDatePicker* twoDatePicker = (UIDatePicker*)[self viewWithTag:889];
    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
    [tempFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc]init];
    [dayFormatter setDateFormat:@"dd.MM.yyyy"];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
    [timeFormatter setDateFormat:@"HH:mm"];
    NSString* time_str = [[NSString alloc] initWithFormat:@"%@ %@",[dayFormatter stringFromDate:[oneDatePicker date]],[timeFormatter stringFromDate:[twoDatePicker date]]];
    
    self.time = [tempFormatter dateFromString: time_str];
    if ([oneDatePicker.minimumDate compare:[NSDate date]] == NSOrderedAscending) {
        oneDatePicker.minimumDate = [NSDate date];
    }
    if (oneDatePicker.minimumDate != nil && [oneDatePicker.minimumDate compare:self.time] == NSOrderedDescending) {
        [oneDatePicker setDate:oneDatePicker.minimumDate animated:YES];
        [twoDatePicker setDate:oneDatePicker.minimumDate animated:YES];
        self.time = oneDatePicker.minimumDate;
    }else if (oneDatePicker.maximumDate != nil && [oneDatePicker.maximumDate compare:self.time] == NSOrderedAscending) {
        [oneDatePicker setDate:oneDatePicker.maximumDate animated:YES];
        [twoDatePicker setDate:oneDatePicker.maximumDate animated:YES];
        self.time = oneDatePicker.maximumDate;
    }
}
-(void)setTime:(NSDate*)ntime andMaxTime:(NSDate*)max andMinTime:(NSDate*)min{
    UIDatePicker* oneDatePicker = (UIDatePicker*)[self viewWithTag:899];
    oneDatePicker.date = ntime;
    UIDatePicker* twoDatePicker = (UIDatePicker*)[self viewWithTag:889];
    twoDatePicker.date = ntime;
    if (nil != max) {
        oneDatePicker.maximumDate = max;
    }else{
        oneDatePicker.maximumDate = nil;
    }
    if (nil != min) {
        oneDatePicker.minimumDate = min;
    }else{
        oneDatePicker.minimumDate = nil;
    }
}
-(void)ok{
    if ([self.time_delegate didSelectDateTime:[self.time timeIntervalSince1970]]) {
        [self hide];
    }
}
-(void)hide{
    UIView* bg = [self viewWithTag:799];
    UIView* bg2 = [self viewWithTag:798];
    [UIView animateWithDuration:0.3 animations:^{
        bg2.alpha = 0.0;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            bg2.layer.transform = CATransform3DMakeTranslation(0, -260, 0);
        }else{
            bg2.layer.transform = CATransform3DMakeTranslation(0, 260, 0);
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            bg.alpha = 0.0;
        } completion:^(BOOL finished) {
            self.frame = CGRectZero;
        }];
    }];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_TIME_INPUT_BACK" object:nil];
}

-(void)show{
//    CGRect f = [[UIScreen mainScreen] bounds];
//    self.frame = f;
    [self updateOrientation];
    UIView* bg = [self viewWithTag:799];
    UIView* bg2 = [self viewWithTag:798];
    bg2.alpha = 0.0;
    bg2.layer.transform = CATransform3DMakeTranslation(0, 260, 0);
    [UIView animateWithDuration:0.3 animations:^{
        bg.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            bg2.alpha = 1.0;
            bg2.layer.transform = CATransform3DIdentity;
        }];
    }];
}

@end
