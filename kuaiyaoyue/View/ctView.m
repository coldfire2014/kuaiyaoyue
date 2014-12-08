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
        currentItemIndex = 0;
    }
    return self;
}
-(UIView*)addbkView{
    NSLog(@"%f-%f",self.bounds.size.width,self.bounds.size.height);
    UIView* bk = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    bk.backgroundColor = [UIColor clearColor];
    bk.userInteractionEnabled = YES;
    bk.tag = 101;
    [self addSubview:bk];
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(btnSwipe:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [bk addGestureRecognizer:swipeGesture];
    UISwipeGestureRecognizer *swipe2Gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(btnSwipe:)];
    swipe2Gesture.direction = UISwipeGestureRecognizerDirectionRight;
    [bk addGestureRecognizer:swipe2Gesture];
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnTap:)];
    [bk addGestureRecognizer:tapGesture];
//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
//    [bk addGestureRecognizer:panGesture];
//    [panGesture requireGestureRecognizerToFail:swipe2Gesture];
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
//                webbg0.layer.anchorPoint = CGPointMake(0.5, 3.6);
                //webbg0.layer.shouldRasterize = YES;
//                webbg0.center = CGPointMake(bk.bounds.size.width/2.0, (bk.bounds.size.height-80.0)*3.6);
                webbg0.center = CGPointMake(bk.bounds.size.width/2.0, (bk.bounds.size.height)/2.0);
                webbg0.layer.transform = [self transformForItemView:webbg0 withOffset:i-currentItemIndex];
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
//                webbg0.layer.anchorPoint = CGPointMake(0.5, 3.6);
//                webbg0.layer.shouldRasterize = YES;
//                webbg0.center = CGPointMake(bk.bounds.size.width/2.0, (bk.bounds.size.height-80.0)*3.6);
                webbg0.center = CGPointMake(bk.bounds.size.width/2.0, (bk.bounds.size.height)/2.0);
                webbg0.layer.transform = [self ftransformForItemView:webbg0 withOffset:i];
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
        [UIView animateWithDuration:0.4 animations:^{
            webbg0.layer.transform = [self transformForItemView:webbg0 withOffset:i];
        }];
    }
}
-(CATransform3D)ftransformForItemView:(UIView *)view withOffset:(CGFloat)offset
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = perspective;
    view.alpha = 0;
    transform = CATransform3DTranslate(transform,0, 0,-200);
    return transform;
}
-(CATransform3D)transformForItemView:(UIView *)view withOffset:(CGFloat)offsetin
{
    yt = 0;
    _radius = self.frame.size.height * 1.7;
    perspective = -1.0f/900.0f;//透视
//    CGFloat arc = M_PI / 2.0f*3.0f;
    CGFloat arc = M_PI / 9.0f;
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = perspective;
    CGFloat offset = -2;
    if (offsetin == 0) {
        offset = 0;
    } else if (offsetin == 1 || (offsetin == -itemCount+1)){
        offset = 1;
    } else if (offsetin == -1 || (offsetin == itemCount-1)){
        offset = -1;
    }
    if (panTotal<0 && offset == -2) {
        offset = 2;
    }
    if (panTotal<0.001 && panTotal>-0.001) {
        panTotal = 0;
    }
    CGFloat angle = (offset + panTotal) * arc;

    if (offset == 0) {
        view.alpha = 1;
    }else if(offset == 1 || offset == -1){
        view.alpha = 1;
    }
    else{
        view.alpha = 0;
    }
//    transform = CATransform3DRotate(transform, angle, 0, 1, 0);
    transform = CATransform3DRotate(transform, angle, 0, 1, 0);
    transform = CATransform3DTranslate(transform,_radius*sinf(angle), 0,_radius*(cosf(angle)-1));
    return transform;
}
- (void)didPan:(UIPanGestureRecognizer *)panGesture
{
    UIView* contentView = [self viewWithTag:101];
    switch (panGesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            previousTranslation = [panGesture translationInView:contentView];
            firstTranslation = [panGesture translationInView:contentView];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            float total =  panTotal;
            if (total<0) {
                total = -total;
            }
            
            if (total>0.14) {
                if (panTotal < 0) {
                    currentItemIndex ++ ;
                    if (currentItemIndex>=itemCount) {
                        currentItemIndex = 0;
                    }
                }else{
                    currentItemIndex -- ;
                    if (currentItemIndex<0) {
                        currentItemIndex = itemCount-1;
                    }
                }
            }else{
                
            }
            if (panTotal>0) {
                panTotal = 0.0005;
            } else {
                panTotal = -0.0005;
            }
            
            if ([_delegate respondsToSelector:@selector(didShowItemAtIndex:)]) {
                [_delegate didShowItemAtIndex:currentItemIndex];
            } else {
                NSLog(@"Not respondsToSelector:@selector(didShowItemAtIndex:)");
            }

            [self scrollToItemAtIndex:currentItemIndex animated:YES];
            break;
        }
        default:
        {
            yt += [panGesture translationInView:contentView].y - previousTranslation.y;
            CGFloat translation = [panGesture translationInView:contentView].x - previousTranslation.x;
            panTotal += translation/self.bounds.size.width;//translation/itemHeight;
            
            [self scrollToItemAtIndex:currentItemIndex animated:NO];
            previousTranslation = [panGesture translationInView:contentView];
        }
    }
}
-(void)btnSwipe:(UISwipeGestureRecognizer *)recognizer{
    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        if (currentItemIndex <= 0) {
            currentItemIndex = itemCount - 1;
        }else{
            currentItemIndex--;
        }
    }else if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
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

    [self scrollToItemAtIndex:currentItemIndex animated:YES];
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
    
    [self scrollToItemAtIndex:currentItemIndex animated:YES];
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
    
    [self scrollToItemAtIndex:currentItemIndex animated:YES];
}
-(void)scrollToItemAtIndex:(int)index animated:(BOOL)animate{
    UIView* contentView = [self viewWithTag:101];
    if (animate)
    {
        currentItemIndex =  index;
        for (int i = 0;i < itemCount;i++) {
            CGFloat offsetin = i-currentItemIndex;
            BOOL not = YES;
            if (offsetin == 0) {
                not = NO;
            } else if (offsetin == 1 || (offsetin == -itemCount+1)){
                not = NO;
            } else if (offsetin == -1 || (offsetin == itemCount-1)){
                not = NO;
            }
            if (not) {
                UIView *view = [contentView viewWithTag:990 + i];
                view.layer.transform = [self transformForItemView:view withOffset:offsetin];
            }
        }

        //        isAnimationing = YES;
        [UIView beginAnimations:@"present-countdown" context:nil];
        [UIView setAnimationDuration:0.45];
        [UIView setAnimationDelegate:self];
        //        [UIView setAnimationDidStopSelector:@selector(tapAnimationStop)];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
        for (int i = 0;i < itemCount;i++) {
            CGFloat offsetin = i-currentItemIndex;
            BOOL need = NO;
            if (offsetin == 0) {
                need = YES;
            } else if (offsetin == 1 || (offsetin == -itemCount+1)){
                need = YES;
            } else if (offsetin == -1 || (offsetin == itemCount-1)){
                need = YES;
            }
            if (need) {
                UIView *view = [contentView viewWithTag:990 + i];
                view.layer.transform = [self transformForItemView:view withOffset:offsetin];
            }
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
