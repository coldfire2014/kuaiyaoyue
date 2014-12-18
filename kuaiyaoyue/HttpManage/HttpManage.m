//
//  HttpManage.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/3.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "HttpManage.h"
//#import "ZipArchive.h"

#define HTTPURL @"http://115.29.11.57/"
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
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPURL,@"/invitation/nozzle/NefMusic/getAll.aspx"];
    NSLog(@"params-%@",params);
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
mobilePhone:”18557164825”,           //手机号
password:1235456                     //用户密码
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
 普通登录
 mobilePhone:”18557164825”,               //账号
 password:”123456”,                       //密码
 phoneId:"121212"                       //手机唯一标识
 j_username:" 18557164825"              //用户名
 j_password:"123456"                  //用户密码
 isJson:"true"                          //是否为json数据
 */
+(void)j_spring_security_check:(NSString *)mobilePhone
                      password:(NSString *)password
                       phoneId:(NSString *)phoneId
                    j_username:(NSString *)j_username
                    j_password:(NSString *)j_password
                        isJson:(NSString *)isJson
                            cb:(void(^)(BOOL isOK ,NSDictionary *array))callback{
   
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            mobilePhone,@"mobilePhone",
                            password,@"password",
                            phoneId,@"phoneId",
                            mobilePhone,@"j_username",
                            password,@"j_password",
                            @"true",@"isJson",
                            nil];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPURL,@"invitation/j_spring_security_check"];
    NSLog(@"params-%@-%@",params,url);
    
    [[AFConnectionAPIClientLogin sharedClient] POST:url parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        
        NSString *html = operation.responseString;
        NSData* resData=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",resultDic);
        
        NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
        [userInfo setObject:mobilePhone forKey:@"phone"];
        [userInfo setObject:[resultDic objectForKey:@"token"] forKey:@"userid"];
        [userInfo synchronize];
        callback(YES,nil);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSLog(@"error-%@",error);
        callback(NO,nil);
        
    }];
    
}

/*第三方注册登录接口
 userName:"asd",
 userPwd:"vsd",
 phoneId:"asdasdasdasdasd",
 openId:"aasad"
 */
+(void)registers:(NSString *)userName
         userPwd:(NSString *)userPwd
         phoneId:(NSString *)phoneId
          openId:(NSString *)openId
              cb:(void(^)(BOOL isOK ,NSDictionary *array))callback{

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            userName,@"userName",userPwd,@"userPwd",
                            phoneId,@"phoneId",openId,@"openId",
                            nil];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPURL,@"invitation/nozzle/NefUser/registers.aspx"];
    NSLog(@"%@-%@",url,params);
    [[AFConnectionAPIClient sharedClient] POST:url parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        NSString *html = operation.responseString;
        NSData* resData=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *array = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        callback(YES,array);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSLog(@"error-%@",error);
        callback(NO,nil);
    }];
}


/*
 登出
 {
 token:" fab46ace-1bea-4915-a9a1-f143fc49263f"
 }
 */
+(void)logout:(NSString *)token cb:(void(^)(BOOL isOK ,NSDictionary *array))callback{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            token,@"token",nil];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPURL,@"invitation/nozzle/NefToken/logout.aspx"];
    [[AFConnectionAPIClient sharedClient] POST:url parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        NSString *html = operation.responseString;
        NSData* resData=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *array = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        callback(YES,array);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSLog(@"error-%@",error);
        callback(NO,nil);
    }];
}

/*
 修改密码
 mobilePhone:"123132132",//账号
	password:"dasdasd",//新密码
	oldPwd:"asdasd",//原密码
 */
+(void)appeal:(NSString *)mobilePhone
     password:(NSString *)password
       oldPwd:(NSString *)oldPwd
           cb:(void(^)(BOOL isOK ,NSDictionary *array))callback{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            mobilePhone,@"mobilePhone",password,@"password",
                            oldPwd,@"oldPwd",nil];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPURL,@"invitation/nozzle/NefUser/appeal.aspx"];
    [[AFConnectionAPIClient sharedClient] POST:url parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        NSString *html = operation.responseString;
        NSData* resData=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *array = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        callback(YES,array);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSLog(@"error-%@",error);
        callback(NO,nil);
    }];
}

