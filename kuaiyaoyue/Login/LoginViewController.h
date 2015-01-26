//
//  LoginViewController.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/6.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phone_edit;
- (IBAction)phone_next:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *password_edit;
@property (weak, nonatomic) IBOutlet UIImageView *password_img;
- (IBAction)password_next:(id)sender;
- (IBAction)login_onclick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *login_button;

@end
