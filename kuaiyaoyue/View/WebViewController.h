//
//  WebViewController.h
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/1/10.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MessageUI;
@interface WebViewController : UIViewController<UIWebViewDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>
@property (strong ,nonatomic) UIWebView *webview;
@property (weak ,nonatomic) NSString *weburl;
@property (weak ,nonatomic) NSString *name;
@property (weak ,nonatomic) NSString *viewTitle;
@property (strong ,nonatomic) UIColor *navColor;
@property (strong ,nonatomic) UIColor *navtextColor;
- (void)NavColor:(UIColor *)navColor andtextColor:(UIColor *)textColor;
- (void)NavBtnName:(NSString*)name;
@end
