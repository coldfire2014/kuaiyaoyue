//
//  DataBaseManage.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/4.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface DataBaseManage : NSObject

+(DataBaseManage *)getDataBaseManage;

//设置音乐表内容
-(void)setMusic:(NSDictionary *) dic;
//获取音乐表
-(NSArray *)getMusic:(NSString *)typeid;
-(NSArray *)getMusic;
//查询模板表
-(NSArray *)QueryTemplate;
//添加模板内容
-(BOOL)AddTemplate:(NSDictionary *) resultDic;
//更新模板
-(BOOL)UpTemplate:(NSDictionary *) resultDic;

//更新Info表
-(BOOL)UpdataInfo :(NSDictionary *)dic;
//获取Info表
-(NSArray *)GetInfo:(NSString *) nefid;
//获取Fixeds表
-(NSArray *)GetFixeds:(NSString *) nefid;
//添加历史记录
-(BOOL)AddUserdata :(NSDictionary *) resultDic type:(int)type;
//获取历史记录
-(NSArray *)getUserdata;
//删除历史记录
-(BOOL)DelUserdata:(NSString *)nefid;
//情况历史记录
-(BOOL)CleanUserdata;
//更新历史记录
-(BOOL)UpUserdata:(NSString *)nefid;
//获取ID是否存在历史记录，并更新
-(BOOL)GetUpUserdata:(NSDictionary *)dic;
//获取模板列表
-(NSArray *)GetTemplate:(NSString *) neftypeId;
//获取报名人数
-(NSArray *)GetContacts:(NSString *)neftypeid;
//添加人数
-(BOOL)AddContacts:(NSDictionary *)dic :(NSString *)nefid;
//添加婚礼用户数据
-(void)AddHLUserdata;

@end
