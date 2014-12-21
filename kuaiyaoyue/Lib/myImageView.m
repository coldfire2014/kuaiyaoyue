//
//  myImageView.m
//  SpeciallyEffect
//
//  Created by wuyangbing on 14/12/2.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

#import "myImageView.h"
@implementation myImageView
- (void)clearBadge{
    [self setBadgeValue:0];
}
- (void)setBadgeValue:(NSInteger)badgeValue{
    UIView* bview = [self viewWithTag:10001];
    if (bview == nil) {
        CGFloat w = 15.0;
        CGFloat t = 5.0;
        bview = [[UIView alloc] initWithFrame: CGRectMake( self.frame.size.width-w-t,t,w,w)];
        bview.tag = 10001;
//        bview.backgroundColor = [[UIColor alloc] initWithRed: 254.0/255.0 green: 25.0/255.0 blue: 29.0/255.0 alpha:1.0];
        bview.backgroundColor = [[UIColor alloc] initWithRed: 54.0/255.0 green: 215.0/255.0 blue: 79.0/255.0 alpha:1.0];
        bview.layer.cornerRadius = w/2.0;
        UILabel* titled = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, w, w)];
        titled.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:11];
        titled.textAlignment = NSTextAlignmentCenter;
        titled.textColor = [UIColor whiteColor];
        titled.backgroundColor = [UIColor clearColor];
        titled.text = [[NSString alloc] initWithFormat:@"%ld",(long)badgeValue];
        titled.tag = 10043;
        [bview addSubview:titled];
        [self addSubview:bview];
    }
    UILabel* titled = (UILabel*)[bview viewWithTag:10043];
    if (badgeValue > 0) {
        bview.hidden = NO;
        titled.text = [[NSString alloc] initWithFormat:@"%ld",(long)badgeValue];
        [self doudou:bview];
    } else {
        bview.hidden = YES;
    }
}
- (void)doudou:(UIView*)view{
    CAKeyframeAnimation* moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    moveAnim.values = [[NSArray alloc] initWithObjects:
                       [NSNumber numberWithDouble:1.3],
                       [NSNumber numberWithDouble:0.9],
                       [NSNumber numberWithDouble:1.04],
                       [NSNumber numberWithDouble:0.99],
                       [NSNumber numberWithDouble:1.0],nil];
    moveAnim.removedOnCompletion = YES;
    moveAnim.duration = 0.5;
    moveAnim.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    moveAnim.fillMode = kCAFillModeForwards;
    [view.layer addAnimation:moveAnim forKey:@"s"];
}
- (void)changeWithImageName:(NSString *)name withScale:(CGFloat)scale{
    [self changeWithImageName:name withScale:scale andAlign:UIImgAlignmentCenter];
}
- (void)changeWithImageName:(NSString *)name withScale:(CGFloat)scale andAlign:(UIImgAlignment)align{
    NSRange r = [name rangeOfString:@".jpg"];
    if (r.length>0) {
        name = [name substringToIndex:r.location];
        UIImage* img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"jpg"]];
        self.image = [[UIImage alloc] initWithCGImage:img.CGImage scale:scale orientation:UIImageOrientationUp];
    } else {
        UIImage* img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"png"]];
        self.image = [[UIImage alloc] initWithCGImage:img.CGImage scale:scale orientation:UIImageOrientationUp];
    }
    if (self.image != nil) {
        CGSize imgSize = self.image.size;
        if (imgSize.height > self.frame.size.height) {
            switch (align) {
                case UIImgAlignmentBottom:
                    self.frame = CGRectMake(0, self.frame.size.height - imgSize.height, imgSize.width, imgSize.height);
                    break;
                case UIImgAlignmentCenter:
                    self.frame = CGRectMake(0, (self.frame.size.height - imgSize.height)/2.0, imgSize.width, imgSize.height);
                    break;
                case UIImgAlignmentTop:
                    self.frame = CGRectMake(0, 0, imgSize.width, imgSize.height);
                    break;
                default:
                    break;
            }
        }
    }
}

