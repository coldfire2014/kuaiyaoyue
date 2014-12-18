//
//  PhotoCell.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/18.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotoCellDelegate;

@interface PhotoCell : UICollectionViewCell
- (IBAction)del_onclick:(id)sender;
@property long index;
@property (weak, nonatomic) IBOutlet UIImageView *show_img;
@property (weak, nonatomic) IBOutlet UIButton *del_button;
@property (nonatomic, weak) id<PhotoCellDelegate> delegate;
@end

@protocol PhotoCellDelegate <NSObject>

- (void)PhotoCellDelegate:(PhotoCell *)cell didTapAtIndex:(long ) index;

@end