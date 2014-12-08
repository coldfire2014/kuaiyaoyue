//
//  imgView.m
//  edittext
//
//  Created by wu yangbing on 14-7-21.
//  Copyright (c) 2014年 wu yangbing. All rights reserved.
//

#import "imgView.h"
#import "HttpHelper.h"

@implementation imgView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
        self.layer.cornerRadius = 5;
//        self.layer.shouldRasterize = YES;
        self.layer.shadowRadius = 2;
        self.layer.shadowOpacity = 0.7;
        self.layer.shadowColor = [UIColor grayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, -1);
    }
    return self;
}
-(void)changeWithImageName:(NSString*)imageToLoad{
    if (_img == nil) {
//        _img = [[myImageView alloc] initWithFrame:CGRectInset(self.bounds,2,2) andImageName:imageToLoad];
        _img = [[myImageView alloc] initWithFrame:CGRectInset(self.bounds,0,0) andImageName:imageToLoad];
        _img.layer.cornerRadius = 4;
        _img.layer.masksToBounds = YES;
        _img.contentMode = UIViewContentModeScaleAspectFill;
//        _img.layer.shouldRasterize = YES;
        
        [self addSubview:_img];
    } else {
//        [_img changeWithImageName:imageToLoad];
    }
}

@end
