//
//  SettingViewController.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController
- (IBAction)checkupdata_onclick:(id)sender;
- (IBAction)ghp_onclick:(id)sender;
- (IBAction)gl_onclick:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *tc_view;
- (IBAction)gw_onclick:(id)sender;
- (IBAction)wb_onclick:(id)sender;
- (IBAction)gzh_onclick:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *xhd_view;

@end
