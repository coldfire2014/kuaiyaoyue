//
//  imgGroupView.m
//  SpeciallyEffect
//
//  Created by wuyangbing on 14/12/7.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

#import "imgGroupView.h"

@implementation imgGroupView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.hidden = false;
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(24.0/2.0, 0, frame.size.width - 24.0, frame.size.height)];
        self.title.font = [UIFont systemFontOfSize:15.0];
        self.title.textAlignment = NSTextAlignmentLeft;
        self.title.textColor = [[UIColor alloc] initWithWhite:0.2 alpha:1.0];
        self.title.backgroundColor = [UIColor clearColor];
        [self addSubview:self.title];
    }
    return self;
}
@end
