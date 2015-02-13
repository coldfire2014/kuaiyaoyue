//
//  ipadTabItem.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/2/12.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import "ipadTabItem.h"
#import "myImageView.h"
@implementation ipadTabItem

- (instancetype)initWithFrame:(CGRect)frame andIconfile:(NSString*)fileName andName:(NSString*)name
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIView* sendBtnb = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        sendBtnb.backgroundColor = [UIColor clearColor];
        [self addSubview:sendBtnb];
        CAGradientLayer* layer = [CAGradientLayer layer];
        layer.frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.width);
        layer.position = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
        layer.colors = [[NSArray alloc] initWithObjects:
                        (id)[[UIColor alloc] initWithRed:25.0/255.0 green:25.0/255.0 blue:25.0/255.0 alpha:0.9].CGColor,
                        (id)[[UIColor alloc] initWithRed:25.0/255.0 green:25.0/255.0 blue:25.0/255.0 alpha:0.2].CGColor,
                        (id)[[UIColor alloc] initWithRed:25.0/255.0 green:25.0/255.0 blue:25.0/255.0 alpha:0.9].CGColor,
                        nil];
        layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 0, 1);
        layer.locations = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:0.5],[NSNumber numberWithDouble:1.0], nil];
        [sendBtnb.layer addSublayer:layer];
        
        myImageView* btnSend = [[myImageView alloc] initWithFrame:CGRectMake(88.0/4.0-38.0/4.0,88.0/8.0-38.0/8.0,  38.0/2.0, 38.0/2.0) andImageName:fileName withScale:2.0];
        UIView* sendc = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 88.0/2.0, 88.0/2.0)];
        sendc.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
        sendc.backgroundColor = [UIColor clearColor];
        sendc.layer.cornerRadius = 88.0/4.0;
        [self addSubview:sendc];
        UILabel* lbl_s = [[UILabel alloc] initWithFrame:CGRectMake(0.0,38.0/4.0, 88.0/2.0, 88.0/2.0)];
        lbl_s.font = [UIFont systemFontOfSize:11];
        lbl_s.text = name;
        lbl_s.textAlignment = NSTextAlignmentCenter;
        lbl_s.textColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        [sendc addSubview:lbl_s];
        [sendc addSubview:btnSend];
    }
    return self;
}

@end
