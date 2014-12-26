//
//  RegistrationViewController.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/26.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phone_num;
@property (weak, nonatomic) IBOutlet UITextField *dx_edit;
@property (weak, nonatomic) IBOutlet UIButton *yzm_button;
- (IBAction)yzm_onclick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *password_edit;
@property (weak, nonatomic) IBOutlet UITextField *password_sureedit;
@property (weak, nonatomic) IBOutlet UIButton *login_button;
- (IBAction)login_onclick:(id)sender;
- (IBAction)phone_next:(id)sender;
- (IBAction)yzm_next:(id)sender;
- (IBAction)password_next:(id)sender;
- (IBAction)surepassword_next:(id)sender;


- (IBAction)dq_next:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *dq_edit;
@end
