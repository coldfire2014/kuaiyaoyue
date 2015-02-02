//
//  WebNavBar.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/1/10.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import "WebNavBar.h"
#import "myImageView.h"
@implementation WebNavBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat top = 20.0;
        if (frame.size.height < 128.0/2.0) {
            top = 0;
        }
        UIView* bk = [[UIView alloc] initWithFrame:self.bounds];
        bk.backgroundColor = [UIColor colorWithWhite:1 alpha:0.95];
        
//        CAGradientLayer* layer = [CAGradientLayer layer];
//        CGRect f = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.width);
//        layer.frame = f;
//        layer.position = bk.center;
//        layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 0, 1);
//        layer.colors = [[NSArray alloc] initWithObjects:
//                        (id)[[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0].CGColor,
//                        (id)[[UIColor alloc] initWithRed:255.0/255.0 green:105.0/255.0 blue:105.0/255.0 alpha:1.0].CGColor, nil];
//        layer.locations = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:1.0], nil];
//        [bk.layer addSublayer:layer];
        bk.tag = 101;
        [self addSubview:bk];
        
        myImageView* btnLeft = [[myImageView alloc] initWithFrame:CGRectMake(8.0, top, 44.0, 44.0) andImageName:@"T" withScale:2.0 andBundleName:@"imgBar"];
        btnLeft.tag = 102;
        [bk addSubview:btnLeft];
        UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LeftTap)];
        [btnLeft addGestureRecognizer:tap1 ];
        UILabel* lbl_OK = [[UILabel alloc] initWithFrame:btnLeft.bounds];
        lbl_OK.font = [UIFont systemFontOfSize:18];
        lbl_OK.text = @"返回";
        lbl_OK.textAlignment = NSTextAlignmentCenter;
        lbl_OK.textColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        [btnLeft addSubview:lbl_OK];
        
        myImageView* btnRight = [[myImageView alloc] initWithFrame:CGRectMake(bk.frame.size.width-44.0-8.0, top, 44.0, 44.0) andImageName:@"T" withScale:2.0 andBundleName:@"imgBar"];
        btnRight.tag = 103;
        [bk addSubview:btnRight];
        UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(RightTap)];
        [btnRight addGestureRecognizer:tap2 ];
        UILabel* lbl_OKr = [[UILabel alloc] initWithFrame:btnRight.bounds];
        lbl_OKr.tag = 106;
        lbl_OKr.font = [UIFont systemFontOfSize:18];
        lbl_OKr.text = @"刷新";
        lbl_OKr.textAlignment = NSTextAlignmentCenter;
        lbl_OKr.textColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        [btnRight addSubview:lbl_OKr];
        
        myImageView* btnClose = [[myImageView alloc] initWithFrame:CGRectMake(12.0+44.0, top, 44.0, 44.0) andImageName:@"T" withScale:2.0 andBundleName:@"imgBar"];
        btnClose.tag = 104;
        btnClose.alpha = 0;
        [bk addSubview:btnClose];
        UITapGestureRecognizer* tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Left2Tap)];
        [btnClose addGestureRecognizer:tap3 ];
        UILabel* lbl_OKc = [[UILabel alloc] initWithFrame:btnClose.bounds];
        lbl_OKc.font = [UIFont systemFontOfSize:18];
        lbl_OKc.text = @"关闭";
        lbl_OKc.textAlignment = NSTextAlignmentCenter;
        lbl_OKc.textColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        [btnClose addSubview:lbl_OKc];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
        line.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.5];
        [self addSubview:line];
        
        UILabel* lbl = [[UILabel alloc] initWithFrame:CGRectMake(100.0, top, bk.frame.size.width - 200.0, 44.0)];
        lbl.tag = 105;
        lbl.font = [UIFont systemFontOfSize:20];
        lbl.text = @"关闭";
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.textColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        [self addSubview:lbl];
    }
    return self;
}
-(void)LeftTap{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_BACK" object:nil];
}
-(void)Left2Tap{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_CLOSE" object:nil];
}
-(void)RightTap{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_WEB_REFLASH" object:nil];
}
-(void)reflashShow:(BOOL)isShow{
    UIView* btn = [self viewWithTag:103];
    if (isShow) {
        btn.alpha = 1;
    } else {
        btn.alpha = 0;
    }
}
-(void)closeShow:(BOOL)isShow{
    UIView* btn = [self viewWithTag:104];
    if (isShow) {
        btn.alpha = 1;
    } else {
        btn.alpha = 0;
    }

}
-(void)setRight:(NSString*)title{
    UILabel* lbl = (UILabel*)[self viewWithTag:106];
    lbl.text = title;
}
-(void)setTitle:(NSString*)title{
    UILabel* lbl = (UILabel*)[self viewWithTag:105];
    lbl.text = title;
}
@end
