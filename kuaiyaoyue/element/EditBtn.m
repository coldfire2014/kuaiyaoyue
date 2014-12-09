//
//  EditBtn.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 14/12/9.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "EditBtn.h"

@implementation EditBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [[UIColor alloc] initWithRed:30.0/255.0 green:78.0/255.0 blue:141.0/255.0 alpha:1.0];
        self.layer.cornerRadius = self.frame.size.height/2.0;
        
    }
    return self;
}


@end
