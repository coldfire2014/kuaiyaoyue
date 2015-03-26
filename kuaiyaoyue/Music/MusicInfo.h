//
//  MusicInfo.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/3.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicInfo : NSObject

@property BOOL state;
@property (strong ,nonatomic) NSString *title;
@property (strong ,nonatomic) NSString *url;
@property (strong ,nonatomic) NSString *uniqueId;
@property (strong ,nonatomic) NSURL *locUrl;
-(MusicInfo *)SetMusicValue:(BOOL) state : (NSString *) title :(NSString *) url :(NSString *)uniqueId;
-(MusicInfo *)SetMusicValue:(BOOL) state andTitle: (NSString *) title andUrl:(NSURL *) url;
@end