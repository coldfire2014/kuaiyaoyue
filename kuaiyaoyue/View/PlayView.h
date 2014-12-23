//
//  PlayView.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/23.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PVDelegate;

@interface PlayView : UIView

@property (weak, nonatomic) IBOutlet UITextField *jh_edit;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
- (IBAction)time_onclick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *bmtime_label;
- (IBAction)bmtime_onclick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *address_edit;
@property (weak, nonatomic) IBOutlet UITextField *xlr_edit;
@property (weak, nonatomic) IBOutlet UITextField *xlfs_edit;

@property (weak, nonatomic) IBOutlet UITextView *show_summary;
@property (weak, nonatomic) IBOutlet UICollectionView *girdview;

@property (weak, nonatomic) IBOutlet UIView *audio_view;
@property (weak, nonatomic) IBOutlet UIView *audio_showview;
@property (weak, nonatomic) IBOutlet UIView *audiobottomview;
@property (weak, nonatomic) IBOutlet UIView *bottom_view;
- (IBAction)bf_onclick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *del_button;
- (IBAction)del_onclick:(id)sender;
- (IBAction)jh_next:(id)sender;
- (IBAction)address_next:(id)sender;
- (IBAction)lxr_next:(id)sender;
- (IBAction)lxfs_nex:(id)sender;

@property (nonatomic, weak) id<PVDelegate> delegate;

@end
@protocol PVDelegate <NSObject>

- (void)PVDelegate:(PlayView *)cell didTapAtIndex:(int) type;

@end
