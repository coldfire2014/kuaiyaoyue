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



@end