//
//  FileManage.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/4.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "FileManage.h"
#import "UDObject.h"
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
+(NSString*)getUUID{
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuid= (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
    CFRelease(uuidRef);
    return uuid;
}
-(void)removeTemp{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    _dirDirectory = [documentsDirectory stringByAppendingPathComponent:@"sdyy"];
    self.imgDirectory = [_dirDirectory stringByAppendingPathComponent:@"Image"];
    if ([fileManager fileExistsAtPath:self.imgDirectory]) {
        NSDirectoryEnumerator *dirEnum = [fileManager enumeratorAtPath:self.imgDirectory];
        NSString* path = nil;
        while ((path = [dirEnum nextObject]) != nil)
        {
            NSLog(@"%@",path);
            NSString* uploads = [UDObject gethlimgarr];
            if (uploads.length > 0) {
                NSRange r = [uploads rangeOfString:path];
                if (r.length == path.length) {
                    continue;
                }
            }
            uploads = [UDObject getsw_imgarr];
            if (uploads.length > 0) {
                NSRange r = [uploads rangeOfString:path];
                if (r.length == path.length) {
                    continue;
                }
            }
            uploads = [UDObject getzdyimgarr];
            if (uploads.length > 0) {
                NSRange r = [uploads rangeOfString:path];
                if (r.length == path.length) {
                    continue;
                }
            }
            uploads = [UDObject getwlimgarr];
            if (uploads.length > 0) {
                NSRange r = [uploads rangeOfString:path];
                if (r.length == path.length) {
                    continue;
                }
            }
            uploads = [UDObject getzdytopimg];
            if (uploads.length > 0) {
                NSRange r = [uploads rangeOfString:path];
                if (r.length == path.length) {
                    continue;
                }
            }
            NSString* fileTape = [self.imgDirectory stringByAppendingPathComponent: path];
            if ([fileManager fileExistsAtPath:fileTape]) {
                [fileManager removeItemAtPath:fileTape error:nil];
            }
        }
    }
}

-(void)CreateFile{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    _dirDirectory = [documentsDirectory stringByAppendingPathComponent:@"sdyy"];
    [fileManager createDirectoryAtPath:_dirDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    // 创建目录
    self.imgDirectory = [_dirDirectory stringByAppendingPathComponent:@"Image"];
    self.audioDirectory = [_dirDirectory stringByAppendingPathComponent:@"Audio"];
    self.musicFiles = [_dirDirectory stringByAppendingPathComponent:@"musicFiles"];
    
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
    [self CreateFile];
    NSRange r = [name rangeOfString:@".mp3"];
    if (r.length != 4) {
        name = [NSString stringWithFormat:@"%@.mp3",name];
    }
    return [self.musicFiles stringByAppendingPathComponent:name];
}
-(NSString *)GetYPFile1:(NSString *) name{
    [self CreateFile];
    return [self.audioDirectory stringByAppendingPathComponent:name];
}

-(BOOL) ISYPFile:(NSString *)name{
    name = [NSString stringWithFormat:@"%@.mp3",name];
    NSString *filepath = [self.musicFiles stringByAppendingPathComponent:name];
    return [[NSFileManager defaultManager] fileExistsAtPath:filepath];
}

-(NSString *)getThumb:(NSString *)name{
    [self CreateFile];
    return [self.dirDirectory stringByAppendingPathComponent:name];
}

-(NSString *)getImgPath:(NSString *)name{
    [self CreateFile];
    return [_dirDirectory stringByAppendingPathComponent:name];
}


@end