//忘记密码
+(void)forget: (void(^)(BOOL isOK ,NSDictionary *array))callback{
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPURL,@"invitation/nozzle/NefUser/forget.aspx"];
    [[AFConnectionAPIClient sharedClient] POST:url parameters:nil success:^(AFHTTPRequestOperation * operation, id JSON) {
        NSString *html = operation.responseString;
        NSData* resData=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *array = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        callback(YES,array);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSLog(@"error-%@",error);
        callback(NO,nil);
    }];
}

/*
 检查checktoken有效
 token:"asda-sd-asdasd-asd-asd"
 */
+(void)checkToken:(NSString *)token cb:(void(^)(BOOL isOK ,NSDictionary *array))callback{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            token,@"token",nil];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPURL,@"invitation/nozzle/NefToken/checkToken.aspx"];
    [[AFConnectionAPIClient sharedClient] POST:url parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        NSString *html = operation.responseString;
        NSData* resData=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *array = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        callback(YES,array);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSLog(@"error-%@",error);
        callback(NO,nil);
    }];
}

/*
 模板查询
 "timestamp":"1407915296703", //在这时间后的模板当值为-1时查询全部
 size:10          //查询模板数量
 */
+(void)template:(NSString *)timestamp
           size:(NSString *)size
             cb:(void(^)(BOOL isOK ,NSMutableArray *array))callback{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            timestamp,@"timestamp",size,@"size",nil];
    NSLog(@"%@",params);
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPURL,@"invitation/nozzle/NefTemplate/template.aspx"];
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
 更新模板
 "timestamp":"1407915296703", //上一次更新时间，为-1则是不更新
 */
+(void)templateRenewal:(NSString *)timestamp cb:(void(^)(BOOL isOK ,NSMutableArray *array))callback{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            timestamp,@"timestamp",nil];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPURL,@"invitation/nozzle/NefTemplate/templateRenewal.aspx"];
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
 婚礼提交
 token:" fab46ace-1bea-4915-a9a1-f143fc49263f"
 "bride":"新娘",
 "groom":"新郎",名字最少2个字
 "address":"地点",最少2个字
 “location”:”地址”,                最少2个字
 "images":["http://www.example.com/image1.jpg", "http://www.example.com/image2.png"], //用户图片列表
 "timestamp":"1407915296703" //时间戳
 background:"http://,....",   //内容写入之后的图片
 musicUrl:"http://12132.com/ad.mp3"    //背景音乐
 */
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
          cb:(void(^)(BOOL isOK ,NSDictionary *array))callback{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            token,@"token",bride,@"bride",groom,@"groom",
                            address,@"address",location,@"location",images,@"images",
                            timestamp,@"timestamp",background,@"background",musicUrl,@"musicUrl",
                            nil];
    
    NSString *pjurl = [NSString stringWithFormat:@"invitation/nozzle/NefUserData/marry/%@.aspx",mid];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPURL,pjurl];
    [[AFConnectionAPIClient sharedClient] POST:url parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        NSString *html = operation.responseString;
        NSData* resData=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *array = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        callback(YES,array);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSLog(@"error-%@",error);
        callback(NO,nil);
    }];

}

/*
 聚会用户数据提交
 token:" fab46ace-1bea-4915-a9a1-f143fc49263f"
 partyName:"聚会名称"
 inviter:”邀请人”,
 address:”地点”,
 images:[“http://www.example.com/image1.jpg“,”http://www.example.com/image2.jpg”],    //用户图片列表
 tape:”http://www.example.com/1.wav”,    //录音文件地址
 timestamp:”1407915296703”,   //时间戳聚会时间
 closetime:”1407915496703”    //时间戳聚会报名截止时间
 description:”聚一聚”                 //描述
 background:"http://,....";   //内容写入之后的图片
 */
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
         cb:(void(^)(BOOL isOK ,NSDictionary *array))callback{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            token,@"token",partyName,@"partyName",inviter,@"inviter",
                            address,@"address",images,@"images",tape,@"tape",
                            timestamp,@"timestamp",closetime,@"closetime",description,@"description",
                            background,@"background",
                            nil];
    
    NSString *pjurl = [NSString stringWithFormat:@"invitation/nozzle/NefUserData/party/%@.aspx",mid];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPURL,pjurl];
    [[AFConnectionAPIClient sharedClient] POST:url parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        NSString *html = operation.responseString;
        NSData* resData=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *array = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        callback(YES,array);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSLog(@"error-%@",error);
        callback(NO,nil);
    }];
}


