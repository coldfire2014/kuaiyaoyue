//
//  UDObject.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "UDObject.h"

@implementation UDObject

+(void)setXM:(NSString *)xm{
    [[NSUserDefaults standardUserDefaults] setValue:xm forKey:@"XM"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)getXM{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"XM"];
}
+(void)setLXFS:(NSString *)lxfs{
    [[NSUserDefaults standardUserDefaults] setValue:lxfs forKey:@"LXFS"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)getLXFS{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"LXFS"];
}
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
+(void) setYLID:(NSString *) ylid{
    [[NSUserDefaults standardUserDefaults] setValue:ylid forKey:@"ylid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)getYLID{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"ylid"];
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

+(void)setWLContent:(NSString *)wljh_name wltime:(NSString *)wltime wlbmendtime:(NSString *)wlbmendtime wladdress_name :(NSString *)wladdress_name wllxr_name:(NSString *)wllxr_name wllxfs_name:(NSString *) wllxfs_name wlts_name:(NSString *)wlts_name wlmusicname:(NSString *)wlmusicname wlmusic:(NSString *)wlmusic wlimgarr:(NSString *)wlimgarr{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setValue:wljh_name forKey:@"wljh_name"];
    [userInfo setValue:wltime forKey:@"wltime"];
    [userInfo setValue:wlbmendtime forKey:@"wlbmendtime"];
    [userInfo setValue:wladdress_name forKey:@"wladdress_name"];
    [userInfo setValue:wllxr_name forKey:@"wllxr_name"];
    [userInfo setValue:wllxfs_name forKey:@"wllxfs_name"];
    [userInfo setValue:wlts_name forKey:@"wlts_name"];
    [userInfo setValue:wlmusic forKey:@"wlmusic"];
    [userInfo setValue:wlmusicname forKey:@"wlmusicname"];
    [userInfo setValue:wlimgarr forKey:@"wlimgarr"];
    [userInfo synchronize];
}

+(NSString *)getwljh_name{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"wljh_name"];
}
+(NSString *)gewltime{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"wltime"];
}
+(NSString *)getwlbmendtime{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"wlbmendtime"];
}
+(NSString *)getwladdress_name{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"wladdress_name"];
}
+(NSString *)getwllxr_name{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"wllxr_name"];
}
+(NSString *)getwllxfs_name{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"wllxfs_name"];
}
+(NSString *)getwlts_name{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"wlts_name"];
}
+(NSString *)getwlaudio{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"wlaudio"];
}
+(NSString *)getwlmusic{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"wlmusic"];
}
+(NSString *)getwlmusicname{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"wlmusicname"];
}
+(NSString *)getwlimgarr{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"wlimgarr"];
}

+(void)setZDYContent:(NSString *) zdytopimg zdytitle:(NSString *)zdytitle zdydd:(NSString *)zdydd zdytime:(NSString *)zdytime zdyendtime:(NSString *)zdyendtime zdymusic:(NSString *)zdymusic zdymusicname:(NSString *)zdymusicname zdyimgarr:(NSString *)zdyimgarr{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setValue:zdytopimg forKey:@"zdytopimg"];
    [userInfo setValue:zdytitle forKey:@"zdytitle"];
    [userInfo setValue:zdydd forKey:@"zdydd"];
    [userInfo setValue:zdytime forKey:@"zdytime"];
    [userInfo setValue:zdyendtime forKey:@"zdyendtime"];
    [userInfo setValue:zdymusic forKey:@"zdymusic"];
    [userInfo setValue:zdymusicname forKey:@"zdymusicname"];
    [userInfo setValue:zdyimgarr forKey:@"zdyimgarr"];
    [userInfo synchronize];
}
+(NSString *)getzdytopimg{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"zdytopimg"];
}
+(NSString *)getzdytitle{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"zdytitle"];
}
+(NSString *)getzdydd{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"zdydd"];
}
+(NSString *)getzdytime{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"zdytime"];
}
+(NSString *)getzdyendtime{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"zdyendtime"];
}
+(NSString *)getzdymusic{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"zdymusic"];
}
+(NSString *)getzdymusicname{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"zdymusicname"];
}
+(NSString *)getzdyimgarr{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"zdyimgarr"];
}
+(NSString *)getTimestamp{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"Timestamp"];
}
+(void)setTimestamp:(NSString *)time_s{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setValue:time_s forKey:@"Timestamp"];
    [userInfo synchronize];
}
+(NSString*)getQNToken{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"QNToken"];
}
+(void)setQNToken:(NSString *)qnToken{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setValue:qnToken forKey:@"QNToken"];
    [userInfo synchronize];
}

+(NSString*)getHLupload{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"hlupload"];
}
+(void)setHLupload:(NSString*)hlupload{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setValue:hlupload forKey:@"hlupload"];
    [userInfo synchronize];
}
+(NSString*)getSWupload{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"swupload"];
}
+(void)setSWupload:(NSString*)swupload{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setValue:swupload forKey:@"swupload"];
    [userInfo synchronize];
}
+(NSString*)getWLupload{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"wlupload"];
}
+(void)setWLupload:(NSString*)wlupload{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setValue:wlupload forKey:@"wlupload"];
    [userInfo synchronize];
}
+(NSString*)getZDYupload{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"zdyupload"];
}
+(void)setZDYupload:(NSString*)zdyupload{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setValue:zdyupload forKey:@"zdyupload"];
    [userInfo synchronize];
}
+(void)sethltempIndex:(NSInteger)index{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setValue:[NSNumber numberWithInteger:index] forKey:@"hltempIndex"];
    [userInfo synchronize];
}
+(void)sethdtempIndex:(NSInteger)index{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setValue:[NSNumber numberWithInteger:index] forKey:@"hdtempIndex"];
    [userInfo synchronize];
}
+(void)setswtempIndex:(NSInteger)index{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setValue:[NSNumber numberWithInteger:index] forKey:@"swtempIndex"];
    [userInfo synchronize];
}
+(NSInteger)gethltempIndex{
    NSNumber* num = [[NSUserDefaults standardUserDefaults] objectForKey:@"hltempIndex"];
    if (num == nil) {
        return 0;
    } else {
        return [num integerValue];
    }
}
+(NSInteger)gethdtempIndex{
    NSNumber* num = [[NSUserDefaults standardUserDefaults] objectForKey:@"hdtempIndex"];
    if (num == nil) {
        return 0;
    } else {
        return [num integerValue];
    }
}
+(NSInteger)getswtempIndex{
    NSNumber* num = [[NSUserDefaults standardUserDefaults] objectForKey:@"swtempIndex"];
    if (num == nil) {
        return 0;
    } else {
        return [num integerValue];
    }
}
@end
