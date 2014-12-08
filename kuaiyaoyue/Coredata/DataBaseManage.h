//
//  DataBaseManage.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/4.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface DataBaseManage : NSObject

+(DataBaseManage *)getDataBaseManage;

-(void)setMusic:(NSDictionary *) dic;
-(NSArray *)getMusic;

@end
