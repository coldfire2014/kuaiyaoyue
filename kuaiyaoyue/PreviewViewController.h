//
//  PreviewViewController.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreviewViewController : UIViewController<UIScrollViewDelegate,UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webview;
@end
