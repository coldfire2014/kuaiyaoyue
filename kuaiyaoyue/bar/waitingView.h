//
//  waitingView.h
//  kuaiyaoyue
//
//  Created by wuyangbing on 14/12/19.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface waitingView : UIWindow{
    UIActivityIndicatorView* loading;
}
+ (waitingView *)sharedwaitingView;
- (void)startWait;
- (void)stopWait;
- (void)changeWord:(NSString*)msg;
- (void)waitByMsg:(NSString*)msg haveCancel:(BOOL)cancel;
@end
