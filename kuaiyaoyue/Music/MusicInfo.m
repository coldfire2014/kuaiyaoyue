//
//  MusicInfo.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/3.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "MusicInfo.h"

@implementation MusicInfo

-(MusicInfo *)SetMusicValue:(BOOL) state : (NSString *) title :(NSString *) url{
    _state = state;
    _title = title;
    _url = url;
    return self;
}

@end
