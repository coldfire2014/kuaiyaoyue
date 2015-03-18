
//
//  UserInfoViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/27.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UDObject.h"
#import "SettingNavBar.h"
#import "TalkingData.h"
#import "myImageView.h"
#import "StatusBar.h"
#import "PCHeader.h"
@interface UserInfoViewController (){
    int is_chage;
}

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
    CGFloat h = [[UIScreen mainScreen] bounds].size.height;
    self.view.frame = [UIScreen mainScreen].bounds;
    CGFloat top = 20.0;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        top = 0.0;
        w = 540;
        h = 620;
        self.view.frame = CGRectMake(0, 0, w, h);
    }
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    SettingNavBar* bar = [[SettingNavBar alloc] initWithFrame:CGRectMake(0, 0, w, 88.0/2.0+top)];
    bar.tag = 501;
    [bar changeTitle:@"个人信息"];
    [self.view addSubview:bar];
    [self.view bringSubviewToFront:bar];
    
    UIView* name_btn = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 86.0/2.0)];
    name_btn.tag = 513;
    name_btn.backgroundColor = [UIColor whiteColor];
    name_btn.center = CGPointMake(w/2.0, 128.0/2.0+24.0/2.0 + 86.0/4.0);
    [self.view addSubview:name_btn];
    [self zxname_btn];
    UITapGestureRecognizer *name_btntap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nameUpdata)];
    [name_btn addGestureRecognizer:name_btntap];
    
    UIView* phone_btn = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 86.0/2.0)];
    phone_btn.tag = 515;
    phone_btn.backgroundColor = [UIColor whiteColor];
    phone_btn.center = CGPointMake(w/2.0, name_btn.center.y + 86.0/4.0 + 86.0/4.0);
    [self.view addSubview:phone_btn];
    [self zxphone_btn];
    UITapGestureRecognizer *phone_btntap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(phoneUpdata)];
    [phone_btn addGestureRecognizer:phone_btntap];
    
    UIView* inputView = [[UIView alloc] initWithFrame:CGRectMake(0, h, w, 86.0/2.0)];
    inputView.tag = 517;
    inputView.backgroundColor = [UIColor whiteColor];
    inputView.center = CGPointMake(w/2.0, h + 86.0/4.0 + 86.0/4.0);
    [self.view addSubview:inputView];
    [self zxinputView];
}

