//
//  YJFKViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "YJFKViewController.h"
#import "StatusBar.h"
#import "HttpManage.h"
#import "SVProgressHUD.h"
#import "UDObject.h"

@interface YJFKViewController ()

@end

@implementation YJFKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIColor *color = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    label.text = @"意见反馈";
    [label sizeToFit];
    label.textColor = color;
    label.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    [self.navigationItem setTitleView:label];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(right)];
    
    [_content_edit becomeFirstResponder];
}

-(void)right{
    NSString *content = _content_edit.text;
    if (content.length > 0) {
        [SVProgressHUD showWithStatus:@"提交中" maskType:SVProgressHUDMaskTypeBlack];
        NSString *model = [[UIDevice currentDevice] model];
        [HttpManage suggestion:[UDObject gettoken] type:@"1" content:content model:model cb:^(BOOL isOK, NSDictionary *array) {
            [SVProgressHUD dismiss];
            if (isOK) {
                [[StatusBar sharedStatusBar] talkMsg:@"谢谢您的反馈" inTime:0.51];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [[StatusBar sharedStatusBar] talkMsg:@"提交失败" inTime:0.51];
            }
        }];

    }else{
        [[StatusBar sharedStatusBar] talkMsg:@"内容不能为空" inTime:0.51];
    }
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

- (IBAction)content_next:(id)sender {
    [self right];
}
@end
