//
//  ImgToolBar.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/1/6.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import "ImgToolBar.h"
#import "myImageView.h"
@implementation ImgToolBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView* bk = [[UIView alloc] initWithFrame:self.bounds];
        bk.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
//        CAGradientLayer* layer = [CAGradientLayer layer];
//        layer.frame = self.bounds;
//        layer.colors = [[NSArray alloc] initWithObjects:
//                        (id)[[UIColor alloc] initWithRed:205.0/255.0 green:75.0/255.0 blue:75.0/255.0 alpha:0.9].CGColor,
//                        (id)[[UIColor alloc] initWithRed:25.0/255.0 green:25.0/255.0 blue:25.0/255.0 alpha:0.6].CGColor, nil];
//        layer.locations = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:1.0], nil];
//        [bk.layer addSublayer:layer];
        bk.tag = 101;
        [self addSubview:bk];
        
        UIView* btnRight = [[UIView alloc] initWithFrame:CGRectMake(bk.frame.size.width-100.0, 0.0, 100.0, 48.0)];
        btnRight.backgroundColor = [UIColor clearColor];
        btnRight.tag = 103;
        [bk addSubview:btnRight];
        UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(RightTap)];
        [btnRight addGestureRecognizer:tap2 ];
        UIView* bkRight = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 76.0, 33.0)];
        bkRight.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
        bkRight.layer.borderColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0].CGColor;
        bkRight.layer.borderWidth = 1.0;
        bkRight.layer.cornerRadius = 4;
        bkRight.center = CGPointMake(btnRight.bounds.size.width/2.0, btnRight.bounds.size.height/2.0);
        bkRight.tag = 123;
        [btnRight addSubview:bkRight];
        UILabel* lbl_OK = [[UILabel alloc] initWithFrame:btnRight.bounds];
        lbl_OK.tag = 113;
        lbl_OK.font = [UIFont boldSystemFontOfSize:18];
        lbl_OK.text = @"确定";
        lbl_OK.textAlignment = NSTextAlignmentCenter;
        lbl_OK.textColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        [btnRight addSubview:lbl_OK];
        
        UIView* btnLeft = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 48.0)];
        btnLeft.alpha = 0;
        btnLeft.backgroundColor = [UIColor clearColor];
        btnLeft.tag = 104;
        [bk addSubview:btnLeft];
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LeftTap)];
        [btnLeft addGestureRecognizer:tap ];
        UIView* bkLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 76.0, 33.0)];
        bkLeft.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
        bkLeft.layer.borderColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0].CGColor;
        bkLeft.layer.borderWidth = 1.0;
        bkLeft.layer.cornerRadius = 4;
        bkLeft.center = CGPointMake(btnLeft.bounds.size.width/2.0, btnLeft.bounds.size.height/2.0);
        bkLeft.tag = 124;
        [btnLeft addSubview:bkLeft];
        UILabel* lbl_PV = [[UILabel alloc] initWithFrame:btnLeft.bounds];
        lbl_PV.tag = 114;
        lbl_PV.font = [UIFont boldSystemFontOfSize:18];
        lbl_PV.text = @"预览";
        lbl_PV.textAlignment = NSTextAlignmentCenter;
        lbl_PV.textColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        [btnLeft addSubview:lbl_PV];
        
        UIView* line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 0.5)];
        line.backgroundColor = [[UIColor alloc] initWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:8.0];
        [self addSubview:line];
    }
    return self;
}
-(void)RightTap{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_IMGS_OK" object:nil];
}
-(void)LeftTap{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_IMGS_PV" object:nil];
}
-(void)okCount:(NSInteger)count{
    if(count > 0){
        UIView* bkRight = [self viewWithTag:123];
        bkRight.backgroundColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        UILabel* lbl_OK = (UILabel*)[self viewWithTag:113];
        lbl_OK.text = [[NSString alloc] initWithFormat:@"确定(%d)",count];
        lbl_OK.textColor = [UIColor whiteColor];
    }else{
        UIView* bkRight = [self viewWithTag:123];
        bkRight.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
        UILabel* lbl_OK = (UILabel*)[self viewWithTag:113];
        lbl_OK.text = @"确定";
        lbl_OK.textColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
    }
}
@end
