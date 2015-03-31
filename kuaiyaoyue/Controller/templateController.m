//
//  templateController.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/1/27.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import "templateController.h"
#import "DataBaseManage.h"
#import "Template.h"
#import "HttpManage.h"
#import "PCHeader.h"
#import "FileManage.h"

@implementation templateController
-(void)update{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString *is_open = [userInfo valueForKey:TEMP_TOKEN];
    NSArray *fetchedObjects = [[DataBaseManage getDataBaseManage] QueryTemplate];
    if ([fetchedObjects count] > 0 && [is_open length] > 0) {
        [self performSelectorInBackground:@selector(updatetemplate:) withObject:fetchedObjects];
//        [self performSelectorInBackground:@selector(maxtemplate:) withObject:@"-1"];
    }else{
        if ([fetchedObjects count] > 0) {
            [[DataBaseManage getDataBaseManage] resetTemplate];
        }
        NSBundle *bundle = [NSBundle mainBundle];
        NSString* html = [[NSString alloc] initWithContentsOfFile:[bundle pathForResource:@"template" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
        NSData* resData=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        for (int i = 0; i < [array count]; i++) {
            NSDictionary *resultDic = [array objectAtIndex:i];
            [[DataBaseManage getDataBaseManage] AddTemplate:resultDic];
        }
        [userInfo setObject:TEMP_TOKEN forKey:TEMP_TOKEN];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DOWNLOAD_DONE" object:nil];
}
-(void)updatetemplate:(NSArray*)fetchedObjects{
    Template *template = [fetchedObjects objectAtIndex:0];
    NSString *timestamp = template.neftimestamp;
    [self maxtemplate :timestamp];
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString *uptime = [userInfo objectForKey:@"renewalUptime"];
    if (uptime == nil) {
        uptime = timestamp;
    }
    [HttpManage templateRenewal:uptime cb:^(BOOL isOK, NSArray *array) {
        if (isOK) {
            for (int i = 0; i < [array count]; i++) {
                NSDictionary *dic = [array objectAtIndex:i];
                [[DataBaseManage getDataBaseManage] UpTemplate:dic];
                NSString *renewalType = [dic objectForKey:@"renewalType"];
                if ([renewalType isEqualToString:@"coordinate"]) {
                    [[DataBaseManage getDataBaseManage] UpdataInfo:dic];
                }else{
                    NSString *background = [dic objectForKey:@"background"];
                    NSString *thumbUrl = [dic objectForKey:@"preview"];
                    NSString *preview = [dic objectForKey:@"thumbUrl"];
                    NSArray *array = [background componentsSeparatedByString:@"/"];
                    NSString *bname = [array objectAtIndex:([array count] - 4)];
                    NSString *name = [NSString stringWithFormat:@"%@/assets/images/base",bname];
                    name = [[FileManage sharedFileManage] getImgPath:name];
                    NSString *pname = [NSString stringWithFormat:@"%@/assets/images/preview",bname];
                    pname = [[FileManage sharedFileManage] getImgPath:pname];
                    NSString *tname = [NSString stringWithFormat:@"%@/assets/images/thumb",bname];
                    tname = [[FileManage sharedFileManage] getImgPath:tname];
                    [HttpManage postdownloadimg:background :name];
                    [HttpManage postdownloadimg:preview :pname];
                    [HttpManage postdownloadimg:thumbUrl :tname];
                }
                if (i == ([array count]-1)) {
                    NSDictionary *dic1 = [array objectAtIndex:0];
                    NSString *uptime = [dic1 objectForKey:@"renewal"];
                    [userInfo setObject:uptime forKey:@"renewalUptime"];
                    [userInfo synchronize];
                }
            }
        }
    }];
}
-(void)maxtemplate:(NSString *)timestamp{
    [HttpManage template:timestamp size:@"-1" cb:^(BOOL isOK, NSMutableArray *array) {
        if (isOK) {
//            for (int i = 0; i < [array count]; i++) {
//                NSDictionary *resultDic = [array objectAtIndex:i];
//                [self zip:[resultDic objectForKey:@"zipUrl"] :[NSString stringWithFormat:@"%d",i]];
//                [[DataBaseManage getDataBaseManage] AddTemplate:resultDic];
//            }
        }
    }];
}

-(void)zip : (NSString *)zip :(NSString *) ii{
    if ([zip length] > 0) {
        NSArray *array = [zip componentsSeparatedByString:@"/"];
        NSString *name = [NSString stringWithFormat:@"%@",[array objectAtIndex:([array count]- 1)]];
        NSArray *array1 = [name componentsSeparatedByString:@"."];
        NSString *name1 = [NSString stringWithFormat:@"%@",[array1 objectAtIndex:([array1 count]- 2)]];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"sdyy"];
        [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        NSString *path = [testDirectory stringByAppendingPathComponent:name1];
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [HttpManage postdownload:zip :name1];
        }
    }
}

@end
