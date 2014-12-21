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
#import "StatusBar.h"
#import "myImageView.h"
@import Accounts;
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
        self.windowLevel = UIWindowLevelStatusBar - 1.0;
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1;
        self.hidden = NO;
        CGRect f = [[UIScreen mainScreen] bounds];
        self.frame = f;
        UIView* bg = [[UIView alloc] initWithFrame:f];
        bg.tag = 799;
        bg.alpha = 0.0;
        bg.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.9];
        [self addSubview:bg];
//        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
//        [bg addGestureRecognizer:tap];
//        UIView* wbj = [[UIView alloc] initWithFrame:CGRectMake(0, f.size.height, f.size.width, f.size.height/2.0)];
        myImageView* pyq = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 128.0/2.0, 128.0/2.0) andImageName:@"ic_s_wxpyq@2x" withScale:2.0 andBundleName:@"shareView"];
        pyq.tag = 800;
        [self addSubview:pyq];
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPyq)];
        [pyq addGestureRecognizer:tap];
        
        myImageView* wx = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 128.0/2.0, 128.0/2.0) andImageName:@"ic_s_wx@2x" withScale:2.0 andBundleName:@"shareView"];
        wx.tag = 801;
        [self addSubview:wx];
        UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapWx)];
        [wx addGestureRecognizer:tap2];
        
        myImageView* sina = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 128.0/2.0, 128.0/2.0) andImageName:@"ic_s_wb@2x" withScale:2.0 andBundleName:@"shareView"];
        sina.tag = 802;
        [self addSubview:sina];
        UITapGestureRecognizer* tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapsinaWb)];
        [sina addGestureRecognizer:tap3];
        
        myImageView* txwb = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 128.0/2.0, 128.0/2.0) andImageName:@"ic_s_txwb@2x" withScale:2.0 andBundleName:@"shareView"];
        txwb.tag = 803;
        [self addSubview:txwb];
        UITapGestureRecognizer* tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taptxwb)];
        [txwb addGestureRecognizer:tap4];
        
        myImageView* qq = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 128.0/2.0, 128.0/2.0) andImageName:@"ic_s_qq@2x" withScale:2.0 andBundleName:@"shareView"];
        qq.tag = 804;
        [self addSubview:qq];
        UITapGestureRecognizer* tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapqq)];
        [qq addGestureRecognizer:tap5];
        
        myImageView* sms = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 128.0/2.0, 128.0/2.0) andImageName:@"ic_s_sms@2x" withScale:2.0 andBundleName:@"shareView"];
        sms.tag = 805;
        [self addSubview:sms];
        UITapGestureRecognizer* tap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapsms)];
        [sms addGestureRecognizer:tap6];
        
        myImageView* link = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 128.0/2.0, 128.0/2.0) andImageName:@"ic_s_link@2x" withScale:2.0 andBundleName:@"shareView"];
        link.tag = 806;
        [self addSubview:link];
        UITapGestureRecognizer* tap7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taplink)];
        [link addGestureRecognizer:tap7];
        
        myImageView* mail = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 128.0/2.0, 128.0/2.0) andImageName:@"ic_s_mail@2x" withScale:2.0 andBundleName:@"shareView"];
        mail.tag = 807;
        [self addSubview:mail];
        UITapGestureRecognizer* tap8 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapmail)];
        [mail addGestureRecognizer:tap8];
        
        myImageView* backbtn = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 128.0/2.0, 128.0/2.0) andImageName:@"ic_s_x@2x" withScale:2.0 andBundleName:@"shareView"];
        backbtn.tag = 808;
        [self addSubview:backbtn];
        UITapGestureRecognizer* tap9 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [backbtn addGestureRecognizer:tap9];
        
    }
    return self;
}
-(void)show{
    CGRect f = [[UIScreen mainScreen] bounds];
    self.frame = f;
    UIView* bg = [self viewWithTag:799];
    UIView* backbtn = [self viewWithTag:808];
    backbtn.center = CGPointMake(f.size.width/2.0, f.size.height+128.0/4.0);
    UIView* btn1 = [self viewWithTag:800];
    btn1.center = CGPointMake(f.size.width/2.0, f.size.height+128.0/4.0);
    UIView* btn2 = [self viewWithTag:801];
    btn2.center = CGPointMake(f.size.width/2.0, f.size.height+128.0/4.0);
    UIView* btn3 = [self viewWithTag:802];
    btn3.center = CGPointMake(f.size.width/2.0, f.size.height+128.0/4.0);
    UIView* btn4 = [self viewWithTag:803];
    btn4.center = CGPointMake(f.size.width/2.0, f.size.height+128.0/4.0);
    UIView* btn5 = [self viewWithTag:804];
    btn5.center = CGPointMake(f.size.width/2.0, f.size.height+128.0/4.0);
    UIView* btn6 = [self viewWithTag:805];
    btn6.center = CGPointMake(f.size.width/2.0, f.size.height+128.0/4.0);
    UIView* btn7 = [self viewWithTag:806];
    btn7.center = CGPointMake(f.size.width/2.0, f.size.height+128.0/4.0);
    UIView* btn8 = [self viewWithTag:807];
    btn8.center = CGPointMake(f.size.width/2.0, f.size.height+128.0/4.0);
    backbtn.alpha = 1.0;
    btn1.alpha = 0.0;
    btn2.alpha = 0.0;
    btn3.alpha = 0.0;
    btn4.alpha = 0.0;
    btn5.alpha = 0.0;
    btn6.alpha = 0.0;
    btn7.alpha = 0.0;
    btn8.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        bg.alpha = 1.0;
        
        backbtn.center = CGPointMake(f.size.width/2.0, f.size.height-368.0/2.0 - 128.0/4.0);
        btn1.center = CGPointMake(f.size.width/2.0, f.size.height-368.0/2.0 - 128.0/4.0);
        btn2.center = CGPointMake(f.size.width/2.0, f.size.height-368.0/2.0 - 128.0/4.0);
        btn3.center = CGPointMake(f.size.width/2.0, f.size.height-368.0/2.0 - 128.0/4.0);
        btn4.center = CGPointMake(f.size.width/2.0, f.size.height-368.0/2.0 - 128.0/4.0);
        btn5.center = CGPointMake(f.size.width/2.0, f.size.height-368.0/2.0 - 128.0/4.0);
        btn6.center = CGPointMake(f.size.width/2.0, f.size.height-368.0/2.0 - 128.0/4.0);
        btn7.center = CGPointMake(f.size.width/2.0, f.size.height-368.0/2.0 - 128.0/4.0);
        btn8.center = CGPointMake(f.size.width/2.0, f.size.height-368.0/2.0 - 128.0/4.0);
    }];
    [UIView animateWithDuration:0.5 delay:0.3 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        btn1.center = CGPointMake(f.size.width/2.0-72.0/2.0-128.0/2.0, f.size.height-368.0/2.0 - 128.0/4.0 - 90.0/2.0 - 128.0/2.0);
        btn1.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.5 delay:0.4 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        btn2.center = CGPointMake(f.size.width/2.0, f.size.height-368.0/2.0 - 128.0/4.0 - 90.0/2.0 - 128.0/2.0);
        btn2.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.5 delay:0.5 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        btn3.center = CGPointMake(f.size.width/2.0+72.0/2.0+128.0/2.0, f.size.height-368.0/2.0 - 128.0/4.0 - 90.0/2.0 - 128.0/2.0);
        btn3.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.5 delay:1.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        btn4.center = CGPointMake(f.size.width/2.0-72.0/2.0-128.0/2.0, f.size.height-368.0/2.0 - 128.0/4.0);
        btn4.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.5 delay:0.6 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        btn5.center = CGPointMake(f.size.width/2.0+72.0/2.0+128.0/2.0, f.size.height-368.0/2.0 - 128.0/4.0);
        btn5.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.5 delay:0.9 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        btn6.center = CGPointMake(f.size.width/2.0-72.0/2.0-128.0/2.0, f.size.height-368.0/2.0 - 128.0/4.0 + 90.0/2.0 + 128.0/2.0);
        btn6.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.5 delay:0.8 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        btn7.center = CGPointMake(f.size.width/2.0, f.size.height-368.0/2.0 - 128.0/4.0 + 90.0/2.0 + 128.0/2.0);
        btn7.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.5 delay:0.7 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        btn8.center = CGPointMake(f.size.width/2.0+72.0/2.0+128.0/2.0, f.size.height-368.0/2.0 - 128.0/4.0 + 90.0/2.0 +128.0/2.0);
        btn8.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)hide{
    UIView* bg = [self viewWithTag:799];
    UIView* btn0 = [self viewWithTag:800];
    UIView* btn1 = [self viewWithTag:801];
    UIView* btn2 = [self viewWithTag:802];
    UIView* btn3 = [self viewWithTag:803];
    UIView* btn4 = [self viewWithTag:804];
    UIView* btn5 = [self viewWithTag:805];
    UIView* btn6 = [self viewWithTag:806];
    UIView* btn7 = [self viewWithTag:807];
    UIView* btn8 = [self viewWithTag:808];
    [UIView animateWithDuration:0.3 animations:^{
        bg.alpha = 0.0;
        btn0.alpha = 0.0;
        btn1.alpha = 0.0;
        btn2.alpha = 0.0;
        btn3.alpha = 0.0;
        btn4.alpha = 0.0;
        btn5.alpha = 0.0;
        btn6.alpha = 0.0;
        btn7.alpha = 0.0;
        btn8.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.frame = CGRectZero;
    }];
}
-(void)tapWx{
    [self shareWXWithTitle:self.title andDes:self.msg andURL:self.url andHeadImg:self.img];
}
-(void)tapPyq{
    [self shareWXPYWithTitle:self.title andDes:self.msg andURL:self.url andHeadImg:self.img];
}
-(void)tapsinaWb{
    [self shareSinaWeiboWithTitle:self.title andDes:self.msg andURL:self.url andHeadImg:self.img];
}
-(void)taptxwb{
    [self shareTencentWeiboWithTitle:self.title andDes:self.msg andURL:self.url andHeadImg:self.img];
}
-(void)taplink{
    NSString* msg = [[NSString alloc] initWithFormat:@"%@ %@ %@",self.title,self.msg,self.url];
    [self copyWithMsg:msg];
}
-(void)tapsms{
    NSString* msg = [[NSString alloc] initWithFormat:@"%@ %@ %@",self.title,self.msg,self.url];
    [self shareMsgWithMsg:msg];
}
-(void)tapqq{
    [self shareQQWithTitle:self.title andDes:self.msg andURL:self.url andHeadImg:self.img];
}
-(void)tapmail{
    [self shareMailWithTitle:self.title andDes:self.msg andURL:self.url andHeadImg:self.img];
}