/*
 自定义提交
 token:"asdf-asdf-asdf-asdfasd-fa",
 title:"标题",
 content:"分享信息内容",
 logo:"分享logo图地址",
 music:"背景音乐地址",
 closeTimestamp:"13213245456",报名截止时间
 "images":["http://www.example.com/image1.jpg", "http://www.example.com/image2.png"], //用户图片列表
 */
+(void)custom:(NSString *)token
        title:(NSString *)title
      content:(NSString *)content
         logo:(NSString *)logo
        music:(NSString *)music
closeTimestamp:(NSString *)closeTimestamp
       images:(NSString *)images
          mid:(NSString *)mid
           cb:(void(^)(BOOL isOK ,NSDictionary *array))callback{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            token,@"token",title,@"title",content,@"content",
                            logo,@"logo",music,@"music",closeTimestamp,@"closeTimestamp",
                            images,@"images",
                            nil];
    
    NSString *pjurl = [NSString stringWithFormat:@"invitation/nozzle/NefUserData/custom/%@.aspx",mid];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPURL,pjurl];
    [[AFConnectionAPIClient sharedClient] POST:url parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        NSString *html = operation.responseString;
        NSData* resData=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *array = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        callback(YES,array);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSLog(@"error-%@",error);
        callback(NO,nil);
    }];

}

/*
 修改截止时间
 unquieId:”1”,     //记录id
 timestamp:”65465465”   //新的截止日期
 */
+(void)dueDate:(NSString *)unquieId
     timestamp:(NSString *)timestamp
            cb:(void(^)(BOOL isOK ,NSDictionary *array))callback{

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            unquieId,@"unquieId",timestamp,@"timestamp",nil];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPURL,@"invitation/nozzle/NefUserData/dueDate.aspx"];
    [[AFConnectionAPIClient sharedClient] POST:url parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        NSString *html = operation.responseString;
        NSData* resData=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *array = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        callback(YES,array);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSLog(@"error-%@",error);
        callback(NO,nil);
    }];
}

/*
 查询历史记录
 token:" fab46ace-1bea-4915-a9a1-f143fc49263f"
 size:10   //查询条数   值为-1时 查询全部
 */
+(void)multiHistory:(NSString *)token
               size:(NSString *)size
                 cb:(void(^)(BOOL isOK ,NSDictionary *array))callback{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            token,@"token",@"30",@"timestamp",nil];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPURL,@"invitation/nozzle/NefUserData/multiHistory.aspx"];
    
    [[AFConnectionAPIClient sharedClient] POST:url parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        NSString *html = operation.responseString;
        NSData* resData=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *array = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        callback(YES,array);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSLog(@"error-%@",error.userInfo);
        callback(NO,nil);
    }];
}

/*
 历史记录删除单个
 “unquieId”:”1”,    //记录id
 */
+(void)deleteRecords:(NSString *)unquieId
                  cb:(void(^)(BOOL isOK ,NSDictionary *array))callback{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            unquieId,@"unquieId",nil];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPURL,@"invitation/nozzle/NefUserData/deleteRecords.aspx"];
    [[AFConnectionAPIClient sharedClient] POST:url parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        NSString *html = operation.responseString;
        NSData* resData=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *array = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        callback(YES,array);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSLog(@"error-%@",error);
        callback(NO,nil);
    }];
}


/*
 批量删除邀约
 uniqueIds:[1,2]  //要删除的邀约编号
 */
+(void)remove:(NSString *)uniqueIds
           cb:(void(^)(BOOL isOK ,NSDictionary *array))callback{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            uniqueIds,@"uniqueIds",nil];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPURL,@"invitation/nozzle/NefUserData/remove.aspx"];
    [[AFConnectionAPIClient sharedClient] POST:url parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        NSString *html = operation.responseString;
        NSData* resData=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *array = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        callback(YES,array);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSLog(@"error-%@",error);
        callback(NO,nil);
    }];
}

/*
 清除推送
 token:"fasdfadsf-adsfasdfasd..."     //token
 unquieId:"1"    //记录编号
 */
