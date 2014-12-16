//
//  ViewCell.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BigStateView.h"

@interface ViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *show_img;
@property (weak, nonatomic) IBOutlet UIButton *show_send;
- (IBAction)send_onclick:(id)sender;

@end
