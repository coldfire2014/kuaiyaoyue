//
//  ipadbg.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/2/12.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import "ipadbg.h"
#import "myImageView.h"
#import "PCHeader.h"
@implementation ipadbg

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    CGFloat w = IPAD_FRAME.size.width;
    CGFloat h = IPAD_FRAME.size.height;
    self = [super initWithFrame:CGRectMake(0, 0, w, h)];
    if (self) {
        myImageView* bg = [[myImageView alloc] initWithFrame:self.bounds andImageName:@"bg_login@2x.jpg" withScale:2.0 andAlign:UIImgAlignmentCenter];
        [self addSubview:bg];
        self.backgroundColor = [UIColor whiteColor];
        CAGradientLayer* layer = [CAGradientLayer layer];
        layer.frame = CGRectMake(0, 0, h, w);
        layer.position = CGPointMake(w/2.0, h/2.0);
        layer.colors = [[NSArray alloc] initWithObjects:
                        (id)[[UIColor alloc] initWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:0.5].CGColor,
                        (id)[[UIColor alloc] initWithRed:25.0/255.0 green:25.0/255.0 blue:25.0/255.0 alpha:0.2].CGColor,
                        (id)[[UIColor alloc] initWithRed:25.0/255.0 green:25.0/255.0 blue:25.0/255.0 alpha:0.0].CGColor,
                        nil];
        layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 0, 1);
        layer.locations = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:66.0/w],[NSNumber numberWithDouble:1.0], nil];
        [self.layer addSublayer:layer];
        self.clipsToBounds = YES;
        
        UIView *mainBg = [[UIView alloc] initWithFrame:CGRectMake(66.0, 20.0, w-61.0, h-10.0)];
        mainBg.backgroundColor = [UIColor colorWithWhite:0.95 alpha:0.95];
        mainBg.layer.cornerRadius = 4.0;
        mainBg.layer.shadowRadius = 2;
        mainBg.layer.shadowOpacity = 1.0;
        mainBg.layer.shadowColor = [UIColor grayColor].CGColor;
        mainBg.layer.shadowOffset = CGSizeMake(1, 1);
        [self addSubview:mainBg];
    }
    return self;
}
@end
