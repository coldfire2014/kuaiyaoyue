//
//  ImgCollectionViewCell.m
//  SpeciallyEffect
//
//  Created by wuyangbing on 14/12/7.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

#import "ImgCollectionViewCell.h"
#import "perviewImg.h"
#import "StatusBar.h"
@implementation ImgCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        UIImageView* img = [[UIImageView alloc] initWithFrame:self.bounds];
        img.tag = 202;
        [self addSubview:img];
        CGFloat w = frame.size.height / 4.0;
        UIView *btn = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w*2.0, w*2.0)];
        btn.backgroundColor = [[UIColor alloc] initWithWhite:0.5 alpha:0.0];
        btn.center = CGPointMake(3.0*w, w);
        UIView* bg = [[UIView alloc] initWithFrame: CGRectMake(w*0.7, w*0.3,  w,  w)];
        bg.backgroundColor = [[UIColor alloc] initWithWhite:0.5 alpha:0.5];
        bg.layer.cornerRadius = (w/2.0);
        [btn addSubview:bg];
        UIView* wc = [[UIView alloc] initWithFrame: CGRectMake(1.0,  1.0,  w-2.0,  w-2.0)];
        wc.layer.borderWidth = 1.0;
        wc.layer.cornerRadius = (w-2.0)/2.0;
        wc.layer.borderColor = [[UIColor alloc] initWithWhite:1.0 alpha:1.0].CGColor;
        [bg addSubview:wc];
        UIView *gc = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, w)];
        gc.layer.cornerRadius = w/2.0;
        gc.backgroundColor = [[UIColor alloc] initWithRed:54.0/255.0 green: 215.0/255.0 blue: 79.0/255.0 alpha: 1.0 ];
        gc.tag = 203;
        gc.hidden = true;
        [bg addSubview:gc];
        UIView *gx = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w/4.0, 2.0)];
        gx.backgroundColor = [[UIColor alloc] initWithWhite:1.0 alpha:1.0];
        gx.center = CGPointMake(0.5*w + 0.5, 0.5*w - 0.5);
        gx.layer.transform = CATransform3DTranslate(gx.layer.transform, -w/4.0, 1.0, 0);
        gx.layer.transform = CATransform3DRotate(gx.layer.transform, M_PI_2, 0, 0, 1);
        [bg addSubview:gx];

        UIView *gs = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w/1.7 - 2.0, 2.0)];
        gs.backgroundColor = [[UIColor alloc] initWithWhite:1.0 alpha:1.0];
        gs.center = CGPointMake(0.5*w + 0.7, 0.5*w - 0.5);
        gs.layer.transform = CATransform3DTranslate(gs.layer.transform, 0.0, w/8.0, 0);
        [bg addSubview:gs];
        
        bg.layer.transform = CATransform3DRotate(bg.layer.transform, -M_PI_4, 0, 0, 1);
        btn.tag=201;
        [self addSubview:btn];
        UITapGestureRecognizer* panGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didtap)];
        [btn addGestureRecognizer:panGesture ];
        UITapGestureRecognizer* pan2Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didprev:)];
        [self addGestureRecognizer:pan2Gesture];
    }
    return self;
}
-(void) didprev:(UITapGestureRecognizer*)t{
    CGPoint p = [t locationInView:self];
    CGPoint pc = [t locationInView:self.superview.superview];
    CGRect r = CGRectMake(self.frame.origin.x, (pc.y-p.y), self.frame.size.width, self.frame.size.height);
    perviewImg* img = [[perviewImg alloc] initWithFrame:[UIScreen mainScreen].bounds andInitframe:r andAsset:self.asset];
    [self.window addSubview:img];
}
-(void) checkSelect{//考虑被调用地点，目前不合适（有已选项目时）
    UIView* gc = [self viewWithTag:203];
    gc.hidden = YES;
    UICollectionView* cv = (UICollectionView*)self.superview;
    NSArray* ips = [cv indexPathsForSelectedItems];
    if (ips) {
        if ([ips containsObject:self.index]) {
            gc.hidden = NO;
        }
    }
}
-(void) setSelect{
    UIView* gc = [self viewWithTag:203];
    gc.hidden = NO;
}
-(void) didtap{
    UIView* btn = [self viewWithTag:201];
    UIView* gc = [btn viewWithTag:203];
    UICollectionView* cv = (UICollectionView*)self.superview;
    if (gc.hidden) {
        NSArray* ips = [cv indexPathsForSelectedItems];
        if (ips.count < self.maxCount) {
            [cv selectItemAtIndexPath:self.index animated:YES scrollPosition:UICollectionViewScrollPositionNone];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_ADD_ID" object:self.index];
            gc.hidden = !gc.hidden;
            CATransform3D t = CATransform3DIdentity;
            CAKeyframeAnimation* moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            moveAnim.values = [[NSArray alloc] initWithObjects:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3,1.3,1.0)],
                               [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9,0.9,1.0)],
                               [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.04,1.04,1.0)],
                               [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.99,0.99,1.0)],
                               [NSValue valueWithCATransform3D:t],
                               nil];
            moveAnim.removedOnCompletion = YES;
            moveAnim.duration = 0.5;
            moveAnim.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
            moveAnim.removedOnCompletion = YES;
            moveAnim.fillMode = kCAFillModeForwards;
            [btn.layer addAnimation:moveAnim forKey:@"s"];
            NSNumber* count = [NSNumber numberWithInteger:[cv indexPathsForSelectedItems].count];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_SET_BADGE" object:count];
        }else{
            NSString* msg = [[NSString alloc] initWithFormat:@"最多只能选%d张哦 !",self.maxCount ];
            [[StatusBar sharedStatusBar] talkMsg:msg inTime:1];
        }
    }else{
        [cv deselectItemAtIndexPath:self.index animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_REMOVE_ID" object:self.index];
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            gc.alpha = 0;
        } completion:^(BOOL finished) {
            gc.hidden = !gc.hidden;
            gc.alpha = 1;
            NSNumber* count = [NSNumber numberWithInteger:[cv indexPathsForSelectedItems].count];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_SET_BADGE" object:count];
        }];
    }
}
@end
