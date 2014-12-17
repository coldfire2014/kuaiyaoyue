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
        
        UIView* tmp = [[UIView alloc] initWithFrame:frame];
        tmp.backgroundColor = [UIColor clearColor];
        tmp.clipsToBounds = YES;
        tmp.layer.cornerRadius = 2;
        
        myImageView* imgv = [[myImageView alloc] initWithFrame:frame andImage:img withScale:2.0 andAlign:UIImgAlignmentCenter];
        
        imgv.center = CGPointMake( frame.size.width/2.0, frame.size.height/2.0 );
        imgv.layer.cornerRadius = 2;
        imgv.layer.masksToBounds = YES;
        CGRect mainScreenFrame = [[UIScreen mainScreen] applicationFrame];
        if (mainScreenFrame.size.height>480) {
            self.layer.shadowRadius = 2;
            self.layer.shadowOpacity = 1.0;
            self.layer.shadowColor = [UIColor grayColor].CGColor;
            self.layer.shadowOffset = CGSizeMake(1, 1);
        } else {
//            imgv.layer.borderWidth = 2.0;
//            imgv.layer.borderColor = [[UIColor alloc] initWithWhite:0.5 alpha:0.4].CGColor;
        }
        [tmp addSubview:imgv];
        [self addSubview:tmp];
    }
    return self;
}
@end
