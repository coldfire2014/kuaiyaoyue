//
//  UDObject.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "UDObject.h"

static  NSUserDefaults *userInfo = nil;

@implementation UDObject

- (id)init {
    self = [super init];
    if (self) {
        if (userInfo == nil) {
            userInfo = [NSUserDefaults standardUserDefaults];
        }
    }
    return self;
}

+(NSString *)getOPEN{
    return [userInfo objectForKey:@"OPEN"];
}

+(void)setOPEN{
    [userInfo setValue:@"true" forKey:@"OPEN"];
    [userInfo synchronize];
}

@end