-(void)changeHidden:(BOOL)hide completion:(void (^)(BOOL finished))completion{
    CGRect f = [[UIScreen mainScreen] bounds];
    UIView* bg = [self viewWithTag:799];
    UIView* btn0 = [self viewWithTag:800];
    UIView* btn1 = [self viewWithTag:801];
    UIView* btn2 = [self viewWithTag:802];
    UIView* btn3 = [self viewWithTag:803];
    UIView* btn4 = [self viewWithTag:804];
    UIView* btn5 = [self viewWithTag:805];
    UIView* btn6 = [self viewWithTag:806];
    UIView* btn7 = [self viewWithTag:807];
    UIView* btn8 = [self viewWithTag:808];
    if (hide) {
        [UIView animateWithDuration:0.3 animations:^{
            bg.alpha = 0;
            btn0.alpha = 0.0;
            btn1.alpha = 0.0;
            btn2.alpha = 0.0;
            btn3.alpha = 0.0;
            btn4.alpha = 0.0;
            btn5.alpha = 0.0;
            btn6.alpha = 0.0;
            btn7.alpha = 0.0;
            btn8.alpha = 0.0;
        } completion:completion];
        //        self.hidden = YES;
    } else {
        [self show];
    }
}
-(void)shareMsgWithMsg:(NSString*)msg{
    if( [MFMessageComposeViewController canSendText] ){
        
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init]; //autorelease];
        controller.body = msg;
        controller.messageComposeDelegate = self.fromvc;
        [self changeHidden:YES completion:^(BOOL finished){
            self.frame = CGRectZero;
            [self.fromvc presentViewController:controller animated:YES completion:nil];
        }];
        
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"信息发送"];//修改短信界面标题
    }
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
            self.frame = CGRectZero;
            [self.fromvc presentViewController:socialVC animated:YES completion:nil];
        }];
        
    } else {
        [[StatusBar sharedStatusBar] talkMsg:@"请在手机设置中添加您的腾讯微博账号。" inTime:0.51];
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
            self.frame = CGRectZero;
            [self.fromvc presentViewController:socialVC animated:YES completion:nil];
        }];
        
    } else {
        [[StatusBar sharedStatusBar] talkMsg:@"请在手机设置中添加您的新浪微博账号。" inTime:0.51];
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
    [[StatusBar sharedStatusBar] talkMsg:@"已复制到剪贴板。" inTime:0.51];
}
-(void)shareQQWithTitle:(NSString*)title andDes:(NSString*)des andURL:(NSString*)url andHeadImg:(UIImage*)img{
    [[StatusBar sharedStatusBar] talkMsg:@"暂不支持QQ分享。" inTime:0.51];
}
-(void)shareMailWithTitle:(NSString*)title andDes:(NSString*)des andURL:(NSString*)url andHeadImg:(UIImage*)img{
    if( [MFMailComposeViewController canSendMail] ){
        
        MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
        mailPicker.mailComposeDelegate = self.fromvc;
        
        //设置主题
        [mailPicker setSubject: @"title"];
        NSString *emailBody = [[NSString alloc] initWithFormat:@"%@\n%@",des,url];
        [mailPicker setMessageBody:emailBody isHTML:NO];
        [self changeHidden:YES completion:^(BOOL finished){
            self.frame = CGRectZero;
            [self.fromvc presentViewController:mailPicker animated:YES completion:nil];
        }];
    }
}
@end
