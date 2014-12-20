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

+(void)setmbscbg:(NSString *)name{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setValue:name forKey:@"bdbg"];
    [userInfo synchronize];
}


+(NSString *)getmbscbg{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"bdbg"];
}

+(void)setHLContent:(NSString *) xl_name xn_name:(NSString *)xn_name hltime:(NSString *)hltime bmendtime:(NSString *)bmendtime address_name:(NSString *)address_name{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setValue:xl_name forKey:@"xl_name"];
    [userInfo setValue:xn_name forKey:@"xn_name"];
    [userInfo setValue:hltime forKey:@"hltime"];
    [userInfo setValue:bmendtime forKey:@"bmendtime"];
    [userInfo setValue:address_name forKey:@"address_name"];
    [userInfo synchronize];
}

+(NSString *)getxl_name{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"xl_name"];
}
+(NSString *)getxn_name{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"xn_name"];
}
+(NSString *)gethltime{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"hltime"];
}
+(NSString *)getbmendtime{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"bmendtime"];
}
+(NSString *)getaddress_name{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"address_name"];
}


@end
