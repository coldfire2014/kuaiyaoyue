//
//  UDObject.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UDObject : NSObject

+(NSString *) getOPEN;
+(void)setOPEN;

+(void)setUserInfo:(NSString *) Account userName:(NSString *) userName token:(NSString *)token;
+(NSString *)getAccount;
+(NSString *)getuserName;
+(NSString *)gettoken;

+(void) setTSID:(NSString *) tsid;
+(NSString *)getTSID;

//模板生成背景
+(void)setmbscbg:(NSString *)name;
+(NSString *)getmbscbg;

+(void)setWebUrl:(NSString *)index;
+(NSString *)getWebUrl;

+(void)setMbimg:(NSString *)name;
+(NSString *)getMbimg;

+(void)sethl_imgarr:(NSString *)imgarr;

//婚礼存储
+(void)setHLContent:(NSString *) xl_name xn_name:(NSString *)xn_name hltime:(NSString *)hltime bmendtime:(NSString *)bmendtime address_name:(NSString *)address_name music:(NSString *)music musicname:(NSString *)musicname imgarr:(NSString *)imgarr;
+(NSString *)getxl_name;
+(NSString *)getxn_name;
+(NSString *)gethltime;
+(NSString *)getbmendtime;
+(NSString *)getaddress_name;
+(NSString *)gethlmusic;
+(NSString *)gethlmusicname;
+(NSString *)gethlimgarr;

//商务存储
+(void)setSWContent:(NSString *)jh_name swtime:(NSString *)swtime swbmendtime:(NSString *)swbmendtime address_name:(NSString *)address_name swxlr_name:(NSString *)swxlr_name swxlfs_name:(NSString *)swxlfs_name swhd_name:(NSString *)swhd_name music:(NSString *)music musicname:(NSString *)musicname
    imgarr:(NSString *)imgarr;
+(NSString *)getjhname;
+(NSString *)getswtime;
+(NSString *)getswbmendtime;
+(NSString *)getswaddress_name;
+(NSString *)getswxlr_name;
+(NSString *)getswxlfs_name;
+(NSString *)getswhd_name;
+(NSString *)getsw_music;
+(NSString *)getsw_musicname;
+(NSString *)getsw_imgarr;

//吃喝玩乐
+(void)setWLContent:(NSString *)wljh_name wltime:(NSString *)wltime wlbmendtime:(NSString *)wlbmendtime wladdress_name :(NSString *)wladdress_name wllxr_name:(NSString *)wllxr_name wllxfs_name:(NSString *) wllxfs_name wlts_name:(NSString *)wlts_name wlaudio:(NSString *)wlaudio wlimgarr:(NSString *)wlimgarr;
+(NSString *)getwljh_name;
+(NSString *)gewltime;
+(NSString *)getwlbmendtime;
+(NSString *)getwladdress_name;
+(NSString *)getwllxr_name;
+(NSString *)getwllxfs_name;
+(NSString *)getwlts_name;
+(NSString *)getwlaudio;
+(NSString *)getwlimgarr;

@end