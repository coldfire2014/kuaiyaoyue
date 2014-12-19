//
//  ShareView.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 14/12/19.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "ShareView.h"
#import "WXApi.h"
#import "WXApiObject.h"
@implementation ShareView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (ShareView *)sharedShareView
{
    static ShareView *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[ShareView alloc] initWithFrame:CGRectZero];
    });
    
    return _sharedInstance;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = UIWindowLevelAlert + 1.0;
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1;
        self.hidden = NO;
    }
    return self;
}

-(void)shareTencentWeiboWithTitle:(NSString*)title andDes:(NSString*)des andURL:(NSString*)url andHeadImg:(UIImage*)img{
    // 首先判断服务器是否可以访问
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
        NSLog(@"Available");
        
        // 使用SLServiceTypeSinaWeibo来创建一个新浪微博view Controller
        SLComposeViewController *socialVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTencentWeibo];//
        
        // 写一个bolck，用于completionHandler的初始化
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result) {
            if (result == SLComposeViewControllerResultCancelled) {
                NSLog(@"cancelled");
            } else
            {
                NSLog(@"done");
            }
            [socialVC dismissViewControllerAnimated:YES completion:^(){
                [self changeHidden:NO completion:nil];
            }];
        };
        // 初始化completionHandler，当post结束之后（无论是done还是cancell）该blog都会被调用
        socialVC.completionHandler = myBlock;
        
        // 给view controller初始化默认的图片，url，文字信息

        NSURL *URL = [NSURL URLWithString:url];
        
        [socialVC setInitialText:[[NSString alloc] initWithFormat:@"%@\n%@",title,des]];
        [socialVC addImage:img];
        [socialVC addURL:URL];
        
        // 以模态的方式展现view controller
        [self changeHidden:YES completion:^(BOOL finished){
            [self.fromvc presentViewController:socialVC animated:YES completion:nil];
        }];
        
    } else {
        NSLog(@"UnAvailable");
    }
}
-(void)changeHidden:(BOOL)hide completion:(void (^)(BOOL finished))completion{
    if (hide) {
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 0;
        } completion:completion];
//        self.hidden = YES;
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 1;
        } completion:completion];
//        self.hidden = NO;
    }
}
-(void)shareSinaWeiboWithTitle:(NSString*)title andDes:(NSString*)des andURL:(NSString*)url andHeadImg:(UIImage*)img{
    // 首先判断服务器是否可以访问
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
        NSLog(@"Available");
        
        // 使用SLServiceTypeSinaWeibo来创建一个新浪微博view Controller
        SLComposeViewController *socialVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
        
        // 写一个bolck，用于completionHandler的初始化
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result) {
            if (result == SLComposeViewControllerResultCancelled) {
                NSLog(@"cancelled");
            } else
            {
                NSLog(@"done");
            }
            [socialVC dismissViewControllerAnimated:YES completion:^(){
                [self changeHidden:NO completion:nil];
            }];
        };
        // 初始化completionHandler，当post结束之后（无论是done还是cancell）该blog都会被调用
        socialVC.completionHandler = myBlock;
        
        // 给view controller初始化默认的图片，url，文字信息
        NSURL *URL = [NSURL URLWithString:url];
        
        [socialVC setInitialText:[[NSString alloc] initWithFormat:@"%@\n%@",title,des]];
        [socialVC addImage:img];
        [socialVC addURL:URL];
        
        // 以模态的方式展现view controller
        [self changeHidden:YES completion:^(BOOL finished){
            [self.fromvc presentViewController:socialVC animated:YES completion:nil];
        }];
        
    } else {
        NSLog(@"UnAvailable");
    }
}
-(void)shareWXWithTitle:(NSString*)title andDes:(NSString*)des andURL:(NSString*)url andHeadImg:(UIImage*)img{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = des;
    [message setThumbImage:img];
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = url;
    message.mediaObject = ext;
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
}
-(void)shareWXPYWithTitle:(NSString*)title andDes:(NSString*)des andURL:(NSString*)url andHeadImg:(UIImage*)img{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = des;
    [message setThumbImage:img];
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = url;
    message.mediaObject = ext;
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    [WXApi sendReq:req];
}
-(void)copyWithMsg:(NSString*)msg{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = msg;
}

-(void)shareMsgWithMsg:(NSString*)msg{
    if( [MFMessageComposeViewController canSendText] ){
        
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init]; //autorelease];
        controller.body = msg;
        controller.messageComposeDelegate = self.fromvc;
        [self changeHidden:YES completion:^(BOOL finished){
            [self.fromvc presentViewController:controller animated:YES completion:nil];
        }];
        
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"信息发送"];//修改短信界面标题
    }
}
-(void)shareQQWithTitle:(NSString*)title andDes:(NSString*)des andURL:(NSString*)url andHeadImg:(UIImage*)img{
    
}

@end
