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
        
        UIView* btnRight = [[UIView alloc] initWithFrame:CGRectMake(bk.frame.size.width-60.0, 20.0, 60.0, 44.0)];
        btnRight.backgroundColor = [UIColor clearColor];
        btnRight.tag = 103;
        [bk addSubview:btnRight];
        UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LeftTap)];
        [btnRight addGestureRecognizer:tap2 ];
        UILabel* lbl_OK = [[UILabel alloc] initWithFrame:btnRight.bounds];
        lbl_OK.tag = 113;
        lbl_OK.font = [UIFont systemFontOfSize:18];
        lbl_OK.text = @"取消";
        lbl_OK.textAlignment = NSTextAlignmentCenter;
        lbl_OK.textColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        [btnRight addSubview:lbl_OK];
        
        UIView* btnLeft = [[UIView alloc] initWithFrame:CGRectMake(0.0, 20.0, 60.0, 44.0)];
        btnLeft.backgroundColor = [UIColor clearColor];
        btnLeft.tag = 104;
        [bk addSubview:btnLeft];
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(RightTap)];
        [btnLeft addGestureRecognizer:tap ];
        UILabel* lbl_PV = [[UILabel alloc] initWithFrame:btnLeft.bounds];
        lbl_PV.tag = 114;
        lbl_PV.font = [UIFont systemFontOfSize:18];
        lbl_PV.text = @"相册";
        lbl_PV.textAlignment = NSTextAlignmentCenter;
        lbl_PV.textColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        [btnLeft addSubview:lbl_PV];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
        line.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.5];
        [self addSubview:line];
        
        UILabel* lbl_title = [[UILabel alloc] initWithFrame:CGRectMake(60.0, 20.0, bk.frame.size.width-120.0, 44.0)];
        lbl_title.tag = 105;
        lbl_title.font = [UIFont boldSystemFontOfSize:19];
        lbl_title.text = @"相册";
        lbl_title.textAlignment = NSTextAlignmentCenter;
        lbl_title.adjustsFontSizeToFitWidth = YES;
        lbl_title.textColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        [self addSubview:lbl_title];
    }
    return self;
}
-(void)setTitle:(NSString*)t_s{
    UILabel* title = (UILabel*)[self viewWithTag:105];
    title.text = t_s;
}
-(void)LeftTap{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_BACK" object:nil];
}
-(void)RightTap{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_IMGS_LIST" object:nil];
}
//-(void)okCount:(NSInteger)count{
//    myImageView* btnRight = (myImageView*)[self viewWithTag:103];
//    [btnRight setBadgeValue:count];
//}
@end
