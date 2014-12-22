//
//  MoreView.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/22.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreView : UIView

@property (weak, nonatomic) IBOutlet UITextView *show_summary;
@property (weak, nonatomic) IBOutlet UICollectionView *girdview;
@property (weak, nonatomic) IBOutlet UIView *music_view;
@property (weak, nonatomic) IBOutlet UILabel *show_music;
- (IBAction)music_onclick:(id)sender;

@end
