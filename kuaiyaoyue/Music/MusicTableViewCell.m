//
//  MusicTableViewCell.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/3.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "MusicTableViewCell.h"
#import "PCHeader.h"
@implementation MusicTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat aw = [[UIScreen mainScreen] bounds].size.width;

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            aw = 540;
        }
        UIView* line = [[UIView alloc] initWithFrame:CGRectMake(44.0, 42.5, aw-44.0-8.0, 0.5)];
        line.backgroundColor = [[UIColor alloc] initWithWhite:0.4 alpha:0.5];
        [self addSubview:line];
        _show_status = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44.0, 43.0)];
        _show_status.backgroundColor = [UIColor clearColor];
        [self addSubview: _show_status];
        CGFloat w = 30;
        UIView *gx = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w/4.0, 2.0)];
        gx.backgroundColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        gx.center = CGPointMake(0.5*w + 0.5, 0.5*w - 0.5);
        gx.layer.transform = CATransform3DTranslate(gx.layer.transform, -w/4.0, 1.0, 0);
        gx.layer.transform = CATransform3DRotate(gx.layer.transform, M_PI_2, 0, 0, 1);
        [_show_status addSubview:gx];
        
        UIView *gs = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w/1.7 - 2.0, 2.0)];
        gs.backgroundColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        gs.center = CGPointMake(0.5*w + 0.7, 0.5*w - 0.5);
        gs.layer.transform = CATransform3DTranslate(gs.layer.transform, 0.0, w/8.0, 0);
        [_show_status addSubview:gs];
        _show_status.layer.transform = CATransform3DRotate(_show_status.layer.transform, -M_PI_4, 0, 0, 1);
        _show_status.layer.transform = CATransform3DTranslate(_show_status.layer.transform, 6.0, 3.0, 0);
        _show_content = [[UILabel alloc] initWithFrame:CGRectMake(44.0, 0.5, aw-44.0-8.0, 42.0)];
        _show_content.font = [UIFont systemFontOfSize:18];
        _show_content.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_show_content];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


@end
