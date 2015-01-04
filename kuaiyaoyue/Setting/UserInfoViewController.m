
//
//  UserInfoViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/27.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "UserInfoViewController.h"
#import "EditViewController.h"
#import "UDObject.h"

@interface UserInfoViewController (){
    int is_chage;
}

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"返回";
    UIColor *color = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    label.text = @"个人信息";
    [label sizeToFit];
    label.textColor = color;
    label.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    [self.navigationItem setTitleView:label];
    [self.navigationController.navigationBar setTintColor:color];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    _xm_label.text = [UDObject getXM];
    _xlfs_label.text = [UDObject getLXFS];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier compare:@"infoedit"] == NSOrderedSame ) {
        EditViewController* des = (EditViewController*)segue.destinationViewController;
        des.type = is_chage;
    }
}


- (IBAction)xm_onclick:(id)sender {
    is_chage = 0;
    [self performSegueWithIdentifier:@"infoedit" sender:nil];
}

- (IBAction)lxfs_onclick:(id)sender {
    is_chage = 1;
    [self performSegueWithIdentifier:@"infoedit" sender:nil];
}

@end
