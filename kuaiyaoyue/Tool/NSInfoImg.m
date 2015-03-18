//
//  NSInfoImg.m//  picTest
//
//  Created by wuyangbing on 14-9-23.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

#import "NSInfoImg.h"
#import "myImageView.h"
#import <CoreText/CoreText.h>
#import "LunarCalendar.h"
#import "JBCalendar.h"

@implementation NSInfoImg
- (id)initWithbgImagePath:(NSString *)imgPath{
    self = [super init];
    if (self) {
        _bgImgName = imgPath;
//        UIImage* img = [[UIImage alloc] initWithContentsOfFile:_bgImgName];
//        _bgImg = [[UIImage alloc] initWithCGImage:img.CGImage scale:2.0 orientation:UIImageOrientationUp];
//        CGImageRef imgRef = _bgImg.CGImage;
        
        _bgImg = [[UIImage alloc] initWithContentsOfFile:_bgImgName];
        _infoArr = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)addInfoWithValue:(NSString*)value andRect:(CGRect)rect andSize:(CGFloat)size andR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b andSingle:(BOOL) isSingle :(BOOL) isJZ{
    NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:value,@"string",
                        [NSNumber numberWithFloat: rect.origin.x ],@"x",[NSNumber numberWithFloat:rect.origin.y],@"y",[NSNumber numberWithFloat: rect.size.width],@"width",[NSNumber numberWithFloat: rect.size.height],@"height",
                        [NSNumber numberWithFloat:r],@"r",[NSNumber numberWithFloat:g],@"g",[NSNumber numberWithFloat:b],@"b",
                        [NSNumber numberWithFloat:size],@"size",[NSNumber numberWithBool:isSingle],@"single",[NSNumber numberWithBool:isJZ],@"isjz",
                        nil];
    [_infoArr addObject:dic];
}
- (void)setText:(NSString*) text withRect:(CGRect)rect andSize:(CGFloat)size andColor:(UIColor*)color to:(UIImageView*) context inSingle:(BOOL) single :(BOOL)isJZ{
    
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.text = text;
//    label.font = [UIFont fontWithName:@"MicrosoftYaHei" size:size];//
    label.font = [UIFont systemFontOfSize:size];//
    label.backgroundColor = [UIColor clearColor];
//    label.backgroundColor = [UIColor blackColor];
    label.textColor = color;
    if (single) {
        label.numberOfLines = 1;
    } else {
        label.numberOfLines = 0;
    }
    if (isJZ) {
        label.textAlignment = NSTextAlignmentCenter;
    }else{
        [label sizeToFit];
        label.textAlignment = NSTextAlignmentLeft;
    }

    [context addSubview:label];
}

- (void)setText1:(NSString*) text withRect:(CGRect)rect andSize:(CGFloat)size andColor:(UIColor*)color to:(UIImageView*) context inSingle:(BOOL) single :(BOOL)isJZ{
    
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.text = text;
    //    label.font = [UIFont fontWithName:@"MicrosoftYaHei" size:size];//
    label.font = [UIFont systemFontOfSize:size];//
    label.backgroundColor = [UIColor clearColor];
    //    label.backgroundColor = [UIColor blackColor];
    label.textColor = color;
    if (single) {
        label.numberOfLines = 1;
    } else {
        label.numberOfLines = 0;
    }
    if (isJZ) {
        [label sizeToFit];
//        label.textAlignment = NSTextAlignmentCenter;
        label.center = CGPointMake(320, label.center.y);
    }else{
        [label sizeToFit];
        label.textAlignment = NSTextAlignmentLeft;
    }
    
    [context addSubview:label];
}



