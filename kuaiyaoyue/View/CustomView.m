//
//  CustomView.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/23.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)show_top_onclick:(id)sender {
}

- (IBAction)time_onclick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(CVDelegate:didTapAtIndex:)]){
        [self.delegate CVDelegate:self didTapAtIndex:0];}
}

- (IBAction)endtime_onclick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(CVDelegate:didTapAtIndex:)]){
        [self.delegate CVDelegate:self didTapAtIndex:1];}
}

- (IBAction)music_onclick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(CVDelegate:didTapAtIndex:)]){
        [self.delegate CVDelegate:self didTapAtIndex:2];}
}
@end
