//
//  FileManage.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/4.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#define C_JPEG_SIZE 0.5
@interface FileManage : NSObject

@property (nonatomic ,strong) NSString *dirDirectory;
@property (nonatomic ,strong) NSString* imgDirectory;
@property (nonatomic ,strong) NSString* audioDirectory;
@property (nonatomic ,strong) NSString* musicFiles;


+ (FileManage *)sharedFileManage;
-(NSString *)GetYPFile:(NSString *) name;
-(NSString *)GetYPFile1:(NSString *) name;
-(BOOL) ISYPFile:(NSString *)name;
-(NSString *)getImgFile:(NSString *)name;
-(NSString *)getThumb:(NSString *)name;
-(NSString *)getImgPath:(NSString *)name;

@end
