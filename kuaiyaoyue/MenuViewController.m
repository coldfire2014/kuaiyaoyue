//
//  MenuViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)hl_onclick:(id)sender {
    [self performSegueWithIdentifier:@"hledit" sender:nil];
}

- (IBAction)sw_onclick:(id)sender {
    [self performSegueWithIdentifier:@"swedit" sender:nil];
}

- (IBAction)wl_onclick:(id)sender {
    [self performSegueWithIdentifier:@"chedit" sender:nil];
}

- (IBAction)zdy_onclick:(id)sender {
    [self performSegueWithIdentifier:@"" sender:nil];
}
@end
