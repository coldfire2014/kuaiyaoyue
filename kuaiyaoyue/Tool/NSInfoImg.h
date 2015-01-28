//
//  NSInfoImg.h
//  picTest
//
//  Created by wuyangbing on 14-9-23.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSInfoImg : NSObject{
    NSString* _bgImgName;
    UIImage* _bgImg;
    NSMutableArray* _infoArr;
} 

- (id)initWithbgImagePath:(NSString *)imgPath;
- (void)addInfoWithValue:(NSString*)value andRect:(CGRect)rect andSize:(CGFloat)size andR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b andSingle:(BOOL) isSingle :(BOOL) isJZ;
- (UIImage*)getSaveImg :(BOOL) type;

+(NSString*)getFullTimeStr:(NSTimeInterval)time;
//中文日期
+ (NSString*)getXinqi:(NSTimeInterval)time;//星期三
+ (NSString*)getdatezh:(NSTimeInterval)time;//@"二〇一四年 十月一日";
+ (NSString*)nlWithint:(NSTimeInterval)time;//@“甲午年 九月 初八日”
+ (NSString*)gettimezh:(NSTimeInterval)time;//@"五点整"
@end
