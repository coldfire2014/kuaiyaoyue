//
//  TemplateCell.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 14/12/15.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "TemplateCell.h"
#import "myImageView.h"
@implementation TemplateCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame andImage:(UIImage*) img
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.shadowRadius = 2;
        self.layer.shadowOpacity = 0.7;
        self.layer.shadowColor = [UIColor grayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(1, 1);
        
        UIView* tmp = [[UIView alloc] initWithFrame:frame];
        tmp.backgroundColor = [UIColor clearColor];
        tmp.clipsToBounds = YES;
        tmp.layer.cornerRadius = 2;
        
        myImageView* imgv = [[myImageView alloc] initWithFrame:frame andImage:img withScale:2.0 andAlign:UIImgAlignmentCenter];
        
        imgv.center = CGPointMake( frame.size.width/2.0, frame.size.height/2.0 );
        imgv.layer.cornerRadius = 2;
        imgv.layer.masksToBounds = YES;
        [tmp addSubview:imgv];
        [self addSubview:tmp];
    }
    return self;
}
@end
