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
#import <MessageUI/MFMailComposeViewController.h>
@interface ShareView : UIWindow
+ (ShareView *)sharedShareView;
@property (nonatomic,weak) UIViewController<MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>* fromvc;
@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) NSString* msg;
@property (nonatomic,strong) NSString* url;
@property (nonatomic,strong) UIImage* img;
@property (nonatomic,strong) NSString* imgUrl;

-(void)shareSinaWeiboWithTitle:(NSString*)title andDes:(NSString*)des andURL:(NSString*)url andHeadImg:(UIImage*)img;
-(void)shareTencentWeiboWithTitle:(NSString*)title andDes:(NSString*)des andURL:(NSString*)url andHeadImg:(UIImage*)img;
-(void)shareQQWithTitle:(NSString*)title andDes:(NSString*)des andURL:(NSString*)url andHeadImg:(NSString*)img;
-(void)shareQQZoneWithTitle:(NSString*)title andDes:(NSString*)des andURL:(NSString*)url andHeadImg:(NSString*)img;
-(void)shareWXWithTitle:(NSString*)title andDes:(NSString*)des andURL:(NSString*)url andHeadImg:(UIImage*)img;
-(void)shareWXPYWithTitle:(NSString*)title andDes:(NSString*)des andURL:(NSString*)url andHeadImg:(UIImage*)img;
-(void)shareMsgWithMsg:(NSString*)msg;
-(void)copyWithMsg:(NSString*)msg;

-(void)show;
@end
