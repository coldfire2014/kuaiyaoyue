//
//  UserInfoViewController.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/27.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) UILabel *xm_label;
@property (strong, nonatomic) UILabel *xlfs_label;
@property (strong, nonatomic) UITextField *content_edit;
@property (nonatomic) int info_chage;
@property (nonatomic) int info_length;
@end
