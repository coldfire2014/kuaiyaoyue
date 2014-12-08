//
//  countView.m
//  cartoonCard
//
//  Created by wu yangbing on 14-8-19.
//  Copyright (c) 2014年 wu yangbing. All rights reserved.
//

#import "countView.h"

@implementation countView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.layer.cornerRadius = frame.size.width/2.0;
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(3, 3, self.frame.size.width,self.frame.size.height)];
        [label setFont:[UIFont systemFontOfSize:35]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setLineBreakMode:NSLineBreakByClipping];
        [label setTextColor:[UIColor whiteColor]];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setText:@"／"];
        [self addSubview:label];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0,self.frame.size.height/2.0, self.frame.size.width/2.0,self.frame.size.height/2.0)];
        [label2 setFont:[UIFont boldSystemFontOfSize:15]];
        [label2 setTextAlignment:NSTextAlignmentCenter];
        [label2 setLineBreakMode:NSLineBreakByClipping];
        [label2 setTextColor:[UIColor whiteColor]];
        [label2 setBackgroundColor:[UIColor clearColor]];
        [label2 setText:@"10"];
        label2.tag = 12;
        [self addSubview:label2];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0,-6, self.frame.size.width/3.0*2.0,self.frame.size.height)];
        [label3 setFont:[UIFont boldSystemFontOfSize:32]];
        [label3 setTextAlignment:NSTextAlignmentCenter];
        [label3 setLineBreakMode:NSLineBreakByClipping];
        [label3 setTextColor:[UIColor whiteColor]];
        [label3 setBackgroundColor:[UIColor clearColor]];
        [label3 setText:@"0"];
        label3.tag = 13;
        [self addSubview:label3];
    }
    return self;
}
-(void)changeColor:(UIColor*)color andindex:(int)index andall:(int)all{
    self.backgroundColor = color;
    UILabel *label3 = (UILabel*)[self viewWithTag:13];
    label3.text = [[NSString alloc] initWithFormat:@"%d",index];
    UILabel *label2 = (UILabel*)[self viewWithTag:12];
    label2.text = [[NSString alloc] initWithFormat:@"%d",all];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
