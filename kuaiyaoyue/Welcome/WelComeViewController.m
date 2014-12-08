//
//  WelComeViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "WelComeViewController.h"
#import "UDObject.h"

@interface WelComeViewController ()

@end

@implementation WelComeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    NSString *name = nil;
//    if ([[UDObject getOPEN] length] > 0) {
//        name = @"main";
//    }else{
//        name = @"wel";
//    }
//    [self performSegueWithIdentifier:name sender:nil];
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

- (IBAction)onclick:(id)sender {
    [self performSegueWithIdentifier:@"main" sender:nil];

}
@end
