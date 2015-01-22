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

+(void)Unzip{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString *is_open = [userInfo valueForKey:UZIP];
    NSString * zipPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"1.zip"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"sdyy"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([is_open length] > 0){
        
    }else{
        if ([fileManager fileExistsAtPath:testDirectory]) {
            [fileManager removeItemAtPath:testDirectory error:nil];
        }
        [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        [HttpManage unzip:zipPath filename:testDirectory];
        [userInfo setValue:@"YES" forKey:UZIP];
        [userInfo synchronize];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ZIP_DONE" object:nil];

}

@end