- (id)initWithFrame:(CGRect)nframe andImageName:(NSString *)name withScale:(CGFloat)scale{
    self = [self initWithFrame:nframe andImageName:name withScale:scale andBundleName:nil];
    if (self) {

    }
    return self;
}
- (id)initWithFrame:(CGRect)nframe andImageName:(NSString *)name withScale:(CGFloat)scale andBundleName:(NSString*) nbundle{
    self = [super initWithFrame:nframe];
    if (self) {
        NSBundle *bundle = [NSBundle mainBundle];
        if(nil != nbundle){
            bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:nbundle ofType:@"bundle"]];
        }
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        NSRange r = [name rangeOfString:@".jpg"];
        if (r.length>0) {
            name = [name substringToIndex:r.location];
            UIImage* img = [[UIImage alloc] initWithContentsOfFile:[bundle pathForResource:name ofType:@"jpg"]];
            self.image = [[UIImage alloc] initWithCGImage:img.CGImage scale:scale orientation:UIImageOrientationUp];
        } else if([name length] != 0){
            UIImage* img = [[UIImage alloc] initWithContentsOfFile:[bundle pathForResource:name ofType:@"png"]];
            self.image = [[UIImage alloc] initWithCGImage:img.CGImage scale:scale orientation:UIImageOrientationUp];
        }else{
            self.image = nil;
        }
    }
    return self;
}
- (id)initWithFrame:(CGRect)nframe andImage:(UIImage *)img withScale:(CGFloat)scale andAlign:(UIImgAlignment)align{
    
    self = [super initWithFrame:nframe];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
//        NSRange r = [name rangeOfString:@".jpg"];
//        if (r.length>0) {
//            name = [name substringToIndex:r.location];
//            UIImage* img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"jpg"]];
//            self.image = [[UIImage alloc] initWithCGImage:img.CGImage scale:scale orientation:UIImageOrientationUp];
//        } else if([name length] != 0){
//            UIImage* img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"png"]];
//            self.image = [[UIImage alloc] initWithCGImage:img.CGImage scale:scale orientation:UIImageOrientationUp];
//        }else{
//            self.image = nil;
//        }
        self.image = img;
        if (self.image != nil) {
            CGSize imgSize = self.image.size;
            CGFloat my = nframe.size.height / nframe.size.width;
            CGFloat img = imgSize.height / imgSize.width;
            if (my > img) {
                CGFloat ih = nframe.size.height;
                CGFloat iw = imgSize.width * nframe.size.height / imgSize.height;
                switch (align) {
                    case UIImgAlignmentBottom:
                        self.frame = CGRectMake(nframe.size.width - iw, 0, iw, ih);
                        break;
                    case UIImgAlignmentCenter:
                        self.frame = CGRectMake((nframe.size.width - iw)/2.0, 0, iw, ih);
                        break;
                    case UIImgAlignmentTop:
                        self.frame = CGRectMake(0, 0, iw, ih);
                        break;
                    default:
                        break;
                }
            } else if (my < img) {
                CGFloat iw = nframe.size.width;
                CGFloat ih = imgSize.height * nframe.size.width / imgSize.width;
                switch (align) {
                    case UIImgAlignmentBottom:
                        self.frame = CGRectMake(0, nframe.size.height - ih, iw, ih);
                        break;
                    case UIImgAlignmentCenter:
                        self.frame = CGRectMake(0, (nframe.size.height - ih)/2.0, iw, ih);
                        break;
                    case UIImgAlignmentTop:
                        self.frame = CGRectMake(0, 0, iw, ih);
                        break;
                    default:
                        break;
                }
            }
        }
    }
    return self;
}
- (id)initWithFrame:(CGRect)nframe andImageName:(NSString *)name withScale:(CGFloat)scale andAlign:(UIImgAlignment)align{
    self = [self initWithFrame:nframe andImageName:name withScale:scale andAlign:align andBundleName:nil];
    if (self) {
        
    }
    return self;
}
- (id)initWithFrame:(CGRect)nframe andImageName:(NSString *)name withScale:(CGFloat)scale andAlign:(UIImgAlignment)align andBundleName:(NSString *)nbundle{
    
    self = [super initWithFrame:nframe];
    if (self) {
        NSBundle *bundle = [NSBundle mainBundle];
        if(nil != nbundle){
            bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:nbundle ofType:@"bundle"]];
        }
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        NSRange r = [name rangeOfString:@".jpg"];
        if (r.length>0) {
            name = [name substringToIndex:r.location];
            UIImage* img = [[UIImage alloc] initWithContentsOfFile:[bundle pathForResource:name ofType:@"jpg"]];
            self.image = [[UIImage alloc] initWithCGImage:img.CGImage scale:scale orientation:UIImageOrientationUp];
        } else if([name length] != 0){
            UIImage* img = [[UIImage alloc] initWithContentsOfFile:[bundle pathForResource:name ofType:@"png"]];
            self.image = [[UIImage alloc] initWithCGImage:img.CGImage scale:scale orientation:UIImageOrientationUp];
        }else{
            self.image = nil;
        }
        if (self.image != nil) {
            CGSize imgSize = self.image.size;
            CGFloat my = nframe.size.height / nframe.size.width;
            CGFloat img = imgSize.height / imgSize.width;
            if (my > img) {
                CGFloat ih = nframe.size.height;
                CGFloat iw = imgSize.width * nframe.size.height / imgSize.height;
                switch (align) {
                    case UIImgAlignmentBottom:
                        self.frame = CGRectMake(nframe.size.width - iw, 0, iw, ih);
                        break;
                    case UIImgAlignmentCenter:
                        self.frame = CGRectMake((nframe.size.width - iw)/2.0, 0, iw, ih);
                        break;
                    case UIImgAlignmentTop:
                        self.frame = CGRectMake(0, 0, iw, ih);
                        break;
                    default:
                        break;
                }
            } else if (my < img) {
                CGFloat iw = nframe.size.width;
                CGFloat ih = imgSize.height * nframe.size.width / imgSize.width;
                switch (align) {
                    case UIImgAlignmentBottom:
                        self.frame = CGRectMake(0, nframe.size.height - ih, iw, ih);
                        break;
                    case UIImgAlignmentCenter:
                        self.frame = CGRectMake(0, (nframe.size.height - ih)/2.0, iw, ih);
                        break;
                    case UIImgAlignmentTop:
                        self.frame = CGRectMake(0, 0, iw, ih);
                        break;
                    default:
                        break;
                }
            }
        }
    }
    return self;
}
+ (UIImage*)getShadowImage:(CGRect)bounds{
    UIGraphicsBeginImageContext(bounds.size);
    CGImageRef imgRef = NULL;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    size_t gradLocationsNum = 2;
    CGFloat gradLocations[2] = {0.0f, 0.50f};
    CGFloat gradColors[8] = {1.0f,1.0f,1.0f,1.0f,1.0f,1.0f,1.0f,0.0f};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
    CGColorSpaceRelease(colorSpace);
    
    //Gradient center
    CGPoint gradCenter= CGPointMake(bounds.size.width/2.0, bounds.size.height/2.0);
    //Gradient radius
    float gradRadius = MAX(bounds.size.width , bounds.size.height) ;
    //Gradient draw
    
    CGContextDrawRadialGradient (context, gradient, gradCenter,
                                 0, gradCenter, gradRadius,
                                 kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient);
    
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, bounds.size.width, bounds.size.height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
}
+ (UIImage*)getGradImage:(CGRect)bounds{
    UIGraphicsBeginImageContext(bounds.size);
    CGImageRef imgRef = NULL;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    size_t gradLocationsNum = 2;
    CGFloat gradLocations[2] = {0.0f, 0.50f};
    CGFloat gradColors[8] = {1.0f,1.0f,1.0f,1.0f,1.0f,1.0f,1.0f,0.0f};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
    CGColorSpaceRelease(colorSpace);
    
    //Gradient center
    CGPoint gradCenter= CGPointMake(bounds.size.width/2.0, bounds.size.height/2.0);
    //Gradient radius
    float gradRadius = MIN(bounds.size.width , bounds.size.height) ;
    //Gradient draw
    CGContextDrawRadialGradient (context, gradient, gradCenter,
                                 0, gradCenter, gradRadius,
                                 kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient);
    
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, bounds.size.width, bounds.size.height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
}
@end
