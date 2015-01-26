
//
//  LoginViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/6.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "LoginViewController.h"
#import "HttpManage.h"
#import "waitingView.h"
#import "StatusBar.h"
#import "UDObject.h"
#import "PCHeader.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 128.0/2.0)];
    navView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.95];
    [self.view addSubview:navView];
    
    UIView* btnLeft = [[UIView alloc] initWithFrame:CGRectMake(8.0, 20.0, 44.0, 44.0)];
    btnLeft.tag = 102;
    [navView addSubview:btnLeft];
    UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [btnLeft addGestureRecognizer:tap1 ];
    UILabel* lbl_OK = [[UILabel alloc] initWithFrame:btnLeft.bounds];
    lbl_OK.font = [UIFont systemFontOfSize:18];
    lbl_OK.text = @"返回";
    lbl_OK.textAlignment = NSTextAlignmentCenter;
    lbl_OK.textColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
    [btnLeft addSubview:lbl_OK];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, navView.frame.size.height-0.5, navView.frame.size.width, 0.5)];
    line.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.5];
    [navView addSubview:line];
    
    UILabel* lbl = [[UILabel alloc] initWithFrame:CGRectMake(100.0, 20.0, navView.frame.size.width - 200.0, 44.0)];
    lbl.tag = 105;
    lbl.font = [UIFont systemFontOfSize:20];
    lbl.text = @"登录";
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
    [navView addSubview:lbl];

    _login_button.layer.cornerRadius = 5.0;
    
    if ([YINGLOUURL compare:@""] != NSOrderedSame) {
        _password_edit.text = @"*该账户有影楼提供并激活。";
        _password_edit.enabled = NO;
        _password_edit.secureTextEntry = NO;
        _password_edit.textColor = [UIColor redColor];
        _password_img.hidden = YES;
        
    } else {
    }
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewonclick:)];
    
    [self.view addGestureRecognizer:tap2];
}

- (void)viewonclick:(UITapGestureRecognizer *)gr{
    [self.view endEditing:NO];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [self.navigationController.navigationBar setHidden:NO];
}


-(void) viewWillDisappear:(BOOL)animated{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)phone_next:(id)sender {
    [_password_edit becomeFirstResponder];
}

- (IBAction)password_next:(id)sender {
    [self login];
}

- (IBAction)login_onclick:(id)sender {
    [self login];
}

-(void)login{
    NSString *username = _phone_edit.text;
    NSString *password = _password_edit.text;
    if ([YINGLOUURL compare:@""] != NSOrderedSame) {
        password = @"1234567";
    } else {
    }
    if (username.length > 0 && password.length > 0) {
        [[waitingView sharedwaitingView] waitByMsg:@"正在登录" haveCancel:NO];
        [self.view endEditing:NO];
        [self j_spring_security_check:username password:password];
    }else{
        [[StatusBar sharedStatusBar] talkMsg:@"账号密码不能为空" inTime:0.51];
    }
}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
-(void)j_spring_security_check:(NSString *)username password:(NSString *)password{
    [HttpManage j_spring_security_check:username password:password phoneId:[UDObject getTSID] j_username:username j_password:password isJson:@"true" cb:^(BOOL isOK, NSDictionary *dic) {
        [[waitingView sharedwaitingView] stopWait];
        if (isOK) {
            NSString *token = [dic objectForKey:@"token"];
            [UDObject setUserInfo:username userName:@"" token:token];
            NSString* url = YINGLOUURL;
            if([url compare:HTTPURL] == NSOrderedSame){
                [UDObject setYLID:[dic objectForKey:@"studioId"]];
            }
//            [self performSegueWithIdentifier:@"wel2main" sender:nil];
            [UDObject setLXFS:username];
            [[StatusBar sharedStatusBar] talkMsg:@"成功登录" inTime:0.31];
            [self dismissViewControllerAnimated:YES completion:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_LOGIN_DONE" object:nil];
            }];
        }else{
            [[StatusBar sharedStatusBar] talkMsg:@"登录失败了，再试一下吧。" inTime:0.51];
        }
    }];
}


@end
