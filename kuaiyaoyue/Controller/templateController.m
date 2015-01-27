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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DOWNLOAD_DONE" object:nil];
}


-(void)getmaxtemplate:(BOOL)state{
//    is_add = state;
//    NSArray *fetchedObjects = [[DataBaseManage getDataBaseManage] QueryTemplate];
//    //    NSLog(@"%lu",(unsigned long)[fetchedObjects count]);
//    if ([fetchedObjects count] != 0) {
//        is_xz = NO;
//        Template *template = [fetchedObjects objectAtIndex:0];
//        NSString *timestamp = template.neftimestamp;
//        [self maxtemplate :timestamp];
//        NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
//        NSString *uptime = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"uptime"]];
//        if (uptime.length > 0 && ![uptime isEqualToString:@"(null)"]) {
//        }else{
//            uptime = timestamp;
//        }
//        [HttpManage templateRenewal:uptime cb:^(BOOL isOK, NSArray *array) {
//            if (isOK) {
//                NSLog(@"啦啦啦啦-%@",array);
//                for (int i = 0; i < [array count]; i++) {
//                    NSDictionary *dic = [array objectAtIndex:i];
//                    [[DataBaseManage getDataBaseManage] UpTemplate:dic];
//                    NSString *renewalType = [dic objectForKey:@"renewalType"];
//                    if ([renewalType isEqualToString:@"coordinate"]) {
//                        [[DataBaseManage getDataBaseManage] UpdataInfo:dic];
//                    }else{
//                        NSString *background = [dic objectForKey:@"background"];
//                        NSString *thumbUrl = [dic objectForKey:@"preview"];
//                        NSString *preview = [dic objectForKey:@"thumbUrl"];
//                        NSArray *array = [background componentsSeparatedByString:@"/"];
//                        NSString *bname = [array objectAtIndex:([array count] - 4)];
//                        NSString *name = [NSString stringWithFormat:@"%@/assets/images/base",bname];
//                        name = [[FileManage sharedFileManage] getImgPath:name];
//                        NSString *pname = [NSString stringWithFormat:@"%@/assets/images/preview",bname];
//                        pname = [[FileManage sharedFileManage] getImgPath:pname];
//                        NSString *tname = [NSString stringWithFormat:@"%@/assets/images/thumb",bname];
//                        tname = [[FileManage sharedFileManage] getImgPath:tname];
//                        [HttpManage postdownloadimg:background :name];
//                        [HttpManage postdownloadimg:preview :pname];
//                        [HttpManage postdownloadimg:thumbUrl :tname];
//                    }
//                    if (i == ([array count]-1)) {
//                        NSDictionary *dic1 = [array objectAtIndex:0];
//                        NSString *uptime = [dic1 objectForKey:@"renewal"];
//                        [userInfo setObject:uptime forKey:@"uptime"];
//                        [userInfo synchronize];
//                    }
//                }
//            }
//        }];
//    }else{
//        is_xz = YES;
//        [self maxtemplate :@"-1"];
//    }
}

-(void)maxtemplate:(NSString *)timestamp{
    [HttpManage template:timestamp size:@"-1" cb:^(BOOL isOK, NSMutableArray *array) {
        NSLog(@"%@",array);
        if (isOK) {
//            for (int i = 0; i < [array count]; i++) {
//                NSDictionary *resultDic = [array objectAtIndex:i];
//                if (is_xz) {
//                    [self zip:[resultDic objectForKey:@"zipUrl"] :[NSString stringWithFormat:@"%d",i]];
//                }
//                [[DataBaseManage getDataBaseManage] AddTemplate:resultDic];
//            }
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"DOWNLOAD_DONE" object:nil];
//            if (!is_add) {
//                [[StatusBar sharedStatusBar] talkMsg:@"模板加载完成..." inTime:0.5];
//            }
        }
        else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DOWNLOAD_DONE" object:nil];
        }
    }];
}

-(void)zip : (NSString *)zip :(NSString *) i{
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
