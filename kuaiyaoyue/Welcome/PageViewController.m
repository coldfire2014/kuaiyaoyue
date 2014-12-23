//
//  PageViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "PageViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "WXApi.h"
#import "coverAnimation.h"
#import "HttpManage.h"
#import "UDObject.h"
#import "SVProgressHUD.h"
#import "DataBaseManage.h"
#import "UDObject.h"
#import "StatusBar.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.dataSource = self;
    
    UIViewController* start = [self viewControllerAtIndex:0];
    NSArray* arr = [[NSArray alloc] initWithObjects:start, nil];
    [self setViewControllers:arr direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login) name:@"MSG_LOGIN" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ptlogin) name:@"MSG_PTLOGIN" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(sdwx:)
                                                 name: @"MSG_SDWX"
                                               object: nil];
}
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_LOGIN" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_SDWX" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_PTLOGIN" object:nil];
}

-(void)login{
//    [self performSegueWithIdentifier:@"wel2main" sender:nil];
    SendAuthReq* req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"com.nef" ;
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}

-(void)ptlogin{
    [SVProgressHUD showWithStatus:@"" maskType:SVProgressHUDMaskTypeBlack];
    [self j_spring_security_check:@"12345678" password:@"1234567"];
}


-(void)sdwx :(NSNotification*)notification{
    
    NSDictionary *dictionary = [notification userInfo];
    NSString *name = [dictionary objectForKey:@"nickname"];
    NSString *opneid = [dictionary objectForKey:@"openid"];
    [SVProgressHUD show];
    [HttpManage registers:name userPwd:@"123456" phoneId:[UDObject getTSID] openId:opneid cb:^(BOOL isOK, NSDictionary *dic) {
        [SVProgressHUD dismiss];
        if (isOK) {
            [UDObject setUserInfo:name userName:name token:[dic objectForKey:@"token"]];
             [self performSegueWithIdentifier:@"wel2main" sender:nil];
        }else{
            [[StatusBar sharedStatusBar] talkMsg:@"登陆失败了，再试一次吧。" inTime:0.5];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIViewController *)viewControllerAtIndex:(NSInteger) index{
    if ((index < 0) || (index >= 4)) {
        return nil;
    }
    UIViewController *dataViewController = nil;
    if (index == 0) {
        dataViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"OneViewController"];
    } else if (1 == index) {
        dataViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TwoViewController"];
    } else if (2 == index) {
        dataViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ThreeViewController"];
    } else if (3 == index) {
        dataViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FourViewController"];
    } else {
        return nil;
    }
    // Create a new view controller and pass suitable data.
    return dataViewController;
}

-(NSInteger)indexOfViewController:(UIViewController *)viewController{
    NSString *str = [viewController.classForCoder description];
    if ([str isEqualToString:@"OneViewController"]) {
        return 0;
    } else if ([str isEqualToString:@"TwoViewController"]) {
        return 1;
    } else if ([str isEqualToString:@"ThreeViewController"]) {
        return 2;
    } else if ([str isEqualToString:@"FourViewController"]) {
        return 3;
    } else {
        return NSNotFound;
    }

}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [self indexOfViewController:viewController];
    if ((index == 0) || (index == -1)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];

}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [self indexOfViewController:viewController];
    if (index == -1) {
        return nil;
    }
    
    index++;
    return [self viewControllerAtIndex:index];
}

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation{
    NSArray *viewControllers = self.viewControllers[0];
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    self.doubleSided = false;
    return UIPageViewControllerSpineLocationMin;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
//    NSRange r = [[dismissed.classForCoder description] rangeOfString:@"createViewController"];
    coverAnimation* ca = [[coverAnimation alloc] initWithPresent:NO];
    return ca;
}
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
//    NSString* name = [presented.classForCoder description];
//    NSRange r = [name rangeOfString:@"createViewController"];
    coverAnimation* ca = [[coverAnimation alloc] initWithPresent:YES];
    return ca;}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)j_spring_security_check:(NSString *)username password:(NSString *)password{
    [HttpManage j_spring_security_check:username password:password phoneId:[UDObject getTSID] j_username:username j_password:password isJson:@"true" cb:^(BOOL isOK, NSDictionary *dic) {
        [SVProgressHUD dismiss];
        if (isOK) {
            NSString *token = [dic objectForKey:@"token"];
            [UDObject setUserInfo:username userName:@"" token:token];
            [self performSegueWithIdentifier:@"wel2main" sender:nil];
            [[StatusBar sharedStatusBar] talkMsg:@"登录成功" inTime:0.51];
        }else{
            [[StatusBar sharedStatusBar] talkMsg:@"登录失败" inTime:0.51];
        }
    }];
}


@end
