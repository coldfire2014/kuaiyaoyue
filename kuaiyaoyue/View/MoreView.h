//
//  MoreView.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/22.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MVDelegate;

@interface MoreView : UIView
@property (weak, nonatomic) IBOutlet UITextField *jh_edit;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (weak, nonatomic) IBOutlet UILabel *bmtime_label;
@property (weak, nonatomic) IBOutlet UITextField *address_edit;
- (IBAction)address_next:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *xlr_edit;
- (IBAction)xlr_next:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *xlfs_edit;
- (IBAction)xlfs_next:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *show_summary;
@property (weak, nonatomic) IBOutlet UICollectionView *girdview;
@property (weak, nonatomic) IBOutlet UIView *music_view;
@property (weak, nonatomic) IBOutlet UILabel *show_music;
- (IBAction)music_onclick:(id)sender;

- (IBAction)jh_next:(id)sender;
- (IBAction)time_onclick:(id)sender;
- (IBAction)bmtime_onclick:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *del_music_view;
@property (weak, nonatomic) IBOutlet UIView *mv;

@property (nonatomic, weak) id<MVDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *bottom_view;

@property (weak, nonatomic) IBOutlet UILabel *text_label_num;

@property (weak, nonatomic) IBOutlet UIView *editview;

@end
@protocol MVDelegate <NSObject>

- (void)MVDelegate:(MoreView *)cell didTapAtIndex:(int) type;

@end