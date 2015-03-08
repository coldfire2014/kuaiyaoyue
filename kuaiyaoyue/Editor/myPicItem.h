//
//  myPicItem.h
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/2/28.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AssetHelper.h"

@interface myPicItem : UIView
@property (nonatomic,retain) NSString* fileName;
@property (nonatomic) BOOL uploaded;
@property (nonatomic,retain) NSString* localName;
- (instancetype)initWithFrame:(CGRect)rect fromAsset:(ALAsset*)al andThumb:(UIImage*)img orFile:(NSString*)fileName;
-(UIImage*)myImage;
@end
