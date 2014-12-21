//
//  ViewController.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/3.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewCell.h"
@import MessageUI;
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIView *showview_img;
@property (weak, nonatomic) IBOutlet UIImageView *show_img;
@property (weak, nonatomic) IBOutlet UIView *head_view;
@property (weak, nonatomic) IBOutlet UIButton *showsetting;
@property (weak, nonatomic) IBOutlet UILabel *show_title;
@property (weak, nonatomic) IBOutlet UIView *showtm;
@property (weak, nonatomic) IBOutlet UILabel *show_toptitle;
- (IBAction)del_onclick:(id)sender;

@end

