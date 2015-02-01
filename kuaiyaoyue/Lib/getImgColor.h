//
//  getImgColor.h
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/2/1.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@interface getImgColor : NSObject
+ (NSArray*)getRGBAsFromImage:(UIImage*)image atX:(int)x andY:(int)y count:(int)count;

@end
