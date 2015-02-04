//
//  ImgNavBar.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 14/12/8.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "ImgNavBar.h"
#import "myImageView.h"
@implementation ImgNavBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat top = 20.0;
        if (frame.size.height < 128.0/2.0) {
            top = 0;
        }
        UIView* bk = [[UIView alloc] initWithFrame:self.bounds];
        bk.backgroundColor = [UIColor clearColor];
        CAGradientLayer* layer = [CAGradientLayer layer];
        CGRect f = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.width);
        layer.frame = f;
        layer.position = bk.center;
        layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 0, 1);
        layer.colors = [[NSArray alloc] initWithObjects:
                        (id)[[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0].CGColor,
                        (id)[[UIColor alloc] initWithRed:255.0/255.0 green:105.0/255.0 blue:105.0/255.0 alpha:1.0].CGColor, nil];
        layer.locations = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:1.0], nil];
        [bk.layer addSublayer:layer];
        bk.tag = 101;
        [self addSubview:bk];
        
        myImageView* btnLeft = [[myImageView alloc] initWithFrame:CGRectMake(0, top, 44.0, 44.0) andImageName:@"T3" withScale:2.0 andBundleName:@"imgBar"];
        btnLeft.tag = 102;
        [bk addSubview:btnLeft];
        UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LeftTap)];
        [btnLeft addGestureRecognizer:tap1 ];
        
        myImageView* btnRight = [[myImageView alloc] initWithFrame:CGRectMake(bk.frame.size.width-44.0, top, 44.0, 44.0) andImageName:@"T4" withScale:2.0 andBundleName:@"imgBar"];
        btnRight.tag = 103;
        [bk addSubview:btnRight];
        UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(RightTap)];
        [btnRight addGestureRecognizer:tap2 ];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
        line.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.5];
        [self addSubview:line];
    }
    return self;
}
-(void)LeftTap{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_BACK" object:nil];
}
-(void)RightTap{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_IMGS_OK" object:nil];
}
-(void)okCount:(NSInteger)count{
    myImageView* btnRight = (myImageView*)[self viewWithTag:103];
    [btnRight setBadgeValue:count];
}
@end
