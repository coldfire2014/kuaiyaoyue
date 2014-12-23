//
//  CustomView.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/23.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *show_top_img;
- (IBAction)show_top_onclick:(id)sender;
- (IBAction)time_onclick:(id)sender;
- (IBAction)endtime_onclick:(id)sender;
- (IBAction)music_onclick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *title_edit;
@property (weak, nonatomic) IBOutlet UITextView *content_edit;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (weak, nonatomic) IBOutlet UILabel *endtime_label;
@property (weak, nonatomic) IBOutlet UICollectionView *gridview;
@property (weak, nonatomic) IBOutlet UILabel *music_label;
@property (weak, nonatomic) IBOutlet UIView *music_view;
@property (weak, nonatomic) IBOutlet UIView *girdview_line;


@end
