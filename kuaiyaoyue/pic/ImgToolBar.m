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
        bk.backgroundColor = [UIColor clearColor];
        CAGradientLayer* layer = [CAGradientLayer layer];
        layer.frame = self.bounds;
        layer.colors = [[NSArray alloc] initWithObjects:
                        (id)[[UIColor alloc] initWithRed:75.0/255.0 green:75.0/255.0 blue:75.0/255.0 alpha:0.9].CGColor,
                        (id)[[UIColor alloc] initWithRed:25.0/255.0 green:25.0/255.0 blue:25.0/255.0 alpha:0.6].CGColor, nil];
        layer.locations = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:1.0], nil];
        [bk.layer addSublayer:layer];
        bk.tag = 101;
        [self addSubview:bk];
        
        myImageView* btnRight = [[myImageView alloc] initWithFrame:CGRectMake(bk.frame.size.width-66.0, 0.0, 66.0, 44.0) andImageName:@"" withScale:2.0 andBundleName:@"imgBar"];
        btnRight.tag = 103;
        [bk addSubview:btnRight];
        UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(RightTap)];
        [btnRight addGestureRecognizer:tap2 ];
        UILabel* lbl_OK = [[UILabel alloc] initWithFrame:btnRight.bounds];
        lbl_OK.font = [UIFont boldSystemFontOfSize:20];
        lbl_OK.text = @"确定";
        lbl_OK.textAlignment = NSTextAlignmentCenter;
        lbl_OK.textColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        [btnRight addSubview:lbl_OK];
        UIView* line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 1)];
        line.backgroundColor = [[UIColor alloc] initWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:8.0];
        [self addSubview:line];
    }
    return self;
}
-(void)RightTap{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_IMGS_OK" object:nil];
}
-(void)okCount:(NSInteger)count{
    myImageView* btnRight = (myImageView*)[self viewWithTag:103];
    [btnRight setBadgeValue:count];
}
@end
