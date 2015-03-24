//
//  waitingView.h
//  kuaiyaoyue
//
//  Created by wuyangbing on 14/12/19.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ERR_TIME 0.6
#define LONG_TIME 1.0
#define WAITING_TIME 0.7
#define TURN_TIME 0.6
@interface waitingView : UIWindow{
//    UIImageView* loading;
    UIActivityIndicatorView* loading;
}
+ (waitingView *)sharedwaitingView;
- (void)startWait;
- (void)stopWait;
- (void)changeWord:(NSString*)msg;
- (void)WarningByMsg:(NSString*)msg haveCancel:(BOOL)cancel;
//- (void)doneByMsg:(NSString*)msg haveCancel:(BOOL)cancel;
- (void)WarningByMsg:(NSString*)msg haveCancel:(BOOL)cancel inTime:(double)time;
//- (void)doneByMsg:(NSString*)msg haveCancel:(BOOL)cancel inTime:(double)time;
- (void)waitByMsg:(NSString*)msg haveCancel:(BOOL)cancel;
@end
