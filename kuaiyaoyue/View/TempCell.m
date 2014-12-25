//
//  TempCell.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 14/12/25.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "TempCell.h"

@implementation TempCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView* line = [[UIView alloc] initWithFrame:CGRectMake(8, 87.5, 72, 0.5)];
        line.backgroundColor = [[UIColor alloc] initWithWhite:0.4 alpha:0.5];
        [self addSubview:line];
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
        _image.center = CGPointMake(44, 44);
        _image.layer.shadowRadius = 2;
        _image.layer.shadowOpacity = 1.0;
        _image.layer.shadowColor = [UIColor grayColor].CGColor;
        _image.layer.shadowOffset = CGSizeMake(1, 1);
        [self addSubview:_image];
    }
    return self;
}

@end