- (void)zxname_btn{
    UIView* btn = [self.view viewWithTag: 513];
    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        w = 540;
    }
    UIView* t_line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 0.5)];
    t_line.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [btn addSubview:t_line];
    UIView* b_line = [[UIView alloc] initWithFrame:CGRectMake(8.0, btn.bounds.size.height-0.5, w-16.0, 0.5)];
    b_line.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [btn addSubview:b_line];
    UILabel* mbtitle = [[UILabel alloc] initWithFrame:CGRectMake(18.0, 0, w-36.0, btn.bounds.size.height)];
    [mbtitle setFont:[UIFont systemFontOfSize:16]];
    [mbtitle setTextAlignment:NSTextAlignmentLeft];
    [mbtitle setTextColor:[[UIColor alloc] initWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1.0]];
    [mbtitle setBackgroundColor:[UIColor clearColor]];
    [mbtitle setText:@"姓名"];
    [btn addSubview:mbtitle];
    
    myImageView* arr = [[myImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 32.0/2.0, 32.0/2.0) andImageName:@"arr32" withScale:2.0];
    arr.center = CGPointMake(w - (36.0 + 32.0/2.0)/2.0, btn.bounds.size.height/2.0);
    [btn addSubview:arr];
    
    self.xm_label = [[UILabel alloc] initWithFrame:CGRectMake(18.0, 0, w-50.0, btn.bounds.size.height)];
    [self.xm_label setFont:[UIFont systemFontOfSize:15]];
    [self.xm_label setTextAlignment:NSTextAlignmentRight];
    [self.xm_label setTextColor:[UIColor lightGrayColor]];
    [self.xm_label setBackgroundColor:[UIColor clearColor]];
    self.xm_label.text = [UDObject getXM];
    [btn addSubview:self.xm_label];
}
- (void)zxphone_btn{
    UIView* btn = [self.view viewWithTag: 515];
    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        w = 540;
    }
    UIView* t_line = [[UIView alloc] initWithFrame:CGRectMake(0, btn.bounds.size.height-0.5, w, 0.5)];
    t_line.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [btn addSubview:t_line];
    
    UILabel* mbtitle = [[UILabel alloc] initWithFrame:CGRectMake(18.0, 0, w-36.0, btn.bounds.size.height)];
    [mbtitle setFont:[UIFont systemFontOfSize:16]];
    [mbtitle setTextAlignment:NSTextAlignmentLeft];
    [mbtitle setTextColor:[[UIColor alloc] initWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1.0]];
    [mbtitle setBackgroundColor:[UIColor clearColor]];
    [mbtitle setText:@"联系方式"];
    [btn addSubview:mbtitle];
    
    myImageView* arr = [[myImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 32.0/2.0, 32.0/2.0) andImageName:@"arr32" withScale:2.0];
    arr.center = CGPointMake(w - (36.0 + 32.0/2.0)/2.0, btn.bounds.size.height/2.0);
    [btn addSubview:arr];
    
    self.xlfs_label = [[UILabel alloc] initWithFrame:CGRectMake(18.0, 0, w-50.0, btn.bounds.size.height)];
    [self.xlfs_label setFont:[UIFont systemFontOfSize:15]];
    [self.xlfs_label setTextAlignment:NSTextAlignmentRight];
    [self.xlfs_label setTextColor:[UIColor lightGrayColor]];
    [self.xlfs_label setBackgroundColor:[UIColor clearColor]];
    self.xlfs_label.text = [UDObject getLXFS];
    [btn addSubview:self.xlfs_label];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:^{}];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [TalkingData trackPageBegin:@"个人信息修改"];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(back) name:@"MSG_BACK" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShowNotify:) name:UIKeyboardDidShowNotification object:nil];
}
-(void)updateInfo{
    self.xlfs_label.text = [UDObject getLXFS];
    self.xm_label.text = [UDObject getXM];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [TalkingData trackPageEnd:@"个人信息修改"];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_BACK" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
}
#pragma mark - Navigation
- (void)zxinputView{
    UIView* btn = [self.view viewWithTag: 517];
    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        w = 540;
    }
    UIView* t_line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 0.5)];
    t_line.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.4];
    [btn addSubview:t_line];
    
    self.content_edit = [[UITextField alloc] initWithFrame:CGRectMake(4.0, 4.0, w-btn.bounds.size.height-8.0, btn.bounds.size.height-8.0)];
    self.content_edit.borderStyle = UITextBorderStyleRoundedRect;
    self.content_edit.delegate = self;
    [btn addSubview:self.content_edit];
    
    UILabel* gw = [[UILabel alloc] initWithFrame:CGRectMake(w-btn.bounds.size.height, 0, btn.bounds.size.height, btn.bounds.size.height)];
    [gw setFont:[UIFont systemFontOfSize:16.0]];
    [gw setTextAlignment:NSTextAlignmentCenter];
    [gw setTextColor:[[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0]];
    [gw setBackgroundColor:[UIColor clearColor]];
    [gw setText:@"保存"];
    gw.userInteractionEnabled = YES;
    UITapGestureRecognizer *gw_btntap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(save)];
    [gw addGestureRecognizer:gw_btntap];
    [btn addSubview:gw];
}
-(void)keyboardShowNotify:(NSNotification*)aNotification{
    //获取触发事件对象
    NSDictionary* info = [aNotification userInfo];
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    //将视图Y坐标进行移动，移动距离为弹出键盘的高度
    CGRect mainScreenFrame = [[UIScreen mainScreen] applicationFrame];
    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
    CGFloat h = [[UIScreen mainScreen] bounds].size.height;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        w = 540;
        h = 620;
        mainScreenFrame = CGRectMake(0, 0, w, h);
    }
    UIView* btn = [self.view viewWithTag: 517];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (ISIOS8LATER) {
            btn.center = CGPointMake(btn.center.x, mainScreenFrame.size.height-keyboardRect.size.height+106);
        } else {
            btn.center = CGPointMake(btn.center.x, mainScreenFrame.size.height-keyboardRect.size.width+106);
        }
    }else{
        btn.center = CGPointMake(btn.center.x, mainScreenFrame.size.height-keyboardRect.size.height);
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
//    CGRect mainScreenFrame = [[UIScreen mainScreen] applicationFrame];
//    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
    CGFloat h = [[UIScreen mainScreen] bounds].size.height;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        w = 540;
        h = 620;
//        mainScreenFrame = CGRectMake(0, 0, w, h);
    }
    UIView* btn = [self.view viewWithTag: 517];
    [UIView animateWithDuration:0.3 animations:^{
        btn.center = CGPointMake(btn.center.x, h+86.0/2.0);
    }];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    CGRect mainScreenFrame = [[UIScreen mainScreen] applicationFrame];
    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
    CGFloat h = [[UIScreen mainScreen] bounds].size.height;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        w = 540;
        h = 620;
        mainScreenFrame = CGRectMake(0, 0, w, h-246);
    }else{
        mainScreenFrame = CGRectMake(0, 0, w, h-216);
    }
    
    UIView* btn = [self.view viewWithTag: 517];
    [UIView animateWithDuration:0.3 animations:^{
        btn.center = CGPointMake(btn.center.x, mainScreenFrame.size.height);
    }];
    return YES;
}
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
-(void)save{
    if (self.content_edit.text.length > self.info_length) {
        if (self.info_chage == 0) {
            [[StatusBar sharedStatusBar] talkMsg:@"请不要输入操过20个字。" inTime:1.5];
        } else {
            [[StatusBar sharedStatusBar] talkMsg:@"请不要输入操过17个字。" inTime:1.5];
        }
        return;
    }
    NSString *content = self.content_edit.text;
    [self.content_edit resignFirstResponder];
    if (content.length > 0) {
        if (self.info_chage == 0) {
            [UDObject setXM:content];
        }else{
            [UDObject setLXFS:content];
        }
        [self updateInfo];
    }
}

- (void)nameUpdata {
    self.info_chage = 0;
    [self.content_edit becomeFirstResponder];
    self.content_edit.text = [UDObject getXM];
    self.content_edit.placeholder = @"请输入姓名";
    self.info_length = 20;
}

- (void)phoneUpdata {
    self.info_chage = 1;
    [self.content_edit becomeFirstResponder];
    self.content_edit.text = [UDObject getLXFS];
    self.content_edit.placeholder = @"请输入联系方式";
    self.info_length = 17;
}

@end
