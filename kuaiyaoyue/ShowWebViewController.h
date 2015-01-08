//
//  ShowWebViewController.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/24.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowWebViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (strong ,nonatomic) NSString *weburl;
@property (strong ,nonatomic) NSString *name;
-(void)initContent:(NSString *)name weburl:(NSString *)weburl;

@end
