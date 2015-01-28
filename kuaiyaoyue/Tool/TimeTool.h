//
//  TimeTool.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/15.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeTool : NSObject

+(NSString *)TopJZTime:(NSDate*) jzdate;

+(NSString*)getFullTimeStr:(NSTimeInterval)time;

@end
