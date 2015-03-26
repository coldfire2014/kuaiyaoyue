//
//  ZipDown.m
//  cartoonCard
//
//  Created by DavidWang on 14-9-23.
//  Copyright (c) 2014年 wu yangbing. All rights reserved.
//

#import "ZipDown.h"
#import "HttpManage.h"
#import "PCHeader.h"
#import "FileManage.h"
#import "UDObject.h"
@implementation ZipDown
+(void)UnzipI{//文件夹存在就不解压
//    NSString * zipPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"1.zip"];
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString *is_open = [userInfo valueForKey:UZIP];
    NSString * zipPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"1.zip"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"sdyy"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:testDirectory]) {
        [HttpManage unzip:zipPath filename:testDirectory];
        [userInfo setValue:@"YES" forKey:UZIP];
        [userInfo synchronize];
    }else if ([is_open length] == 0){//升级
        [UDObject setHLContent:@"" xn_name:@"" hltime:@"" bmendtime:@"" address_name:@"" music:@"" musicname:@"" imgarr:@""];
        [UDObject setSWContent:@"" swtime:@"" swbmendtime:@"" address_name:@"" swxlr_name:@"" swxlfs_name:@"" swhd_name:@"" music:@"" musicname:@"" imgarr:@""];
        [UDObject setWLContent:@"" wltime:@"" wlbmendtime:@"" wladdress_name:@"" wllxr_name:@"" wllxfs_name:@"" wlts_name:@"" wlmusicname:@"" wlmusic:@"" wlimgarr:@""];
        [UDObject setZDYContent:@"" zdytitle:@"" zdydd:@"" zdytime:@"" zdyendtime:@"" zdymusic:@"" zdymusicname:@"" zdyimgarr:@""];
        if ([fileManager fileExistsAtPath:testDirectory]) {
            [fileManager removeItemAtPath:testDirectory error:nil];
        }
        [HttpManage unzip:zipPath filename:testDirectory];
        [userInfo setValue:@"YES" forKey:UZIP];
        [userInfo synchronize];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ZIP_DONE" object:nil];
}
+(void)UnzipSingle:(NSString*)filename{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"sdyy"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"sdyy" ofType:@"bundle"]];
    NSError* err = nil;
    [fileManager copyItemAtPath:[bundle.bundlePath stringByAppendingPathComponent:filename] toPath:[testDirectory stringByAppendingPathComponent:filename] error:&err];
}
+(void)Unzip{//升级或首次
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString *is_open = [userInfo valueForKey:UZIP];
    NSLog(@"Unzipin");
    if ([is_open length] > 0){
        
    }else{
        NSString * zipPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"1.zip"];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"sdyy"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:testDirectory]) {
            [fileManager removeItemAtPath:testDirectory error:nil];
        }
        [HttpManage unzip:zipPath filename:testDirectory];
        [userInfo setValue:@"YES" forKey:UZIP];
        [userInfo synchronize];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ZIP_DONE" object:nil];
    NSLog(@"Unzipout");
}

@end
