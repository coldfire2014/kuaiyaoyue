//
//  PlayView.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/23.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "PlayView.h"

@implementation PlayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)time_onclick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(PVDelegate:didTapAtIndex:)]){
        [self.delegate PVDelegate:self didTapAtIndex:0];}
}

- (IBAction)bmtime_onclick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(PVDelegate:didTapAtIndex:)]){
        [self.delegate PVDelegate:self didTapAtIndex:1];}
}

- (IBAction)bf_onclick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(PVDelegate:didTapAtIndex:)]){
        [self.delegate PVDelegate:self didTapAtIndex:2];}

}
- (IBAction)del_onclick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(PVDelegate:didTapAtIndex:)]){
        [self.delegate PVDelegate:self didTapAtIndex:3];}
}

- (IBAction)jh_next:(id)sender {
}

- (IBAction)address_next:(id)sender {
}

- (IBAction)lxr_next:(id)sender {
}

- (IBAction)lxfs_nex:(id)sender {
}
@end
