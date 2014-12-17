//
//  ctView.m
//  edittext
//
//  Created by wu yangbing on 14-7-21.
//  Copyright (c) 2014年 wu yangbing. All rights reserved.
//

#import "ctView.h"
@implementation ctView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        numberOfVisibleItems = 4;
    }
    return self;
}
-(UIView*)addbkView{
    UIView* bk = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    bk.backgroundColor = [UIColor clearColor];
    bk.userInteractionEnabled = YES;
    bk.tag = 101;
    [self addSubview:bk];
    _radius = self.frame.size.height * 0.5;
    //        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    //        [bk addGestureRecognizer:panGesture];
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(btnSwipe:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionDown;
    [bk addGestureRecognizer:swipeGesture];
    UISwipeGestureRecognizer *swipe2Gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(btnSwipe:)];
    swipe2Gesture.direction = UISwipeGestureRecognizerDirectionUp;
    [bk addGestureRecognizer:swipe2Gesture];
    
    UISwipeGestureRecognizer *swipe3Gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(btnSwipe:)];
    swipe3Gesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [bk addGestureRecognizer:swipe3Gesture];
    UISwipeGestureRecognizer *swipe4Gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(btnSwipe:)];
    swipe4Gesture.direction = UISwipeGestureRecognizerDirectionRight;
    [bk addGestureRecognizer:swipe4Gesture];
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnTap:)];
    [bk addGestureRecognizer:tapGesture];
    return bk;
}
-(int)getIndex{
    return currentItemIndex;
}

-(void)btnTap:(UITapGestureRecognizer *)recognizer{
    UIView* webbg0 = [self viewWithTag:990 + currentItemIndex];
    CGPoint p = [recognizer locationInView:webbg0];
    if (p.x>0 && p.y>0) {
        if ([_delegate respondsToSelector:@selector(didSelectItemAtIndex:)]) {
            [_delegate didSelectItemAtIndex:currentItemIndex];
        } else {
            NSLog(@"Not respondsToSelector:@selector(didSelectItemAtIndex:)");
        }
    }
}
-(void)reloadViews{
    if ([_delegate respondsToSelector:@selector(numberOfItems)]) {
        itemCount = [_delegate numberOfItems];
        if (itemCount < numberOfVisibleItems) {
            numberOfVisibleItems = itemCount;
        }
    } else {
        NSLog(@"Not respondsToSelector:@selector(numberOfItems)");
    }
    panTotal = 0.0;//-1.0~1.0
    
    UIView* bk = [self viewWithTag:101];
    if (bk != nil) {
        [bk removeFromSuperview];
        bk = [self addbkView];
        for (int i = 0; i<itemCount; i++) {
            if ([_delegate respondsToSelector:@selector(cellForItemAtIndex:)]) {
                UIView *webbg0 = [_delegate cellForItemAtIndex:i];
                webbg0.tag = 990+i;
                webbg0.layer.anchorPoint = CGPointMake(0.5, 1);
                webbg0.center = CGPointMake(webbg0.center.x, bk.bounds.size.height);
//                webbg0.layer.transform = [self transformForItemView:webbg0 withOffset:i-currentItemIndex];
                [bk addSubview:webbg0];
            } else {
                NSLog(@"Not respondsToSelector:@selector(cellForItemAtIndex:)");
            }
        }
    }else{
        bk = [self addbkView];
        for (int i = 0; i<itemCount; i++) {
            if ([_delegate respondsToSelector:@selector(cellForItemAtIndex:)]) {
                UIView *webbg0 = [_delegate cellForItemAtIndex:i];          
                webbg0.tag = 990+i;
                webbg0.layer.anchorPoint = CGPointMake(1, 0);
                webbg0.center = CGPointMake(bk.bounds.size.width/2.0 + self.itemSize.width/2.0, bk.bounds.size.height/2.0 - self.itemSize.height/2.0);
//                webbg0.layer.transform = [self ftransformForItemView:webbg0 withOffset:i];
                [bk addSubview:webbg0];
            } else {
                NSLog(@"Not respondsToSelector:@selector(cellForItemAtIndex:)");
            }
        }
    }
}
-(void)showList{
    currentItemIndex = 0;
    for (int i = 0; i<itemCount; i++) {
        UIView* webbg0 = [self viewWithTag:990+i];
        [UIView animateWithDuration:0.5 animations:^{
            webbg0.layer.transform = [self transformForItemView:webbg0 withOffset:i];
        }];
    }
}
-(CATransform3D)ftransformForItemView:(UIView *)view withOffset:(CGFloat)offset
{
    return [self transformForItemView:view withOffset:offset+3];
}
-(CATransform3D)transformForItemView:(UIView *)view withOffset:(CGFloat)offset
{
    
    perspective = -1.0f/90.0f;//透视
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = perspective;
    if (offset == -1 || offset == itemCount - 1) {
        view.alpha = 0;
        transform = CATransform3DTranslate(transform,-self.frame.size.width*2.0, 0,offset);
        return transform;
    }else{
        if (offset < 0) {
            int a = (int)offset % (int)itemCount;
            offset = itemCount + a;

        }
        if (offset >= numberOfVisibleItems) {
            view.alpha = 0;
        }else{
            view.alpha = 1;
        }
        transform = CATransform3DRotate(transform, -0.025*offset, 0, 0,1);//Translate(transform,0, -_radius * offset/3.6,-offset*100);
        transform = CATransform3DTranslate(transform, 0, 0,-offset);
        return transform;
    }
}

