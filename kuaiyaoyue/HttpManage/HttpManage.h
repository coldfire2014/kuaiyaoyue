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
//解压文件
+ (void)unzip:(NSString*)filePath filename:(NSString *) filename;
//下载ZIP包
+ (void)postdownload :(NSString *)URL :(NSString *)zipname;

//下载音乐
+(void)DownMusic:(NSString *) url filepath:(NSString *) filepath cb:(void(^)(BOOL isOK))callback;
//获取所有音乐列表
+(void)getAll:(NSString *)timestamp cb:(void(^)(BOOL isOK ,NSMutableArray *array))callback;
//注册
+(void)register:(NSString *)mobilePhone password:(NSString *)password cb:(void(^)(BOOL isOK ,NSMutableArray *array))callback;
//用户登录
+(void)j_spring_security_check:(NSString *)mobilePhone
                      password:(NSString *)password
                       phoneId:(NSString *)phoneId
                    j_username:(NSString *)j_username
                    j_password:(NSString *)j_password
                        isJson:(NSString *)isJson
                    cb:(void(^)(BOOL isOK ,NSDictionary *array))callback;
//第三方注册登录接口
+(void)registers:(NSString *)userName
         userPwd:(NSString *)userPwd
         phoneId:(NSString *)phoneId
          openId:(NSString *)openId
              cb:(void(^)(BOOL isOK ,NSDictionary *array))callback;

//登出
+(void)logout:(NSString *)token cb:(void(^)(BOOL isOK ,NSDictionary *array))callback;

//修改密码
+(void)appeal:(NSString *)mobilePhone
     password:(NSString *)password
       oldPwd:(NSString *)oldPwd
           cb:(void(^)(BOOL isOK ,NSDictionary *array))callback;

//忘记密码
+(void)forget: (void(^)(BOOL isOK ,NSDictionary *array))callback;


//验证token是否有效
+(void)checkToken:(NSString *)token cb:(void(^)(BOOL isOK ,NSDictionary *array))callback;
//模板查询
+(void)template:(NSString *)timestamp
                size:(NSString *)size
                cb:(void(^)(BOOL isOK ,NSMutableArray *array))callback;
//更新模板
+(void)templateRenewal:(NSString *)timestamp cb:(void(^)(BOOL isOK ,NSMutableArray *array))callback;
//婚礼提交
+(void)marry:(NSString *)token
       bride:(NSString *)bride
       groom:(NSString *)groom
     address:(NSString *)address
    location:(NSString *)location
      images:(NSString *)images
   timestamp:(NSString *)timestamp
  background:(NSString *)background
    musicUrl:(NSString *)musicUrl
         mid:(NSString *)mid
          cb:(void(^)(BOOL isOK ,NSDictionary *array))callback;
//聚会提交
+(void)party:(NSString *)token
   partyName:(NSString *)partyName
     inviter:(NSString *)inviter
     address:(NSString *)address
      images:(NSString *)images
        tape:(NSString *)tape
   timestamp:(NSString *)timestamp
   closetime:(NSString *)closetime
 description:(NSString *)description
  background:(NSString *)background
         mid:(NSString *)mid
          cb:(void(^)(BOOL isOK ,NSDictionary *array))callback;

//自定义提交
+(void)custom:(NSString *)token
        title:(NSString *)title
      content:(NSString *)content
         logo:(NSString *)logo
        music:(NSString *)music
closeTimestamp:(NSString *)closeTimestamp
       images:(NSString *)images
          mid:(NSString *)mid
           cb:(void(^)(BOOL isOK ,NSDictionary *array))callback;

//修改截止时间
+(void)dueDate:(NSString *)unquieId
     timestamp:(NSString *)timestamp
            cb:(void(^)(BOOL isOK ,NSDictionary *array))callback;

//查询历史记录
+(void)multiHistory:(NSString *)token
               size:(NSString *)size
                 cb:(void(^)(BOOL isOK ,NSDictionary *array))callback;

//历史记录删除单个
+(void)deleteRecords:(NSString *)unquieId
                  cb:(void(^)(BOOL isOK ,NSDictionary *array))callback;

//批量删除邀约
+(void)remove:(NSString *)uniqueIds
           cb:(void(^)(BOOL isOK ,NSDictionary *array))callback;

//清除推送
+(void)cleanNumber: (void(^)(BOOL isOK ,NSDictionary *array))callback;

//意见反馈
+(void)suggestion:(NSString *)token
             type:(NSString *)type
          content:(NSString *)content
            model:(NSString *)model
               cb:(void(^)(BOOL isOK ,NSDictionary *array))callback;

//解压
+(void)unzip:(NSString*)filePath filename:(NSString *) filename;

//文件上传
+(void)uploadTP:(UIImage *) image cb:(void(^)(BOOL isOK, NSString *URL))callback;
+(void)uploadYP:(NSString *) file cb:(void (^)(BOOL isOK, NSString *URL))callback;

//版本查询
+(void)edition:(NSString *)type cb:(void (^)(BOOL isOK, NSDictionary *URL))callback;


@end
