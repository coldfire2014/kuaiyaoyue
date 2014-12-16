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

+(void)setUserInfo:(NSString *) Account userName:(NSString *) userName token:(NSString *)token{
    [[NSUserDefaults standardUserDefaults] setValue:Account forKey:@"Account"];
    [[NSUserDefaults standardUserDefaults] setValue:userName forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] setValue:token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void) setTSID:(NSString *) tsid{
    [[NSUserDefaults standardUserDefaults] setValue:tsid forKey:@"tsid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)getTSID{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"tsid"];
}

+(NSString *)getAccount{
   return [[NSUserDefaults standardUserDefaults] objectForKey:@"Account"];
}

+(NSString *)getuserName{
   return [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
}

+(NSString *)gettoken{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
}

@end
