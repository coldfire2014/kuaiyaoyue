//
//  HLEditView.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/22.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "HLEditView.h"

@implementation HLEditView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)xl_next:(id)sender {
}

- (IBAction)xn_next:(id)sender {
}

- (IBAction)hltime_onclick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(HLEVDelegate:didTapAtIndex:)]){
        [self.delegate HLEVDelegate:self didTapAtIndex:0];}
}

- (IBAction)bmtime_onclick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(HLEVDelegate:didTapAtIndex:)]){
        [self.delegate HLEVDelegate:self didTapAtIndex:1];}
}

- (IBAction)address_next:(id)sender {
}

- (IBAction)music_onclick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(HLEVDelegate:didTapAtIndex:)]){
        [self.delegate HLEVDelegate:self didTapAtIndex:2];}
}

- (IBAction)address_onclick:(id)sender {
}
@end