- (UIImage*)getSaveImg :(BOOL) type{
    CGImageRef imgRef = _bgImg.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGRect bounds = CGRectMake(0, 0, width, height);
    
    UIImageView* iv = [[UIImageView alloc] initWithFrame:bounds];
//    float tr = 0.0;
//    float tg = 0.0;
//    float tb = 0.0;
    
//    float qto = 0.0;
//    float qtw = 0.0;
    
    iv.image = _bgImg;
    for (int i = 0; i<_infoArr.count; i++) {
        NSDictionary *dic = [_infoArr objectAtIndex:i];
        NSNumber* x = (NSNumber*)[dic valueForKey:@"x"];
        NSNumber* y = (NSNumber*)[dic valueForKey:@"y"];
        
//        if (i == 1) {
//            qto = [y floatValue];
//        }else if (i == 2){
//            qtw = [y floatValue];
//        }
        
        NSNumber* width = (NSNumber*)[dic valueForKey:@"width"];
        NSNumber* height = (NSNumber*)[dic valueForKey:@"height"];
        NSNumber* size = (NSNumber*)[dic valueForKey:@"size"];
//         NSNumber* size = (NSNumber*)@"49";
        NSNumber* r = (NSNumber*)[dic valueForKey:@"r"];
        NSNumber* g = (NSNumber*)[dic valueForKey:@"g"];
        NSNumber* b = (NSNumber*)[dic valueForKey:@"b"];
//        tr = [r floatValue];
//        tg = [g floatValue];
//        tb = [b floatValue];
        NSString* text = [dic valueForKey:@"string"];
        NSNumber* single = (NSNumber*)[dic valueForKey:@"single"];
        NSNumber* isjz = (NSNumber*)[dic valueForKey:@"isjz"];
        
        
        if ([text compare:@"<"] == NSOrderedSame || [text compare:@">"] == NSOrderedSame ) {
            [self setText:text withRect:CGRectMake([x floatValue], [y floatValue], [width floatValue], [height floatValue]) andSize:[size floatValue] andColor:[UIColor colorWithRed:[r floatValue]/255.0 green:[g floatValue]/255.0 blue:[b floatValue]/255.0 alpha:1] to:iv inSingle:[single boolValue] :[isjz boolValue]];
        }else{
            [self setText1:text withRect:CGRectMake([x floatValue], [y floatValue], [width floatValue], [height floatValue]) andSize:[size floatValue] andColor:[UIColor colorWithRed:[r floatValue]/255.0 green:[g floatValue]/255.0 blue:[b floatValue]/255.0 alpha:1] to:iv inSingle:[single boolValue] :[isjz boolValue]];
        }
        
        
        
        
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [iv.layer renderInContext:context];
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;

}
//定下字体后用label得到字的高宽，然后去算具体怎么换行
//-(void)setText:(NSString*) text withX:(CGFloat)x andY:(CGFloat)y andSize:(CGFloat)size andR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b to:(CGContextRef) context{
//    
//    UniChar *characters;
//    CGGlyph *glyphs;
//    CFIndex count;
//    
//    CTFontRef ctFont = CTFontCreateWithName(CFSTR("STHeitiSC-Light"), size, NULL);
//    CTFontDescriptorRef ctFontDesRef = CTFontCopyFontDescriptor(ctFont);
//    CGFontRef cgFont = CTFontCopyGraphicsFont(ctFont,&ctFontDesRef );
//    CGContextSetFont(context, cgFont);
//    CFNumberRef pointSizeRef = (CFNumberRef)CTFontDescriptorCopyAttribute(ctFontDesRef,kCTFontSizeAttribute);
//    CGFloat fontSize;
//    CFNumberGetValue(pointSizeRef, kCFNumberCGFloatType,&fontSize);
//    CGContextSetFontSize(context, fontSize);
//    count = CFStringGetLength((CFStringRef)text);
//    characters = (UniChar *)malloc(sizeof(UniChar) * count);
//    glyphs = (CGGlyph *)malloc(sizeof(CGGlyph) * count);
//    CFStringGetCharacters((CFStringRef)text, CFRangeMake(0, count), characters);
//    CTFontGetGlyphsForCharacters(ctFont, characters, glyphs, count);
//    CGContextSetRGBFillColor (context, r/255.0, g/255.0, b/255.0, 1);
////    CGContextSetTextDrawingMode();
//    CGContextShowGlyphsAtPoint(context, x, y, glyphs, text.length);
//    
//    free(characters);
//    free(glyphs);
//}

#pragma 中文时间
+(NSString*)getFullTimeStr:(NSTimeInterval)time{
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
    
    NSString * string=[NSString stringWithFormat:@"%04ld年%02ld月%02ld日 星期%@ %02ld:%02ld",(long)[component year],(long)[component month],(long)[component day],daystr,(long)[component hour],(long)[component minute]];
    return string;
}
+ (NSString*)getXinqi:(NSTimeInterval)time{
    NSString* data = [NSInfoImg getFullTimeStr:time];
    NSArray* arr = [data componentsSeparatedByString:@" "];
    return [arr objectAtIndex:1];
}
+ (NSString*)getdatezh:(NSTimeInterval)time{
    NSString* data = [NSInfoImg getFullTimeStr:time];
    NSArray* arr = [data componentsSeparatedByString:@" "];
    NSString* string = [arr objectAtIndex:0];
    //    NSRange rs = [string r];
    NSString* min = @"";
    NSArray* tarr = [string componentsSeparatedByString:@"-"];
    NSString* mstring = [tarr objectAtIndex:1];
    NSString* dstring = [tarr objectAtIndex:2];
    NSString* ystring = [tarr objectAtIndex:0];
    
    min = [[NSString alloc] initWithFormat:@"%@年%@月%@日",[self YzhWithint:ystring],[self zhWithint:mstring],[self zhWithint:dstring]];
    return min;
}

+ (NSString*)gettimezh:(NSTimeInterval)time{
    NSString* data = [NSInfoImg getFullTimeStr:time];
    NSArray* arr = [data componentsSeparatedByString:@" "];
    NSString* string = [arr objectAtIndex:2];
    //    NSRange rs = [string r];
    NSString* min = @"";
    NSArray* tarr = [string componentsSeparatedByString:@":"];
    NSString* mstring = [tarr objectAtIndex:1];
    NSString* hstring = [tarr objectAtIndex:0];
    NSRange r = [string rangeOfString:@":00"];
    if (r.length>0) {
        min = [[NSString alloc] initWithFormat:@"%@点整",[self zhWithint:hstring]];//"一二三四五六七八九十〇"
    }else{
        min = [[NSString alloc] initWithFormat:@"%@点%@分",[self zhWithint:hstring],[self zhWithint:mstring]];
    }
    return min;
}
+ (NSString*)int2zh:(int)num{
    NSString* min = @"";
    switch (num) {
        case 0:
            min = @"〇";
            break;
        case 1:
            min = @"一";
            break;
        case 2:
            min = @"二";
            break;
        case 3:
            min = @"三";
            break;
        case 4:
            min = @"四";
            break;
        case 5:
            min = @"五";
            break;
        case 6:
            min = @"六";
            break;
        case 7:
            min = @"七";
            break;
        case 8:
            min = @"八";
            break;
        case 9:
            min = @"九";
            break;
        case 10:
            min = @"十";
            break;
        default:
            break;
    }
    return min;
}
+ (NSString*)YzhWithint:(NSString*)num_str{
    NSMutableString* arr = [[NSMutableString alloc] init];
    for (int i = 0;i<num_str.length;i++) {
        NSString* num = [num_str substringWithRange:NSMakeRange(i,1)];
        [arr appendString:[self int2zh:[num intValue]]];
    }
    return arr;
}
+ (NSString*)zhWithint:(NSString*)num_str{
    int scannedNumber;
    NSScanner *scanner = [NSScanner scannerWithString:num_str];
    [scanner scanInt:&scannedNumber];
    NSMutableString* min = [[NSMutableString alloc] init];
    if (scannedNumber <= 10) {
        [min appendString: [self int2zh:scannedNumber]];
    } else {
        int a = scannedNumber / 10;
        int b = scannedNumber % 10;
        if (b == 0) {
            [min appendFormat:@"%@十",[self int2zh:a]];
        } else {
            [min appendFormat:@"%@十%@",[self int2zh:a],[self int2zh:b]];
        }
    }
    return min;
}
+ (NSString*)nlWithint:(NSTimeInterval)time{
    NSString* data = [NSInfoImg getFullTimeStr:time];
    NSArray* arr = [data componentsSeparatedByString:@" "];
    NSString* string = [arr objectAtIndex:0];
    
    NSArray* tarr = [string componentsSeparatedByString:@"-"];
    NSString* mstring = [tarr objectAtIndex:1];
    NSString* dstring = [tarr objectAtIndex:2];
    NSString* ystring = [tarr objectAtIndex:0];
    
    JBCalendar* date = [[JBCalendar alloc] init];
    date.year = [ystring intValue];
    date.month =[mstring intValue];
    date.day = [dstring intValue];
    LunarCalendar *lunarCalendar = [[date nsDate] chineseCalendarDate];
    NSString * lunar = [[NSString alloc]initWithFormat:
                        @"%@ %@ 年 %@ %@",lunarCalendar.YearHeavenlyStem,lunarCalendar.YearEarthlyBranch,lunarCalendar.MonthLunar,lunarCalendar.DayLunar];
    return lunar;
    //    return string;
}
@end
