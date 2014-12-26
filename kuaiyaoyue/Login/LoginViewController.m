
//
//  LoginViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/6.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "LoginViewController.h"
#import "HttpManage.h"
#import "SVProgressHUD.h"
#import "StatusBar.h"
#import "UDObject.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIColor *color = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    label.text = @"登录";
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
    if (username.length > 0 && password.length > 0) {
        [SVProgressHUD showWithStatus:@"登录中" maskType:SVProgressHUDMaskTypeBlack];
        [self.view endEditing:NO];
        [self j_spring_security_check:username password:password];
    }else{
        [[StatusBar sharedStatusBar] talkMsg:@"账号密码不能为空" inTime:0.51];
    }
}

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
