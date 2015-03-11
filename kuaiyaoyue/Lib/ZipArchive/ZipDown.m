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
@implementation ZipDown
+(void)UnzipI{//文件夹存在就不解压
//    NSString * zipPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"1.zip"];
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString *is_open = [userInfo valueForKey:UZIP];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"sdyy"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:testDirectory]) {
        [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
//        [HttpManage unzip:zipPath filename:testDirectory];
        NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"sdyy" ofType:@"bundle"]];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError* err = nil;
        [fileManager copyItemAtPath:[bundle.bundlePath stringByAppendingString:@"/musicFiles"] toPath:[testDirectory stringByAppendingString:@"/musicFiles"] error:&err];
        [fileManager copyItemAtPath:[bundle.bundlePath stringByAppendingString:@"/custom"] toPath:[testDirectory stringByAppendingString:@"/custom"] error:&err];
        [fileManager copyItemAtPath:[bundle.bundlePath stringByAppendingString:@"/public"] toPath:[testDirectory stringByAppendingString:@"/public"] error:&err];
        [userInfo setValue:@"YES" forKey:UZIP];
        [userInfo synchronize];
    }else if ([is_open length] == 0){//升级
        if ([fileManager fileExistsAtPath:testDirectory]) {
            [fileManager removeItemAtPath:testDirectory error:nil];
        }
        [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        //        [HttpManage unzip:zipPath filename:testDirectory];
        NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"sdyy" ofType:@"bundle"]];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError* err = nil;
        [fileManager copyItemAtPath:[bundle.bundlePath stringByAppendingString:@"/musicFiles"] toPath:[testDirectory stringByAppendingString:@"/musicFiles"] error:&err];
        [fileManager copyItemAtPath:[bundle.bundlePath stringByAppendingString:@"/custom"] toPath:[testDirectory stringByAppendingString:@"/custom"] error:&err];
        [fileManager copyItemAtPath:[bundle.bundlePath stringByAppendingString:@"/public"] toPath:[testDirectory stringByAppendingString:@"/public"] error:&err];
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
//    NSString * zipPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"1.zip"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"sdyy"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSLog(@"Unzipin");
    if ([is_open length] > 0){
        
    }else{
        if ([fileManager fileExistsAtPath:testDirectory]) {
            [fileManager removeItemAtPath:testDirectory error:nil];
        }
        [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
//        [HttpManage unzip:zipPath filename:testDirectory];
        NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"sdyy" ofType:@"bundle"]];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError* err = nil;
        [fileManager copyItemAtPath:[bundle.bundlePath stringByAppendingString:@"/musicFiles"] toPath:[testDirectory stringByAppendingString:@"/musicFiles"] error:&err];
        [fileManager copyItemAtPath:[bundle.bundlePath stringByAppendingString:@"/custom"] toPath:[testDirectory stringByAppendingString:@"/custom"] error:&err];
        [fileManager copyItemAtPath:[bundle.bundlePath stringByAppendingString:@"/public"] toPath:[testDirectory stringByAppendingString:@"/public"] error:&err];
        [userInfo setValue:@"YES" forKey:UZIP];
        [userInfo synchronize];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ZIP_DONE" object:nil];
    NSLog(@"Unzipout");
}

@end
