

//
//  TimeTool.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/15.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "TimeTool.h"

@implementation TimeTool

+(NSString *)TopJZTime:(NSDate*) jzdate{
    NSDate* today = [NSDate date];
    NSTimeInterval tt = [today timeIntervalSince1970];
    NSTimeInterval dt = [jzdate timeIntervalSince1970];
    double cha = dt-tt;
    NSString* timetext;
    if (cha<=0) {
        timetext = @"已截止";
    } else if (cha<60) {
//        int a = cha;
        timetext = @"即将截止";
    }else if (cha<60*60) {
        int a = cha/60;
        int b = cha - a*60;
        timetext = [NSString stringWithFormat:@"剩余%d分%d秒",a,b];
    } else if (cha<60*60*24) {
        int a = cha/60/60;
        int b = cha - a*60*60;
        b=b/60;
//        timetext = [NSString stringWithFormat:@"%d小时前",a];
        timetext = [NSString stringWithFormat:@"剩余%d小时%d分",a,b];
    } else if (cha<60*60*24*30) {
        int a = cha/60/60/24;
        int b = cha - a*60*60*24;
        b=b/60/60;
//        timetext = [NSString stringWithFormat:@"%d天前",a];
        timetext = [NSString stringWithFormat:@"剩余%d天零%d小时",a,b];
    }
    else if (cha<60*60*24*30*12) {
        int a = cha/60/60/24/30;
        int b = cha - a*60*60*24*30;
        b=b/60/60/24;
//        timetext = [NSString stringWithFormat:@"%d个月前",a];
        timetext = [NSString stringWithFormat:@"剩余%d月%d天",a,b];
    }
    else {
        timetext = @"还有很久";
    }
    return timetext;
    
}

+(NSString*)getFullTimeStr:(long long)time{
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    NSInteger weekday= [component weekday];
    
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
    
//    NSString * string=[NSString stringWithFormat:@"%04d/%02d/%02d %02d:%02ld:%02ld",[component year],[component month],[component day],[component hour],(long)[component minute],(long)[component second]];
    NSString * string=[NSString stringWithFormat:@"%04ld-%02ld-%02ld %02ld:%02ld",(long)[component year],(long)[component month],(long)[component day],(long)[component hour],(long)[component minute]];
    return string;
}

@end
