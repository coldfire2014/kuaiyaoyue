//
//  perviewImg.h
//  SpeciallyEffect
//
//  Created by wuyangbing on 14/12/7.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssetHelper.h"
@interface perviewImg : UIView
{
    AssetHelper* assert;
    CGSize smallSize;
    CGSize bigSize;
    CGRect zframe;
    CGPoint firstTranslation;
    CGPoint previousTranslation;
    CATransform3D t;
}
- (instancetype)initWithFrame:(CGRect)frame andInitframe:(CGRect)initframe andAsset:(ALAsset*)asset orImage:(UIImage*)img;
@property (nonatomic,retain) UILabel* title;
@end
