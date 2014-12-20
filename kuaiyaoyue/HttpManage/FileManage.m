//
//  FileManage.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/4.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "FileManage.h"

@implementation FileManage{

}

- (id)init {
    self = [super init];
    if (self) {
        [self CreateFile];
    }
    return self;
}

+ (FileManage *)sharedFileManage
{
    static FileManage *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[FileManage alloc] init];
    });
    
    return _sharedInstance;
}

-(void)CreateFile{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"kyy"];
    [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    // 创建目录
    self.imgDirectory = [testDirectory stringByAppendingPathComponent:@"Image"];
    self.audioDirectory = [testDirectory stringByAppendingPathComponent:@"Audio"];
    
    if (![fileManager fileExistsAtPath:self.imgDirectory]) {
        [fileManager createDirectoryAtPath:self.imgDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    if (![fileManager fileExistsAtPath:self.audioDirectory]) {
        [fileManager createDirectoryAtPath:self.audioDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

-(NSString *)getImgFile:(NSString *)name{
    [self CreateFile];
    return [self.imgDirectory stringByAppendingPathComponent:name];
}

-(NSString *)GetYPFile:(NSString *) name{
    return [self.audioDirectory stringByAppendingPathComponent:name];
}

-(BOOL) ISYPFile:(NSString *)name{
    NSString *filepath = [self.audioDirectory stringByAppendingPathComponent:name];
    return [[NSFileManager defaultManager] fileExistsAtPath:filepath];
}


@end
