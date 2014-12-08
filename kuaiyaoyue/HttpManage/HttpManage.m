//
//  HttpManage.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/3.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "HttpManage.h"

#define HTTPURL @"http://115.29.11.57"
/*
43    //BadCredentialsException     密码不正确
53    VerificationTimeoutException    验证码超时
54    BadValidateCodeException    验证码不正确
63    NoRecordsException         记录不存在
64    RecordDuplicateException    记录重复
74    BalanceInsuffcientException   余额不足
84    To cancel the solicitation    邀约已经取消
 */



static NSString * const APIBaseURLString = HTTPURL;

@implementation AFSessionAPIClient

+ (instancetype)sharedClient {
    static AFSessionAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFSessionAPIClient alloc] initWithBaseURL:[NSURL URLWithString:APIBaseURLString]];
        //        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

@end

@implementation AFConnectionAPIClient

+ (instancetype)sharedClient {
    static AFConnectionAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFConnectionAPIClient alloc] initWithBaseURL:[NSURL URLWithString:APIBaseURLString]];
        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}
- (instancetype)init{
    AFConnectionAPIClient *client = [[AFConnectionAPIClient alloc] initWithBaseURL:[NSURL URLWithString:APIBaseURLString]];
    client.requestSerializer = [AFJSONRequestSerializer serializer];
    client.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    return client;
}
@end

@implementation AFConnectionAPIClientLogin

+ (instancetype)sharedClient {
    static AFConnectionAPIClientLogin *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFConnectionAPIClientLogin alloc] initWithBaseURL:[NSURL URLWithString:APIBaseURLString]];
        //        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

- (instancetype)init{
    AFConnectionAPIClientLogin *client = [[AFConnectionAPIClientLogin alloc] initWithBaseURL:[NSURL URLWithString:APIBaseURLString]];
    client.requestSerializer = [AFJSONRequestSerializer serializer];
    client.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    return client;
}

@end

@implementation HttpManage

//下载音乐

+(void)DownMusic:(NSString *) url filepath:(NSString *) filepath cb:(void(^)(BOOL isOK))callback{
    
    //下载图片
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFURLConnectionOperation *operation =   [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:filepath append:NO];
    [operation setCompletionBlock:^{
        callback(YES);
    }];
    [operation start];
}

+(void)getAll:(NSString *)timestamp cb:(void(^)(BOOL isOK ,NSMutableArray *array))callback{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            timestamp,@"timestamp",nil];
    NSLog(@"params-%@",params);
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPURL,@"/invitation/nozzle/NefMusic/getAll.aspx"];
    [[AFConnectionAPIClient sharedClient] POST:url parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        NSString *html = operation.responseString;
        NSData* resData=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        callback(YES,array);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSLog(@"error-%@",error);
        callback(NO,nil);
        
    }];
}

/*
注册
unquieId:”1”,                         //用户编号
mobilePhone:”18557164825”,           //手机号
integral:100                         //用户初始积分
 */
+(void)register:(NSString *)mobilePhone password:(NSString *)password cb:(void(^)(BOOL isOK ,NSMutableArray *array))callback{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            mobilePhone,@"mobilePhone",password,@"password",nil];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPURL,@"invitation/nozzle/NefUser/register.aspx"];
    [[AFConnectionAPIClient sharedClient] POST:url parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        NSString *html = operation.responseString;
        NSData* resData=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        callback(YES,array);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSLog(@"error-%@",error);
        callback(NO,nil);
    }];
}

/*
 登出
 {
 result:"success"
 }
 */
+(void)logout:(NSString *)token cb:(void(^)(BOOL isOK ,NSMutableArray *array))callback{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            token,@"token",nil];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPURL,@"invitation/nozzle/NefToken/logout.aspx"];
    [[AFConnectionAPIClient sharedClient] POST:url parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        NSString *html = operation.responseString;
        NSData* resData=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        callback(YES,array);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSLog(@"error-%@",error);
        callback(NO,nil);
    }];
}

/*
 检查checktoken有效
 
 
 */
+(void)checkToken:(void(^)(BOOL isOK ,NSMutableArray *array))callback{

}



@end
