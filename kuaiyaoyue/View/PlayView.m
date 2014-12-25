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

- (void)awakeFromNib {
    UIView *jd = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 72.0/6.0)];
    jd.backgroundColor = [UIColor whiteColor];
    jd.tag = 900;
    jd.alpha = 0;
    jd.center = CGPointMake(_lyyl_view.bounds.size.width/2.0, (_lyyl_view.bounds.size.height-6)/2.0);
    [_lyyl_view addSubview:jd];
    for (int i = 1; i < 10; i++) {
        UIView *jl = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 72.0/6.0)];
        jl.backgroundColor = [[UIColor alloc] initWithWhite:1 alpha:1.0-0.05*i];
        jl.tag = 900 + i;
        jl.alpha = 0;
        jl.center = CGPointMake(_lyyl_view.bounds.size.width/2.0 + i*4.0, (_lyyl_view.bounds.size.height-6)/2.0);
        [_lyyl_view addSubview:jl];
        UIView *jr = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 72.0/6.0)];
        jr.backgroundColor = [[UIColor alloc] initWithWhite:1 alpha:1.0-0.05*i];
        jr.tag = 800 + i;
        jr.alpha = 0;
        jr.center = CGPointMake(_lyyl_view.bounds.size.width/2.0 - i*4.0, (_lyyl_view.bounds.size.height-6)/2.0);
        [_lyyl_view addSubview:jr];
    }
}

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
