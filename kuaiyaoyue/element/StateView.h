//
//  StateView.h
//  kuaiyaoyue
//
//  Created by wuyangbing on 14/12/9.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ItemState) {
    StateGoing = 0,
    StateGet,
    StateDone,
};

@interface StateView : UIView
{
    UIColor* goingColor;
    UIColor* getColor;
    UIColor* goneColor;
    ItemState nowState;
    CAShapeLayer *racetrack;
}
-(void)setState:(ItemState)state withAll:(NSString*) all andAdd:(NSString*) add;
-(void)setStartTime:(NSDate*)startT EndTime:(NSDate*)endT andGoneTime:(NSDate*)goneT;
-(void)nowGet;
-(void)nowGone;

@end
