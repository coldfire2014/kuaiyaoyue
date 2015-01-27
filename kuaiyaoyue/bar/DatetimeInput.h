//
//  DatetimeInput.h
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/1/27.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatetimeInput : UIWindow
+ (DatetimeInput *)sharedDatetimeInput;
@property (nonatomic,weak) NSString* title;
@property (nonatomic,strong) NSDate* time;
-(void)show;
-(void)setMaxTime:(NSDate*)max andMinTime:(NSDate*)min;
@end
