//
//  UserInfoViewController.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/27.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoViewController : UIViewController
- (IBAction)xm_onclick:(id)sender;
- (IBAction)lxfs_onclick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *xm_label;
@property (weak, nonatomic) IBOutlet UILabel *xlfs_label;

@end
