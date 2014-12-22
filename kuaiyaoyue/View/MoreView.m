//
//  MoreView.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/22.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "MoreView.h"

@implementation MoreView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)music_onclick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(MVDelegate:didTapAtIndex:)]){
        [self.delegate MVDelegate:self didTapAtIndex:2];}
}

- (IBAction)jh_next:(id)sender {
    
}

- (IBAction)time_onclick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(MVDelegate:didTapAtIndex:)]){
        [self.delegate MVDelegate:self didTapAtIndex:0];}
}

- (IBAction)bmtime_onclick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(MVDelegate:didTapAtIndex:)]){
        [self.delegate MVDelegate:self didTapAtIndex:1];}
}

- (IBAction)address_next:(id)sender {
    
}
- (IBAction)xlr_next:(id)sender {
    
}
- (IBAction)xlfs_next:(id)sender {
    
}
@end
