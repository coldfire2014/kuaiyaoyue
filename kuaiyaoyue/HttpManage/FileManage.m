//
//  FileManage.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/4.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "FileManage.h"

static FileManage *fileManager = nil;
static NSString *hlimgDirectory = nil;
static NSString *imgDirectory = nil;
static NSString *audioDirectory = nil;


@implementation FileManage

- (id)init {
    self = [super init];
    if (self) {
        [self CreateFile];
    }
    return self;
}

+ (FileManage *)getManager {
    if (fileManager == nil) {
        fileManager = [[FileManage alloc] init];
    }
    return fileManager;
}

-(void)CreateFile{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"kyy"];
    [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    // 创建目录
    
    hlimgDirectory = [testDirectory stringByAppendingPathComponent:@"HLImage"];
    imgDirectory = [testDirectory stringByAppendingPathComponent:@"Image"];
    audioDirectory = [testDirectory stringByAppendingPathComponent:@"Audio"];
    
    if (![fileManager fileExistsAtPath:hlimgDirectory]) {
        [fileManager createDirectoryAtPath:hlimgDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    if (![fileManager fileExistsAtPath:imgDirectory]) {
        [fileManager createDirectoryAtPath:imgDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    if (![fileManager fileExistsAtPath:audioDirectory]) {
        [fileManager createDirectoryAtPath:audioDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

-(NSString *)GetYPFile:(NSString *) name{
    return [audioDirectory stringByAppendingPathComponent:name];
}

-(BOOL) ISYPFile:(NSString *)name{
    NSString *filepath = [audioDirectory stringByAppendingPathComponent:name];
    return [[NSFileManager defaultManager] fileExistsAtPath:filepath];

}

@end
