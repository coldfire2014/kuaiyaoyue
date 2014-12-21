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



@end