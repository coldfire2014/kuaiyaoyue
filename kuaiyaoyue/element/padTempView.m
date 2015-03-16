//
//  padTempView.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/3/14.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import "padTempView.h"

@implementation padTempView


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
    return bk;
    
}
-(NSInteger)getIndex{
    return currentItemIndex;
}

-(void)btnTap:(UITapGestureRecognizer *)recognizer{
    //    UIView* webbg0 = [self viewWithTag:990 + currentItemIndex];
    //    CGPoint p = [recognizer locationInView:webbg0];
    //    if (p.x>0 && p.y>0) {
    //        if ([_delegate respondsToSelector:@selector(didSelectItemAtIndex:)]) {
    //            [_delegate didSelectItemAtIndex:currentItemIndex];
    //        } else {
    //            NSLog(@"Not respondsToSelector:@selector(didSelectItemAtIndex:)");
    //        }
    //    }
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
        for (int i = 0; i<2; i++) {
            if ([_delegate respondsToSelector:@selector(cellForItemAtIndex:)]) {
                UIView *webbg0 = [_delegate cellForItemAtIndex:i];
                webbg0.tag = 990+i;
//                webbg0.layer.anchorPoint = CGPointMake(1, 0);
                webbg0.center = CGPointMake(bk.bounds.size.width/2.0, bk.bounds.size.height/2.0);
//                webbg0.layer.transform = [self ftransformForItemView:webbg0 withOffset:i];
                [bk addSubview:webbg0];
            } else {
                NSLog(@"Not respondsToSelector:@selector(cellForItemAtIndex:)");
            }
        }
        for (NSInteger i = itemCount - 1; i<itemCount; i++) {
            if(i<4){
                continue;
            }
            if ([_delegate respondsToSelector:@selector(cellForItemAtIndex:)]) {
                UIView *webbg0 = [_delegate cellForItemAtIndex:i];
                webbg0.tag = 990+i;
//                webbg0.layer.anchorPoint = CGPointMake(1, 0);
                webbg0.center = CGPointMake(bk.bounds.size.width/2.0, bk.bounds.size.height/2.0);
//                webbg0.layer.transform = [self ftransformForItemView:webbg0 withOffset:i];
                [bk addSubview:webbg0];
            } else {
                NSLog(@"Not respondsToSelector:@selector(cellForItemAtIndex:)");
            }
        }
    }
}
-(void)loadViewat:(NSInteger)i{
    UIView* bk = [self viewWithTag:101];
    if ([_delegate respondsToSelector:@selector(cellForItemAtIndex:)]) {
        UIView *webbg0 = [_delegate cellForItemAtIndex:i];
        webbg0.tag = 990+i;
        webbg0.center = CGPointMake(bk.bounds.size.width/2.0, bk.bounds.size.height/2.0);
        CGFloat offset = i-currentItemIndex;
        webbg0.layer.transform = [self transformForItemView:webbg0 withOffset:offset];
        [bk addSubview:webbg0];
    } else {
        NSLog(@"Not respondsToSelector:@selector(cellForItemAtIndex:)");
    }
}
-(void)reloadOther{
    //    UIView* bk = [self viewWithTag:101];
    //    for (int i = 3; i<itemCount; i++) {
    //        if ([_delegate respondsToSelector:@selector(cellForItemAtIndex:)]) {
    //            UIView *webbg0 = [_delegate cellForItemAtIndex:i];
    //            webbg0.tag = 990+i;
    //            webbg0.layer.anchorPoint = CGPointMake(1, 0);
    //            webbg0.center = CGPointMake(bk.bounds.size.width/2.0 + self.itemSize.width/2.0, bk.bounds.size.height/2.0 - self.itemSize.height/2.0);
    //            webbg0.layer.transform = [self ftransformForItemView:webbg0 withOffset:i];
    //            [bk addSubview:webbg0];
    //        } else {
    //            NSLog(@"Not respondsToSelector:@selector(cellForItemAtIndex:)");
    //        }
    //    }
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
    //    return [self transformForItemView:view withOffset:offset+3];
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
        //        transform = CATransform3DRotate(transform, -0.032*offset, 0, 0,1);//Translate(transform,0, -_radius * offset/3.6,-offset*100);
        transform = CATransform3DTranslate(transform, 0, 0,-offset);
        return transform;
    }
}
-(CATransform3D)transformForItemView:(UIView *)view withOffset:(CGFloat)offset
{
    CGFloat zIndex = -30;
    perspective = -1.0f/90.0f;//透视
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = perspective;
    CGFloat y = view.bounds.size.height+70;
    if (offset == -1 || offset == itemCount - 1) {
        view.alpha = 0.8;
        transform = CATransform3DTranslate(transform,0, y,zIndex);
        return transform;
    }else if(offset == 1 || offset == 1-itemCount){
        view.alpha = 0.8;
        transform = CATransform3DTranslate(transform,0, -y,zIndex);
        return transform;
    }else if (offset == -2 || offset == itemCount - 2) {
        view.alpha = 0;
        transform = CATransform3DTranslate(transform,0, y*2 ,zIndex*2);
        return transform;
    }else if(offset == 2 || offset == 2-itemCount){
        view.alpha = 0;
        transform = CATransform3DTranslate(transform,0, -y*2,zIndex*2);
        return transform;
    }else if(offset == 0){
        view.alpha = 1;
        return CATransform3DIdentity;
    }else{
        view.alpha = 0;
        return CATransform3DIdentity;
    }
    
}