+(void)cleanNumber: (void(^)(BOOL isOK ,NSDictionary *array))callback{
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPURL,@"invitation/nozzle/NefNumber/cleanNumber.aspx"];
    [[AFConnectionAPIClient sharedClient] POST:url parameters:nil success:^(AFHTTPRequestOperation * operation, id JSON) {
        NSString *html = operation.responseString;
        NSData* resData=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *array = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        callback(YES,array);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSLog(@"error-%@",error);
        callback(NO,nil);
    }];
}

/*
 意见反馈
 token:" fab46ace-1bea-4915-a9a1-f143fc49263f"
 “type”:”type1”,  //意见反馈类型
 “content”:”someSuggestions”,//内容
 "model":"iphone 5s"//机型
 */
+(void)suggestion:(NSString *)token
             type:(NSString *)type
          content:(NSString *)content
            model:(NSString *)model
               cb:(void(^)(BOOL isOK ,NSDictionary *array))callback{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            token,@"token",type,@"type",content,@"content",model,@"model",nil];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPURL,@"invitation/nozzle/NefSuggestion/suggestion.aspx"];
    [[AFConnectionAPIClient sharedClient] POST:url parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        NSString *html = operation.responseString;
        NSData* resData=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *array = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        callback(YES,array);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSLog(@"error-%@",error);
        callback(NO,nil);
    }];
}

/*
 解压
 filePath:解压文件路径
 filename:解压显示的文件名称
 */
//+(void)unzip:(NSString*)filePath  filename:(NSString *) filename
//{
//    ZipArchive* za = [[ZipArchive alloc] init];
//    if( [za UnzipOpenFile:filePath] )
//    {
//        BOOL ret = [za UnzipFileTo:filename overWrite:YES];
//        if( NO==ret )
//        {
//            // error handler here
//        }
//        [za UnzipCloseFile];
//    }
//}

/*
 下载ZIP包
 */
+ (void)postdownload:(NSString *)URL :(NSString *)zipname
{
    //下载并解压
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    AFURLConnectionOperation *operation =   [[AFHTTPRequestOperation alloc] initWithRequest:request];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *testDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"sdyy"];
    NSString *filePath = [testDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.zip",zipname]];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:NO];
    [operation setCompletionBlock:^{
        NSLog(@"downloadComplete!");
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            NSLog(@"存在");
//            [self unzip:filePath :testDirectory];
        }
    }];
    [operation start];
}


/*
 文件上传-图片
 */
+(void)uploadTP:(UIImage *) image cb:(void(^)(BOOL isOK, NSString *URL))callback{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:HTTPURL]];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPURL,@"invitation/nozzle/NefImages/upload.aspx"];
    [manager POST:url parameters:nil timeout:9 constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData* jtdata = UIImageJPEGRepresentation(image,0.3);
        [formData appendPartWithFileData:jtdata name:@"files" fileName:@"one.jpg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *html = operation.responseString;
        NSData* resData=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        callback(YES,[resultDic objectForKey:@"url"]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%ld:%@",(long)[error code],[error localizedDescription]);
        callback(NO ,@"");
    }];
}

/*
 文件上传音频
 */

+(void)postYPUpload :(NSString *)file cb:(void(^)(BOOL isOK, NSString *URL))callback{
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:HTTPURL]];
    [manager POST:@"NefImages/upload.aspx" parameters:nil timeout:11 constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *data = [NSData dataWithContentsOfFile: file];
        NSLog(@"%d",[data length]/1024);
        
        [formData appendPartWithFileData:data name:@"files" fileName:@"cs.wav" mimeType:@"audio/wav"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *html = operation.responseString;
        NSData* resData=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        
        callback(YES ,[resultDic objectForKey:@"url"]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%ld:%@",(long)[error code],[error localizedDescription]);
        callback(NO ,@"");
    }];
}

/*
 版本查询
 type:"ios"
 */

+(void)edition:(NSString *)type cb:(void (^)(BOOL isOK, NSDictionary *URL))callback{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            type,@"type",nil];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPURL,@"invitation/nozzle/NefEdition/edition.aspx"];
    [[AFConnectionAPIClient sharedClient] POST:url parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        NSString *html = operation.responseString;
        NSData* resData=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *array = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        callback(YES,array);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSLog(@"error-%@",error);
        callback(NO,nil);
    }];
}


@end
