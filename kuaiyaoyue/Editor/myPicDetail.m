//
//  myPicDetail.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/3/8.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import "myPicDetail.h"
#import "UIImageView+LBBlurredImage.h"

@implementation myPicDetail
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tag = 800;
        self.userInteractionEnabled = YES;
        UISwipeGestureRecognizer *swipe3Gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(btnSwipe:)];
        swipe3Gesture.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:swipe3Gesture];
        UISwipeGestureRecognizer *swipe4Gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(btnSwipe:)];
        swipe4Gesture.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:swipe4Gesture];
        
        CAGradientLayer* layer = [CAGradientLayer layer];
        CGRect f = self.bounds;
        layer.frame = f;
        layer.colors = [[NSArray alloc] initWithObjects:
                        (id)[[UIColor alloc] initWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1.0].CGColor,
                        (id)[[UIColor alloc] initWithRed:214.0/255.0 green:214.0/255.0 blue:214.0/255.0 alpha:1.0].CGColor, nil];
        layer.locations = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:1.0], nil];
        layer.opacity = 0.95;
        [self.layer addSublayer:layer];

        maxRect = CGRectInset(self.bounds,8.0,8.0*frame.size.height/frame.size.width);
        UIImageView* bk = [[UIImageView alloc] initWithFrame:frame];
        bk.tag = 101;
        [self addSubview:bk];
        
//        UIView* bkmark = [[UIView alloc] initWithFrame:frame];
//        bkmark.backgroundColor = [UIColor colorWithWhite:0.05 alpha:0.6];
//        [bk addSubview:bkmark];
     
        bkView = [[UIImageView alloc] initWithFrame:maxRect];
        bkView.backgroundColor = [UIColor blackColor];
        [self addSubview:bkView];
        bkView.alpha = 0;
        picView = [[UIImageView alloc] initWithFrame:maxRect];
        picView.backgroundColor = [UIColor blackColor];
        [self addSubview:picView];
        self.alpha = 0;
    }
    return self;
}
-(void)drowImg:(UIImage*)img toView:(UIImageView*)view{
    CGFloat img_w = img.size.width;
    CGFloat img_h = img.size.height;
    if (img_w/img_h > maxRect.size.width/maxRect.size.height) {
        view.frame = CGRectMake(0, 0, maxRect.size.width, img_h/img_w*maxRect.size.width);
        view.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
        view.image = img;
//        if (view == picView) {
//            UIImageView* bk = (UIImageView*)[self viewWithTag:101];
//            [bk setImageToBlur:img blurRadius:60.0 completionBlock:^(NSError *error) {}];
//        }
    } else {//正常
        view.frame = CGRectMake(0, 0, img_w/img_h*maxRect.size.height, maxRect.size.height);
        view.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
        view.image = img;
        if (view == picView) {
            UIImageView* bk = (UIImageView*)[self viewWithTag:101];
            bk.image = nil;
        }
    }
}
-(void) setDetail:(NSInteger)tag withImg:(UIImage*)img{
    imgTag = tag;
    [self drowImg:img toView:picView];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    }];
}
-(void)btnSwipe:(UISwipeGestureRecognizer *)recognizer{
    BOOL isLeft = YES;
    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        isLeft = YES;
    }else if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        isLeft = NO;
    }
    if ([_delegate respondsToSelector:@selector(showNextPic:withLeft:)]) {
        NSInteger tag = [_delegate showNextPic:imgTag withLeft:isLeft];
        if (tag > 0) {
            imgTag = tag;
            [self drowImg:picView.image toView:bkView];
            bkView.alpha = 1;
            picView.alpha = 0;
            [self drowImg:[_delegate getPic:tag] toView:picView];
            [UIView animateWithDuration:0.4 animations:^{
                bkView.alpha = 0;
                picView.alpha = 1;
            }];
        }
        
    } else {
        NSLog(@"Not respondsToSelector:@selector(showNextPic:)");
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
