//
//  FileManage.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/4.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManage : NSObject

+ (FileManage *)getManager;

-(NSString *)GetYPFile:(NSString *) name;
-(BOOL) ISYPFile:(NSString *)name;

@end
