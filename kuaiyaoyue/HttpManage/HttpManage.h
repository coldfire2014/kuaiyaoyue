//
//  HttpManage.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/3.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@interface AFSessionAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end

@interface AFConnectionAPIClient : AFHTTPRequestOperationManager

+ (instancetype)sharedClient;
- (instancetype)init;
@end

@interface AFConnectionAPIClientLogin : AFHTTPRequestOperationManager

+ (instancetype)sharedClient;
- (instancetype)init;
@end

@interface HttpManage : NSObject


//下载音乐
+(void)DownMusic:(NSString *) url filepath:(NSString *) filepath cb:(void(^)(BOOL isOK))callback;
//获取所有音乐列表
+(void)getAll:(NSString *)timestamp cb:(void(^)(BOOL isOK ,NSMutableArray *array))callback;
//注册
+(void)register:(NSString *)mobilePhone password:(NSString *)password cb:(void(^)(BOOL isOK ,NSMutableArray *array))callback;
//登出
+(void)logout:(NSString *)token cb:(void(^)(BOOL isOK ,NSMutableArray *array))callback;
//验证token是否有效
+(void)checkToken:(void(^)(BOOL isOK ,NSMutableArray *array))callback;


@end