-(void)btnSwipe:(UISwipeGestureRecognizer *)recognizer{
    BOOL isIn = YES;
    if(recognizer.direction==UISwipeGestureRecognizerDirectionUp || recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        if (currentItemIndex <= 0) {
            currentItemIndex = itemCount - 1;
        }else{
            currentItemIndex--;
        }
        isIn = NO;
    }else if(recognizer.direction==UISwipeGestureRecognizerDirectionDown || recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        if (currentItemIndex >= itemCount-1) {
            currentItemIndex = 0;
        }else{
            currentItemIndex++;
        }
    }
    if ([_delegate respondsToSelector:@selector(didShowItemAtIndex:)]) {
        [_delegate didShowItemAtIndex:currentItemIndex];
    } else {
        NSLog(@"Not respondsToSelector:@selector(didShowItemAtIndex:)");
    }
    [self scrollToItemAtIndex:currentItemIndex animated:YES inOrout:isIn];
}
-(void)left{
    if (currentItemIndex >= itemCount-1) {
        currentItemIndex = 0;
    }else{
        currentItemIndex++;
    }
    if ([_delegate respondsToSelector:@selector(didShowItemAtIndex:)]) {
        [_delegate didShowItemAtIndex:currentItemIndex];
    } else {
        NSLog(@"Not respondsToSelector:@selector(didShowItemAtIndex:)");
    }
    
    [self scrollToItemAtIndex:currentItemIndex animated:YES inOrout:YES];
}
-(void)right{
    if (currentItemIndex <= 0) {
        currentItemIndex = itemCount - 1;
    }else{
        currentItemIndex--;
    }
    if ([_delegate respondsToSelector:@selector(didShowItemAtIndex:)]) {
        [_delegate didShowItemAtIndex:currentItemIndex];
    } else {
        NSLog(@"Not respondsToSelector:@selector(didShowItemAtIndex:)");
    }
    
    [self scrollToItemAtIndex:currentItemIndex animated:YES inOrout:NO];
}
-(void)scrollToItemAtIndex:(int)index animated:(BOOL)animate inOrout:(BOOL)isIn{
    UIView* contentView = [self viewWithTag:101];
    if (animate)
    {
        //        isAnimationing = YES;
        [UIView beginAnimations:@"present-countdown" context:nil];
        
        [UIView setAnimationDelegate:self];
        //        [UIView setAnimationDidStopSelector:@selector(tapAnimationStop)];
        if (isIn) {
            [UIView setAnimationDuration:0.55];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        } else {
            [UIView setAnimationDuration:0.40];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        }
        
        for (int i = 0;i < itemCount;i++)
        {
            currentItemIndex =  index;
            UIView *view = [contentView viewWithTag:990 + i];
            CGFloat offset = i-currentItemIndex;
            view.layer.transform = [self transformForItemView:view withOffset:offset];
        }
        [UIView commitAnimations];
    }
    else
    {
        //        isAnimationing = NO;
        for (int i = 0;i < itemCount;i++)
        {
            currentItemIndex =  index;
            UIView *view = [contentView viewWithTag:990 + i];
            CGFloat offset = i-currentItemIndex;
            view.layer.transform = [self transformForItemView:view withOffset:offset];
        }
    }
}
@end
