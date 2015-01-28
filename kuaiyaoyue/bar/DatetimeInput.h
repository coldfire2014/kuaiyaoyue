//
//  DatetimeInput.h
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/1/27.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol datetimeInputDelegate <NSObject>
-(BOOL)didSelectDateTime:(NSTimeInterval)time;
@end
@interface DatetimeInput : UIWindow
+ (DatetimeInput *)sharedDatetimeInput;
@property (nonatomic,weak) NSString* title;
@property (nonatomic,weak) id<datetimeInputDelegate> time_delegate;
@property (nonatomic,strong) NSDate* time;
-(void)show;
-(void)setTime:(NSDate*)ntime andMaxTime:(NSDate*)max andMinTime:(NSDate*)min;
@end
