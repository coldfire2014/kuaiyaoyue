//
//  ViewCell.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "ViewCell.h"

@implementation ViewCell{
    StateView* s;
}

- (void)awakeFromNib {
    // Initialization code
    NSLog(@"%f",_widht);
    s = [[StateView alloc] initWithFrame:CGRectMake(0,-5, 55, 55)];
    [s setState:StateGoing withAll:@"19" andAdd:@""];
    [s setStartTime:[NSDate dateWithTimeIntervalSinceNow:-10] EndTime:[NSDate dateWithTimeIntervalSinceNow:5] andGoneTime:[NSDate dateWithTimeIntervalSinceNow:8]];
    
    [_show_time addSubview:s];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _show_img.layer.cornerRadius = 3;
    _show_img.clipsToBounds = YES;
    _show_img.contentMode = UIViewContentModeScaleAspectFill;
    
    _show_send.layer.cornerRadius = 3;
}

- (IBAction)send_onclick:(id)sender {
}
@end
