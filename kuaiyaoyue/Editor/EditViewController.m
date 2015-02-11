//
//  EditViewController.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/2/11.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import "EditViewController.h"
#import "PCHeader.h"
@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
    CGFloat h = [[UIScreen mainScreen] bounds].size.height;
    CGFloat top = 20.0;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        top = 0.0;
        w = IPAD_FRAME.size.width;
        h = IPAD_FRAME.size.height;
    }
    UIView* allbg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    CAGradientLayer* layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, w, h);
    layer.position = CGPointMake(w/2.0, h/2.0);
//    UIColor * typeColor = [[UIColor alloc] initWithRed:255.0/255.0 green:154.0/255.0 blue:36.0/255.0 alpha:1.0];
//    UIColor * typeColor = [[UIColor alloc] initWithRed:53.0/255.0 green:167.0/255.0 blue:238.0/255.0 alpha:1.0];
//    UIColor * typeColor = [[UIColor alloc] initWithRed:255.0/255.0 green:103.0/255.0 blue:154.0/255.0 alpha:1.0];
    UIColor * typeColor = [[UIColor alloc] initWithRed:38.0/255.0 green:214.0/255.0 blue:90.0/255.0 alpha:1.0];
    layer.colors = [[NSArray alloc] initWithObjects:
                    (id)typeColor.CGColor,
                    (id)[[UIColor alloc] initWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0].CGColor,
                    (id)[[UIColor alloc] initWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0].CGColor,
                    nil];
    layer.locations = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:60.0/h],[NSNumber numberWithDouble:1.0], nil];
    [allbg.layer addSublayer:layer];
    allbg.clipsToBounds = YES;
    [self.view addSubview:allbg];
    UIView *mainBg = [[UIView alloc] initWithFrame:CGRectMake(66.0, 20.0, w-61.0, h-10.0)];
    mainBg.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
    mainBg.layer.cornerRadius = 4.0;
    mainBg.layer.shadowRadius = 2;
    mainBg.layer.shadowOpacity = 1.0;
    mainBg.layer.shadowColor = [UIColor grayColor].CGColor;
    mainBg.layer.shadowOffset = CGSizeMake(1, 1);
    [allbg addSubview:mainBg];
    UIView *tabView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 66.0, h)];
    tabView.backgroundColor = [UIColor clearColor];
    [allbg addSubview:tabView];
    
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

@end