-(void)btnSwipe:(UISwipeGestureRecognizer *)recognizer{
    BOOL isIn = YES;
    if(recognizer.direction==UISwipeGestureRecognizerDirectionUp || recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        if (currentItemIndex <= 0) {
            currentItemIndex = itemCount - 1l;
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

    [self scrollToItemAtIndex:currentItemIndex animated:YES inOrout:isIn];
    if ([_delegate respondsToSelector:@selector(didShowItemAtIndex:)]) {
        [_delegate didShowItemAtIndex:currentItemIndex];
    } else {
        NSLog(@"Not respondsToSelector:@selector(didShowItemAtIndex:)");
    }
}
-(void)showListAtIndex:(NSInteger)index{
    currentItemIndex = index;
    if ([_delegate respondsToSelector:@selector(didShowItemAtIndex:)]) {
        [_delegate didShowItemAtIndex:currentItemIndex];
    } else {
        NSLog(@"Not respondsToSelector:@selector(didShowItemAtIndex:)");
    }
    [self scrollToItemAtIndex:currentItemIndex animated:YES inOrout:YES];
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
-(void)scrollToItemAtIndex:(NSInteger)index animated:(BOOL)animate inOrout:(BOOL)isIn{
    UIView* contentView = [self viewWithTag:101];
    NSInteger oldIndex = currentItemIndex;
    if (isIn) {
        oldIndex = currentItemIndex-1;
    } else {
        oldIndex = currentItemIndex+1;
    }
    currentItemIndex =  index;
    NSInteger newIndex = currentItemIndex;
    NSInteger rigth = currentItemIndex + 2;
    if (rigth > itemCount) {
        rigth = itemCount;
    }
    NSInteger left = currentItemIndex - 1;
    if (left < 0) {
        left = 0;
    }
    for (NSInteger i = currentItemIndex;i < rigth;i++)
    {
        UIView *view = [contentView viewWithTag:990 + i];
        if (view == nil) {
            currentItemIndex = oldIndex;
            [self loadViewat:i];
            currentItemIndex = newIndex;
        }
    }
    for (NSInteger i = left;i < currentItemIndex;i++)
    {
        UIView *view = [contentView viewWithTag:990 + i];
        if (view == nil) {
            currentItemIndex = oldIndex;
            [self loadViewat:i];
            currentItemIndex = newIndex;
        }
    }
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
