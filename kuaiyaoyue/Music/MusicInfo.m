//
//  MusicInfo.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/3.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "MusicInfo.h"

@implementation MusicInfo

-(MusicInfo *)SetMusicValue:(BOOL) state : (NSString *) title :(NSString *) url :(NSString *)uniqueId{
    _state = state;
    _title = title;
    _url = url;
    _uniqueId = uniqueId;
    return self;
}
-(MusicInfo *)SetMusicValue:(BOOL) state andTitle: (NSString *) title andUrl:(NSURL *) url{
    _state = state;
    _title = title;
    _locUrl = url;
    return self;
}

@end
