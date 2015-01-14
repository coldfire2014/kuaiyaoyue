//
//  SettingNavBar.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/1/13.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import "SettingNavBar.h"
#import "myImageView.h"
@implementation SettingNavBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView* bk = [[UIView alloc] initWithFrame:self.bounds];
        bk.backgroundColor = [UIColor colorWithWhite:1 alpha:1.0];
        
        bk.tag = 101;
        [self addSubview:bk];
        
        myImageView* btnLeft = [[myImageView alloc] initWithFrame:CGRectMake(8.0, 20.0, 44.0, 44.0) andImageName:@"T" withScale:2.0 andBundleName:@"imgBar"];
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
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
        line.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.5];
        [self addSubview:line];
        
        UILabel* lbl = [[UILabel alloc] initWithFrame:CGRectMake(100.0, 20.0, bk.frame.size.width - 200.0, 44.0)];
        lbl.tag = 105;
        lbl.font = [UIFont systemFontOfSize:20];
        lbl.text = @"设置";
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.textColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        [self addSubview:lbl];
    }
    return self;
}
-(void)changeTitle:(NSString*)title{
    UILabel* lbl = (UILabel*)[self viewWithTag:105];
    lbl.text = title;
}
-(void)LeftTap{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_BACK" object:nil];
}
@end
