//
//  ShareView.h
//  kuaiyaoyue
//
//  Created by wuyangbing on 14/12/19.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

@import Social;
@import UIKit;
@import MessageUI;
@interface ShareView : UIWindow
+ (ShareView *)sharedShareView;
@property (nonatomic,weak) UIViewController<MFMessageComposeViewControllerDelegate>* fromvc;
-(void)shareSinaWeiboWithTitle:(NSString*)title andDes:(NSString*)des andURL:(NSString*)url andHeadImg:(UIImage*)img;
-(void)shareTencentWeiboWithTitle:(NSString*)title andDes:(NSString*)des andURL:(NSString*)url andHeadImg:(UIImage*)img;
-(void)shareQQWithTitle:(NSString*)title andDes:(NSString*)des andURL:(NSString*)url andHeadImg:(UIImage*)img;
-(void)shareWXWithTitle:(NSString*)title andDes:(NSString*)des andURL:(NSString*)url andHeadImg:(UIImage*)img;
-(void)shareWXPYWithTitle:(NSString*)title andDes:(NSString*)des andURL:(NSString*)url andHeadImg:(UIImage*)img;
-(void)shareMsgWithTitle:(NSString*)msg;
@end
