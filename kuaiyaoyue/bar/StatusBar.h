//
//  StatusBar.h
//  SpeciallyEffect
//
//  Created by wuyangbing on 14/12/7.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusBar : UIWindow
{
    UILabel* msg1;
    UILabel* msg2;
    UIView* bk;
}
+ (StatusBar *)sharedStatusBar;
- (void)talkMsg:(NSString*)msg inTime:(double)time;
@end
