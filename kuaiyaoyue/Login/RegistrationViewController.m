//
//  RegistrationViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/26.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "RegistrationViewController.h"
#import "SMS_SDK/SMS_SDK.h"
#import "HttpManage.h"
#import "SVProgressHUD.h"
#import "StatusBar.h"
#import "UDObject.h"

@interface RegistrationViewController (){
    NSTimer *countDownTimer;
    int secondsCountDown;
}

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIColor *color = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    label.text = @"注册";
    [label sizeToFit];
    label.textColor = color;
    label.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    [self.navigationItem setTitleView:label];
    [self.navigationController.navigationBar setTintColor:color];
    
    _login_button.layer.cornerRadius = 5.0;
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewonclick:)];
    
    [self.view addGestureRecognizer:tap2];
}

- (void)viewonclick:(UITapGestureRecognizer *)gr{
    [self.view endEditing:NO];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
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

-(void)djs{
    secondsCountDown = 60;
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}

-(void)timeFireMethod{
    secondsCountDown--;
    [_yzm_button setTitle:[NSString stringWithFormat:@"重新获取(%d)",secondsCountDown] forState:0];
    
    if(secondsCountDown == 0){
        [countDownTimer invalidate];
        [_yzm_button setTitle:[NSString stringWithFormat:@"获取验证码"] forState:0];
    }
}

- (IBAction)yzm_onclick:(id)sender {
    NSString *phone = _phone_num.text;
    NSString *dq = _dq_edit.text;
    if (phone.length > 0 && dq.length > 0) {
        if (secondsCountDown == 0) {
            [self sendmessage:phone :dq];
        }
    }else{
        [[StatusBar sharedStatusBar] talkMsg:@"手机号和区号不能为空" inTime:0.51];
    }
    
    
}

-(void)sendmessage:(NSString *)phone :(NSString *)dq{
    
    [SMS_SDK getVerifyCodeByPhoneNumber:phone AndZone:dq result:^(enum SMS_GetVerifyCodeResponseState state) {
        if (1==state) {
            NSLog(@"block 获取验证码成功");
            [self djs];
        }
        else if(0==state)
        {
            [[StatusBar sharedStatusBar] talkMsg:@"获取验证码失败" inTime:0.51];
        }
        else if (SMS_ResponseStateMaxVerifyCode==state)
        {
            [[StatusBar sharedStatusBar] talkMsg:@"获取验证码失败" inTime:0.51];
        }
        else if(SMS_ResponseStateGetVerifyCodeTooOften==state)
        {
            [[StatusBar sharedStatusBar] talkMsg:@"获取验证码失败" inTime:0.51];
        }
    }];
}

-(void)getmessgae:(NSString *)yzm :(NSString *) mobilePhone :(NSString *) password{
    [SMS_SDK commitVerifyCode:yzm result:^(enum SMS_ResponseState state) {
        if (1==state) {
            NSLog(@"block 验证成功");
            [self phoneregister:mobilePhone :password];
        }
        else if(0==state)
        {
            [[StatusBar sharedStatusBar] talkMsg:@"短信验证失败" inTime:0.51];
        }
    }];
}

-(void)phoneregister:(NSString *) mobilePhone :(NSString *) password{
    [SVProgressHUD showWithStatus:@"注册中" maskType:(SVProgressHUDMaskTypeBlack)];
    [HttpManage phoneregister:mobilePhone password:password cb:^(BOOL isOK, NSMutableArray *array) {
        [SVProgressHUD dismiss];
        if (isOK) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [[StatusBar sharedStatusBar] talkMsg:@"注册失败" inTime:0.51];
        }
    }];
}

- (IBAction)login_onclick:(id)sender {
    NSString *mobilePhone = _phone_num.text;
    NSString *password = _password_edit.text;
    NSString *passwordsure = _password_sureedit.text;
    NSString *yzm = _dx_edit.text;
    if (mobilePhone.length > 0 && password.length > 0 && passwordsure.length > 0 && yzm.length > 0) {
        if ([passwordsure isEqualToString:password]) {
            [self getmessgae:yzm :mobilePhone :password];
        }else{
            [[StatusBar sharedStatusBar] talkMsg:@"2次输入的密码不相同" inTime:0.51];
        }
    }else{
        [[StatusBar sharedStatusBar] talkMsg:@"内容不能为空" inTime:0.51];
    }
}

- (IBAction)phone_next:(id)sender {
    [_dx_edit becomeFirstResponder];
}

- (IBAction)yzm_next:(id)sender {
    [_password_edit becomeFirstResponder];
}

- (IBAction)password_next:(id)sender {
    [_password_sureedit becomeFirstResponder];
}

- (IBAction)surepassword_next:(id)sender {
    
}

- (IBAction)dq_next:(id)sender {
    
}
@end
