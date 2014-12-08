//
//  UDObject.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "UDObject.h"


@implementation UDObject


+(NSString *)getOPEN{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"OPEN"];
}

+(void)setOPEN{
    [[NSUserDefaults standardUserDefaults] setValue:@"true" forKey:@"OPEN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
