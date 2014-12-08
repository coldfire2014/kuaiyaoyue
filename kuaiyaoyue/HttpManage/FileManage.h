//
//  FileManage.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/4.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManage : NSObject

@property (nonatomic ,strong) NSString* hlimgDirectory;
@property (nonatomic ,strong) NSString* imgDirectory;
@property (nonatomic ,strong) NSString* audioDirectory;

-(NSString *)GetYPFile:(NSString *) name;
-(BOOL) ISYPFile:(NSString *)name;
+ (FileManage *)sharedFileManage;
@end
