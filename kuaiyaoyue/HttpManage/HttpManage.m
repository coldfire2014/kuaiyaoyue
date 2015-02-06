//
//  HttpManage.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/3.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "HttpManage.h"
#import "ZipArchive.h"
#import "PCHeader.h"
#import "FileManage.h"
#import "UDObject.h"
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
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

- (instancetype)init{
    AFConnectionAPIClientLogin *client = [[AFConnectionAPIClientLogin alloc] initWithBaseURL:[NSURL URLWithString:APIBaseURLString]];
    client.responseSerializer = [AFHTTPResponseSerializer serializer];
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
                            timestamp,@"timestamp",@"ios",@"equipment",version,@"version",nil];
    [[AFConnectionAPIClient sharedClient] POST:@"nozzle/NefMusic/getAll.aspx" parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        
        callback(YES,JSON);
        
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
+(void)phoneregister:(NSString *)mobilePhone password:(NSString *)password cb:(void(^)(BOOL isOK ,NSMutableArray *dic))callback{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                        mobilePhone,@"mobilePhone",password,@"password",
                            @"ios",@"equipment",version,@"version",nil];
    [[AFConnectionAPIClient sharedClient] POST:@"nozzle/NefUser/register.aspx" parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        callback(YES,JSON);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSString *html = operation.responseString;
        if (html != nil) {
            NSData* resData1=[html dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:resData1 options:NSJSONReadingMutableLeaves error:nil];
            NSDictionary *error = [dic objectForKey:@"error"];
            int code = [[error objectForKey:@"code"] intValue];
            if (code == 64) {
                callback(NO,[[NSMutableArray alloc] initWithObjects:@"账号已注册", nil]);
            }
        }else{
            callback(NO,nil);
        }
        
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
//    模拟器设置
    if (phoneId.length >0) {
        
    }else{
        phoneId = @"-1";
    }
   
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            mobilePhone,@"mobilePhone",
                            password,@"password",
                            phoneId,@"phoneId",
                            mobilePhone,@"j_username",
                            password,@"j_password",
                            @"true",@"isJson",
                            @"ios",@"equipment",version,@"version",
                            nil];
    
    [[AFConnectionAPIClientLogin sharedClient] POST:@"j_spring_security_check" parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        NSString *html = operation.responseString;
        NSData* resData=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        callback(YES,resultDic);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSString *html = operation.responseString;
        NSLog(@"error-%@",html);
        if (html != nil) {
            NSData* resData=[html dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
            callback(NO,resultDic);
        }else{
            callback(NO,nil);
        }
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
    
    if (phoneId.length >0) {
        
    }else{
        phoneId = @"-1";
    }

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            userName,@"userName",userPwd,@"userPwd",
                            phoneId,@"phoneId",openId,@"openId",
                            @"ios",@"equipment",version,@"version",
                            nil];
    
    [[AFConnectionAPIClient sharedClient] POST:@"nozzle/NefUser/registers.aspx" parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {

        callback(YES,JSON);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSString *html = operation.responseString;
//        NSLog(@"error-%@",html);
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
                            token,@"token",@"ios",@"equipment",version,@"version",nil];
    [[AFConnectionAPIClient sharedClient] POST:@"nozzle/NefToken/logout.aspx" parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {

        callback(YES,JSON);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSString *html = operation.responseString;
//        NSLog(@"error-%@-%@",error,html);
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
                            @"ios",@"equipment",version,@"version",
                            oldPwd,@"oldPwd",nil];
    [[AFConnectionAPIClient sharedClient] POST:@"nozzle/NefUser/appeal.aspx" parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        
        callback(YES,JSON);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSLog(@"error-%@",error);
        callback(NO,nil);
    }];
}

//忘记密码
+(void)forget: (void(^)(BOOL isOK ,NSDictionary *array))callback{
    [[AFConnectionAPIClient sharedClient] POST:@"nozzle/NefUser/forget.aspx" parameters:nil success:^(AFHTTPRequestOperation * operation, id JSON) {
        callback(YES,JSON);
        
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
                            token,@"token",@"ios",@"equipment",version,@"version",nil];
    [[AFConnectionAPIClient sharedClient] POST:@"nozzle/NefToken/checkToken.aspx" parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        callback(YES,JSON);
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
                            timestamp,@"timestamp",size,@"size",@"ios",@"equipment",version,@"version",nil];
    [[AFConnectionAPIClient sharedClient] POST:@"nozzle/NefTemplate/template.aspx" parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        callback(YES,JSON);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSString *html = operation.responseString;
//        NSLog(@"error-%@",html);
        callback(NO,nil);
    }];
    
}

/*
 更新模板
 "timestamp":"1407915296703", //上一次更新时间，为-1则是不更新
 */
+(void)templateRenewal:(NSString *)timestamp cb:(void(^)(BOOL isOK ,NSMutableArray *array))callback{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            timestamp,@"timestamp",@"ios",@"equipment",version,@"version",nil];
    [[AFConnectionAPIClient sharedClient] POST:@"nozzle/NefTemplate/templateRenewal.aspx" parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        callback(YES,JSON);
        
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
      images:(NSArray *)images
   timestamp:(NSString *)timestamp
  background:(NSString *)background
    musicUrl:(NSString *)musicUrl
closeTimestamp:(NSString *)closeTimestamp
         mid:(NSString *)mid
          cb:(void(^)(BOOL isOK ,NSDictionary *array))callback{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            token,@"token",bride,@"bride",groom,@"groom",
                            address,@"address",images,@"images",
                            timestamp,@"timestamp",background,@"background",musicUrl,@"musicUrl",closeTimestamp,@"closeTimestamp",
                            @"ios",@"equipment",version,@"version",
                            nil];
    
    if ([YINGLOUURL compare:@""] != NSOrderedSame) {
        NSString* ylid = [UDObject getYLID];
        params = [NSDictionary dictionaryWithObjectsAndKeys:
                  token,@"token",bride,@"bride",groom,@"groom",
                  address,@"address",images,@"images",
                  ylid,@"studioId",timestamp,@"timestamp",background,@"background",musicUrl,@"musicUrl",closeTimestamp,@"closeTimestamp",
                  @"ios",@"equipment",version,@"version",
                  nil];
    }
    NSString *url = [NSString stringWithFormat:@"nozzle/NefUserData/marry/%@.aspx",mid];
    [[AFConnectionAPIClient sharedClient] POST:url parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        callback(YES,JSON);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSString *html = operation.responseString;
//        NSLog(@"error-%@",html);
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
   telephone:(NSString *)telephone
     address:(NSString *)address
      images:(NSArray *)images
        tape:(NSString *)tape
   timestamp:(NSString *)timestamp
   closetime:(NSString *)closetime
 description:(NSString *)description
  background:(NSString *)background
         mid:(NSString *)mid
         cb:(void(^)(BOOL isOK ,NSDictionary *array))callback{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            token,@"token",partyName,@"partyName",inviter,@"contact",
                            telephone,@"telephone",
                            address,@"address",images,@"images",tape,@"tape",
                            timestamp,@"timestamp",closetime,@"closeTimestamp",description,@"description",
                            background,@"background",@"ios",@"equipment",version,@"version",
                            nil];
    NSString *url = [NSString stringWithFormat:@"nozzle/NefUserData/party/%@.aspx",mid];
    [[AFConnectionAPIClient sharedClient] POST:url parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        callback(YES,JSON);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSString *html = operation.responseString;
//        NSLog(@"error-%@",html);
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
    timestamp:(NSString *)timestamp
closeTimestamp:(NSString *)closeTimestamp
       images:(NSArray *)images
          mid:(NSString *)mid
           cb:(void(^)(BOOL isOK ,NSDictionary *array))callback{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            token,@"token",title,@"title",content,@"content",
                            logo,@"logo",music,@"music",timestamp,@"timestamp",closeTimestamp,@"closeTimestamp",
                            images,@"images",@"ios",@"equipment",version,@"version",
                            nil];
    
    NSString *url = [NSString stringWithFormat:@"nozzle/NefUserData/custom/%@.aspx",mid];
    [[AFConnectionAPIClient sharedClient] POST:url parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        callback(YES,JSON);
        
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
                            unquieId,@"unquieId",timestamp,@"timestamp",
                            @"ios",@"equipment",version,@"version",nil];
    [[AFConnectionAPIClient sharedClient] POST:@"nozzle/NefUserData/dueDate.aspx" parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        callback(YES,JSON);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSLog(@"error-%@",error);
        callback(NO,nil);
    }];
}

/*
 查询历史记录
 token:" fab46ace-1bea-4915-a9a1-f143fc49263f"
 size:10   //查询条数   值为-1时 查询全部
 queryType:
 */
+(void)multiHistory:(NSString *)token
               timestamp:(NSString *)timestamp
               size:(NSString *)size
                 cb:(void(^)(BOOL isOK ,NSDictionary *array))callback{
    NSString* queryType = @"";
    if ([timestamp compare:@"-1"] == NSOrderedSame) {
        queryType = @"failure";
        NSString * ts = [UDObject getTimestamp];
        if (ts == nil || [ts compare:@""] == NSOrderedSame) {
            queryType = @"success";
        }else{
            timestamp = ts;
        }
    } else {
        queryType = @"success";
    }
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                        token,@"token",timestamp,@"timestamp",
                        @"ios",@"equipment",version,@"version",
//                        queryType,@"queryType",
                        size,@"size",nil];
    
    [[AFConnectionAPIClient sharedClient] POST:@"nozzle/NefUserData/multiHistory.aspx" parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        callback(YES,JSON);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSLog(@"error-%@",error);
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
                            unquieId,@"unquieId",@"ios",@"equipment",version,@"version",nil];
    [[AFConnectionAPIClient sharedClient] POST:@"nozzle/NefUserData/deleteRecords.aspx" parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        callback(YES,JSON);
        
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
                            uniqueIds,@"uniqueIds",@"ios",@"equipment",version,@"version",nil];
    [[AFConnectionAPIClient sharedClient] POST:@"nozzle/NefUserData/remove.aspx" parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        callback(YES,JSON);
        
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
+(void)cleanNumber:(NSString *)unquieId token:(NSString *)token cb:(void(^)(BOOL isOK ,NSDictionary *array))callback{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            unquieId,@"unquieId",token,@"token",@"ios",@"equipment",version,@"version",nil];
    [[AFConnectionAPIClient sharedClient] POST:@"nozzle/NefNumber/cleanNumber.aspx" parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        callback(YES,JSON);
        
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
                            token,@"token",type,@"type",content,@"content",model,@"model",@"ios",@"equipment",version,@"version",nil];
    [[AFConnectionAPIClient sharedClient] POST:@"nozzle/NefSuggestion/suggestion.aspx" parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        callback(YES,JSON);
        
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
+(void)unzip:(NSString*)filePath filename:(NSString *) filename{
    ZipArchive* za = [[ZipArchive alloc] init];
    if( [za UnzipOpenFile:filePath] )
    {
        BOOL ret = [za UnzipFileTo:filename overWrite:YES];
        if( NO==ret )
        {
            // error handler here
        }
        [za UnzipCloseFile];
    }
}

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
            [self unzip:filePath filename:testDirectory];
        }
    }];
    [operation start];
}

//下载
+ (BOOL)postdownloadimg : (NSString *)url : (NSString *)filepath;
{
    //下载图片
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFURLConnectionOperation *operation =   [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:filepath append:NO];
    [operation setCompletionBlock:^{
    }];
    
    [operation start];
    
    return YES;
}
/*
 文件上传-图片
 */
+(void)uploadTP:(UIImage *) image name:(NSString *)name cb:(void(^)(BOOL isOK, NSString *URL))callback{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:APIBaseURLString]];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager POST:@"nozzle/NefImages/upload.aspx" parameters:nil timeout:12 constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData* jtdata = UIImageJPEGRepresentation(image,C_JPEG_SIZE);
        [formData appendPartWithFileData:jtdata name:@"files" fileName:name mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        callback(YES,[responseObject objectForKey:@"url"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString* res = operation.responseString;
        if (nil != res) {
            NSData* resData=[res dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
            NSDictionary *err = [resultDic objectForKey:@"error"];
            NSString* code = [err objectForKey:@"code"];
            if ([code longLongValue] == 34) {
                NSArray* sub_errs = [err objectForKey:@"subErrors"];
                NSDictionary* sub_err = [sub_errs objectAtIndex:0];
                NSString* codes = [sub_err objectForKey:@"code"];
                if([codes longLongValue] == 1) {
                    callback(YES ,[NSString stringWithFormat:@"%@%@",PIC_URL,name]);
                }else{
                    callback(NO ,@"");
                }
            } else {
                callback(NO ,@"");
            }
        }else{
            callback(NO ,@"");
        }
    }];
}

/*
 文件上传音频
 */

+(void)uploadYP :(NSString *)file name:(NSString *)name cb:(void(^)(BOOL isOK, NSString *URL))callback{
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:APIBaseURLString]];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager POST:@"nozzle/NefImages/upload.aspx" parameters:nil timeout:20 constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *data = [NSData dataWithContentsOfFile: file];
        [formData appendPartWithFileData:data name:@"files" fileName:name mimeType:@"audio/wav"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        callback(YES ,[responseObject objectForKey:@"url"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString* res = operation.responseString;
        if (nil != res) {
            NSData* resData=[res dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
            NSDictionary *err = [resultDic objectForKey:@"error"];
            NSString* code = [err objectForKey:@"code"];
            if ([code longLongValue] == 34) {
                NSArray* sub_errs = [err objectForKey:@"subErrors"];
                NSDictionary* sub_err = [sub_errs objectAtIndex:0];
                NSString* codes = [sub_err objectForKey:@"code"];
                if([codes longLongValue] == 1) {
                    callback(YES ,[NSString stringWithFormat:@"%@%@",PIC_URL,name]);
                }else{
                    callback(NO ,@"");
                }
            } else {
                callback(NO ,@"");
            }
        }else{
            callback(NO ,@"");
        }
    }];
}

/*
 版本查询
 type:"ios"
 */

+(void)edition:(NSString *)type cb:(void (^)(BOOL isOK, NSString *URL))callback{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:version,@"version",nil];
    
    [[AFConnectionAPIClient sharedClient] POST:@"nozzle/NefEdition/edition.aspx" parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        callback(YES,[JSON objectForKey:@"result"]);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSLog(@"error-%@",error);
        callback(NO,nil);
    }];
}
//markwyb
/*
查看报名人数
 uniqueId:"1",  //邀约编号
 timestamp:"-1"   //时间戳，值为-1时查询全部
 */
+(void)renewal:(NSString *)uniqueId timestamp:(NSString *) timestamp size:(NSString *)size cb:(void (^)(BOOL isOK, NSMutableArray *URL))callback{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            uniqueId,@"uniqueId",timestamp,@"timestamp",
                            size,@"size",
                            @"ios",@"equipment",version,@"version",
                            nil];
    
    [[AFConnectionAPIClient sharedClient] POST:@"nozzle/NefRegistration/renewal.aspx" parameters:params success:^(AFHTTPRequestOperation * operation, id JSON) {
        callback(YES,JSON);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSLog(@"error-%@",error);
        callback(NO,nil);
    }];
}

@end
