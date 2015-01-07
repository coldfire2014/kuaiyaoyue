//
//  UIPhoneWindow.h
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/1/7.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPhoneWindow : UIWindow{
    UIWebView *phoneCallWebView;
}
+ (UIPhoneWindow *)sharedwaitingView;
//- (void)hide;
- (void)callPhone:(NSString*)num andBK:(UIImage*)bk;
@end
