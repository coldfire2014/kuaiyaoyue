

//
//  TimeTool.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/15.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "TimeTool.h"

@implementation TimeTool

+(NSString *)TopJZTime:(long) jztime{
    
    NSDate * date = [NSDate date];
    long newtime = (long)[date timeIntervalSince1970];
    
    
    
    
    return nil;
}

+(NSString*)getFullTimeStr:(long long)time{
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    int weekday= [component weekday];
    
    NSString * daystr=nil;
    switch (weekday) {
        case 1:
            daystr=@"日";
            break;
        case 2:
            daystr=@"一";
            break;
        case 3:
            daystr=@"二";
            break;
        case 4:
            daystr=@"三";
            break;
        case 5:
            daystr=@"四";
            break;
        case 6:
            daystr=@"五";
            break;
        case 7:
            daystr=@"六";
            break;
        default:
            break;
    }
    
    NSString * string=[NSString stringWithFormat:@"%04d-%02d-%02d  %02d:%02ld:%02ld",[component year],[component month],[component day],[component hour],(long)[component minute],(long)[component second]];
    return string;
}

@end
