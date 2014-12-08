//
//  MusicTableViewCell.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/3.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MusicTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *show_status;
@property (weak, nonatomic) IBOutlet UILabel *show_content;
@property long index;
@property long type;

@end