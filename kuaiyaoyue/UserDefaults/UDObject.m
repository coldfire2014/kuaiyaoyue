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

+(void)setWebUrl:(NSString *)index{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setValue:index forKey:@"weburl"];
    [userInfo synchronize];
}

+(NSString *)getWebUrl{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"weburl"];
}

+(void)setMbimg:(NSString *)name{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setValue:name forKey:@"mbimg"];
    [userInfo synchronize];
}

+(NSString *)getMbimg{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"mbimg"];
}

+(void)sethl_imgarr:(NSString *)imgarr{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setValue:imgarr forKey:@"hl_imgarr"];
    [userInfo synchronize];
}

+(void)setHLContent:(NSString *) xl_name xn_name:(NSString *)xn_name hltime:(NSString *)hltime bmendtime:(NSString *)bmendtime address_name:(NSString *)address_name music:(NSString *)music musicname:(NSString *)musicname imgarr:(NSString *)imgarr{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setValue:xl_name forKey:@"xl_name"];
    [userInfo setValue:xn_name forKey:@"xn_name"];
    [userInfo setValue:hltime forKey:@"hltime"];
    [userInfo setValue:bmendtime forKey:@"bmendtime"];
    [userInfo setValue:address_name forKey:@"address_name"];
    [userInfo setValue:music forKey:@"hl_music"];
    [userInfo setValue:musicname forKey:@"hl_musicname"];
    [userInfo setValue:imgarr forKey:@"hl_imgarr"];
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
+(NSString *)gethlmusic{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"hl_music"];
}
+(NSString *)gethlmusicname{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"hl_musicname"];
}

+(NSString *)gethlimgarr{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"hl_imgarr"];
}

+(void)setSWContent:(NSString *)jh_name swtime:(NSString *)swtime swbmendtime:(NSString *)swbmendtime address_name:(NSString *)address_name swxlr_name:(NSString *)swxlr_name swxlfs_name:(NSString *)swxlfs_name swhd_name:(NSString *)swhd_name music:(NSString *)music musicname:(NSString *)musicname
             imgarr:(NSString *)imgarr{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setValue:jh_name forKey:@"swjhname"];
    [userInfo setValue:swtime forKey:@"swtime"];
    [userInfo setValue:swbmendtime forKey:@"swbmendtime"];
    [userInfo setValue:address_name forKey:@"swaddress_name"];
    [userInfo setValue:swxlr_name forKey:@"swxlr_name"];
    [userInfo setValue:swxlfs_name forKey:@"swxlfs_name"];
    [userInfo setValue:swhd_name forKey:@"swhd_name"];
    [userInfo setValue:music forKey:@"sw_music"];
    [userInfo setValue:musicname forKey:@"sw_musicname"];
    [userInfo setValue:imgarr forKey:@"sw_imgarr"];
    [userInfo synchronize];
}
+(NSString *)getjhname{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"swjhname"];
}
+(NSString *)getswtime{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"swtime"];
}
+(NSString *)getswbmendtime{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"swbmendtime"];
}
+(NSString *)getswaddress_name{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"swaddress_name"];
}
+(NSString *)getswxlr_name{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"swxlr_name"];
}
+(NSString *)getswxlfs_name{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"swxlfs_name"];
}
+(NSString *)getswhd_name{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"swhd_name"];
}
+(NSString *)getsw_music{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"sw_music"];
}
+(NSString *)getsw_musicname{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"sw_musicname"];
}
+(NSString *)getsw_imgarr{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"sw_imgarr"];
}

@end
