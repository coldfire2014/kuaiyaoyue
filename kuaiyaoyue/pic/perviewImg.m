//
//  perviewImg.m
//  SpeciallyEffect
//
//  Created by wuyangbing on 14/12/7.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

#import "perviewImg.h"

@implementation perviewImg

- (instancetype)initWithFrame:(CGRect)frame andInitframe:(CGRect)initframe andAsset:(ALAsset*)asset
{
    self = [super initWithFrame:frame];
    if (self) {
        assert = ASSETHELPER;
        zframe = initframe;
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1.0;
        self.clipsToBounds = YES;
        UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didbig)];
        [self addGestureRecognizer:tap2];
        UIImage* img = [assert getImageFromAsset:asset type:ASSET_PHOTO_SCREEN_SIZE];
        CGFloat iwidth = img.size.width;
        CGFloat iheight = img.size.height;
        UIView* bkd = [[UIView alloc] initWithFrame:frame];
        bkd.backgroundColor = [UIColor blackColor];
        bkd.alpha = 0.0;
        bkd.tag = 204;
        [self addSubview:bkd];
        UIView* bk = [[UIView alloc] initWithFrame:initframe];
        bk.tag = 205;
        bk.clipsToBounds = YES;
        bk.userInteractionEnabled = NO;
        [self addSubview:bk];
        UIImageView* imageView = [[UIImageView alloc] initWithImage:img];
        imageView.tag = 206;
        if (iwidth > iheight) {
            CGFloat h = initframe.size.height;
            CGFloat w = iwidth / iheight * h;
            smallSize = CGSizeMake(w, h);
            imageView.frame = CGRectMake(-(w-initframe.size.width)/2.0, 0, w, h);
        }else{
            CGFloat w = initframe.size.width;
            CGFloat h = iheight / iwidth * w;
            smallSize = CGSizeMake(w, h);
            imageView.frame = CGRectMake(0, -(h-initframe.size.height)/2.0, w, h);
        }
        if ((frame.size.height / frame.size.width) < (iheight / iwidth)) {
            CGFloat h = frame.size.height;
            CGFloat w = iwidth / iheight * h;
            bigSize = CGSizeMake(w, h);
        }else{
            CGFloat w = frame.size.width;
            CGFloat h = iheight / iwidth * w;
            bigSize = CGSizeMake(w, h);
        }
        [bk addSubview:imageView];
        UIPinchGestureRecognizer* pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(didPinch:)];
        [bkd addGestureRecognizer:pinch];
        UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
        [bkd addGestureRecognizer:pan];
        [self goCenter];
    }
    return self;
}
-(void)didPinch:(UIPinchGestureRecognizer*)g{
    UIView* bk = [self viewWithTag:205];
    UIView* img = [bk viewWithTag:206];
    CGFloat ts;
    switch (g.state) {
        case UIGestureRecognizerStateBegan:
            t = img.layer.transform;
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        ts = img.layer.transform.m11;
            if (ts < 1.0) {
                [self didbig];
            } else if (ts > 2.0) {
                CATransform3D it = img.layer.transform;
                it.m11 = 2.0;
                it.m22 = 2.0;
                img.layer.transform = it;
            }
            break;
        default:
            img.layer.transform = CATransform3DScale(t, g.scale, g.scale, 1.0);
            break;
    }
}
-(void)didPan:(UIPanGestureRecognizer*)g{
    UIView* bkd = [self viewWithTag:204];
    UIView* bk = [self viewWithTag:205];
    UIView* img = [bk viewWithTag:206];
    switch (g.state) {
        case UIGestureRecognizerStateBegan:
            firstTranslation = [g translationInView:bkd];
            previousTranslation = [g translationInView:bkd];
            t = img.layer.transform;
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            t = img.layer.transform;
            break;
        default:
        {
            CGPoint tmp = [g translationInView:bkd];
            CGFloat yt = tmp.y - previousTranslation.y;
            CGFloat xt = tmp.x - previousTranslation.x;
            CGPoint cp = CGPointMake((img.frame.origin.x + img.frame.size.width)/2.0 + xt, (img.frame.origin.y+img.frame.size.height)/2.0 + yt);
            if (0 > cp.x || bkd.frame.size.width < cp.x) {
                tmp.x = previousTranslation.x;
            }
            if (0 > cp.y || bkd.frame.size.height < cp.y) {
                tmp.y = previousTranslation.y;
            }
            yt = tmp.y - previousTranslation.y;
            xt = tmp.x - previousTranslation.x;
            img.layer.transform = CATransform3DTranslate(img.layer.transform, xt, yt, 0);
            previousTranslation = tmp;
        }
            break;
    }
}
-(void)goCenter{
    UIView* bkd = [self viewWithTag:204];
    UIView* bk = [self viewWithTag:205];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        bkd.alpha = 1;
        bk.center = self.center;
    } completion:^(BOOL finished) {
        bk.clipsToBounds = false;
        [self goBig];
    }];
}
-(void)goBig{
    UIView* bk = [self viewWithTag:205];
    bk.bounds = CGRectMake(0, 0, bigSize.width, bigSize.height);
    UIView* img = [bk viewWithTag:206];
    img.center = CGPointMake(bigSize.width/2.0, bigSize.height/2.0);
    img.bounds = CGRectMake(0, 0, bigSize.width, bigSize.height);
    //markwyb隐藏NavBar
    CGFloat d = smallSize.height / bigSize.height;
    if (smallSize.width > smallSize.height) {
        d = smallSize.width / bigSize.width;
    }
    img.layer.transform = CATransform3DMakeScale(d, d, 1);
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        img.layer.transform = CATransform3DIdentity;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)didbig{
    self.userInteractionEnabled = NO;
    //markwyb显示NavBar
    UIView* bk = [self viewWithTag:205];
    UIView* img = [bk viewWithTag:206];
    CGFloat d = smallSize.height / bigSize.height;
    if (smallSize.width > smallSize.height) {
        d = smallSize.width / bigSize.width;
    }
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        img.layer.transform = CATransform3DMakeScale(d,d,1.0);
    } completion:^(BOOL finished) {
        bk.clipsToBounds = YES;
        bk.bounds = CGRectMake(0, 0, zframe.size.width, zframe.size.height);
        img.center = CGPointMake(zframe.size.width/2.0, zframe.size.height/2.0);
        [self goSmall];
        self.userInteractionEnabled = YES;
    }];
}
-(void)goSmall{
    UIView* bkd = [self viewWithTag:204];
    UIView* bk = [self viewWithTag:205];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        bkd.alpha = 0;
        bk.frame = zframe;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
