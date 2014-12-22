//
//  HLEditView.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/22.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HLEVDelegate;

@interface HLEditView : UIView

@property (weak, nonatomic) IBOutlet UICollectionView *gridview;
@property (weak, nonatomic) IBOutlet UIView *bottomview;
@property (weak, nonatomic) IBOutlet UITextField *xl_edit;
@property (weak, nonatomic) IBOutlet UITextField *xn_edit;
@property (weak, nonatomic) IBOutlet UILabel *hltime_label;
@property (weak, nonatomic) IBOutlet UILabel *bmend_label;
@property (weak, nonatomic) IBOutlet UITextField *address_edit;
@property (weak, nonatomic) IBOutlet UILabel *music_label;
- (IBAction)xl_next:(id)sender;
- (IBAction)xn_next:(id)sender;
- (IBAction)hltime_onclick:(id)sender;
- (IBAction)bmtime_onclick:(id)sender;
- (IBAction)address_next:(id)sender;
- (IBAction)music_onclick:(id)sender;

@property (nonatomic, weak) id<HLEVDelegate> delegate;
@end
@protocol HLEVDelegate <NSObject>

- (void)HLEVDelegate:(HLEditView *)cell didTapAtIndex:(int) type;

@end