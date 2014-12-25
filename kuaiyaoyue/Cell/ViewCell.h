//
//  ViewCell.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BigStateView.h"
#import "Userdata.h"

@protocol VCDelegate;

@interface ViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *show_img;
@property (weak, nonatomic) IBOutlet UIButton *show_send;
- (IBAction)send_onclick:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *show_time;
@property (weak, nonatomic) IBOutlet UILabel *show_title;
@property (weak, nonatomic) IBOutlet UILabel *show_endtime;
@property (weak, nonatomic) IBOutlet UILabel *show_hdtime;
@property (weak, nonatomic) Userdata *info;
@property long index;

@property (weak, nonatomic) IBOutlet UILabel *show_newnum;
@property (weak, nonatomic) IBOutlet UIView *show_newview;

@property CGFloat widht;

@property (nonatomic, weak) id<VCDelegate> delegate;

@end
@protocol VCDelegate <NSObject>

- (void)VCDelegate:(ViewCell *)cell didTapAtIndex:(long ) index type:(int)type;

@end