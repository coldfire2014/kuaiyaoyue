//
//  ZipDown.m
//  cartoonCard
//
//  Created by DavidWang on 14-9-23.
//  Copyright (c) 2014年 wu yangbing. All rights reserved.
//

#import "ZipDown.h"
#import "HttpManage.h"
#import "SVProgressHUD.h"

@implementation ZipDown

+(void)Unzip{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString *is_open = [userInfo valueForKey:@"DYC"];
    if ([is_open length] > 0){
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"sdyy"];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:testDirectory]) {
            
        }else{
             NSString * zipPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"1.zip"];
            [HttpManage unzip:zipPath filename:testDirectory];
        }
        
    }else{
        NSString * zipPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"1.zip"];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"sdyy"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        [HttpManage unzip:zipPath filename:testDirectory];
        [userInfo setValue:@"YES" forKey:@"DYC"];
        [userInfo synchronize];
    }
}

@end
