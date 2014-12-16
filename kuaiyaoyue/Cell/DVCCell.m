//
//  DVCCell.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/16.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "DVCCell.h"

@implementation DVCCell

- (void)awakeFromNib {
    // Initialization code
    self.clipsToBounds = YES;
    _show_view.layer.cornerRadius = 5;
    _show_view.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)message_onclick:(id)sender {
    if ([_talk compare:@""] != NSOrderedSame) {
        if ([_delegate respondsToSelector:@selector(didSelectItemAtIndex:)]) {
            [_delegate didSelectItemAtIndex:_index];
        } else {
            NSLog(@"Not respondsToSelector:@selector(didSelectItemAtIndex:)");
        }
    }
}

- (IBAction)phone_onclick:(id)sender {
    if ([_phone compare:@""] != NSOrderedSame) {
        if ([_delegate respondsToSelector:@selector(didShowPhone:)]) {
            [_delegate didShowPhone:_phone];
        } else {
            NSLog(@"Not respondsToSelector:@selector(didShowPhone:)");
        }
    }
}
@end
