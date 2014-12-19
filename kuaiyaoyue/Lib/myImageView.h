//
//  myImageView.h
//  SpeciallyEffect
//
//  Created by wuyangbing on 14/12/2.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, UIImgAlignment) {
    UIImgAlignmentTop = 0,
    UIImgAlignmentCenter,
    UIImgAlignmentBottom,                   // could add justified in future
};
@interface myImageView : UIImageView
- (id)initWithFrame:(CGRect)nframe andImageName:(NSString *)name withScale:(CGFloat)scale;
- (id)initWithFrame:(CGRect)nframe andImageName:(NSString *)name withScale:(CGFloat)scale andAlign:(UIImgAlignment)align;
- (id)initWithFrame:(CGRect)nframe andImage:(UIImage *)img withScale:(CGFloat)scale andAlign:(UIImgAlignment)align;
- (id)initWithFrame:(CGRect)nframe andImageName:(NSString *)name withScale:(CGFloat)scale andBundleName:(NSString*) bundle;
- (id)initWithFrame:(CGRect)nframe andImageName:(NSString *)name withScale:(CGFloat)scale andAlign:(UIImgAlignment)align andBundleName:(NSString*) bundle;

- (void)changeWithImageName:(NSString *)name withScale:(CGFloat)scale;
- (void)changeWithImageName:(NSString *)name withScale:(CGFloat)scale andAlign:(UIImgAlignment)align;
+ (UIImage*)getShadowImage:(CGRect)bounds;
- (void)clearBadge;
- (void)setBadgeValue:(NSInteger)badgeValue;
+ (UIImage*)getGradImage:(CGRect)bounds;
@end
