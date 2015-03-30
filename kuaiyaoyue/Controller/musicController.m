//
//  musicController.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/1/27.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import "musicController.h"
#import "DataBaseManage.h"
#import "Music.h"
#import "HttpManage.h"
#import "PCHeader.h"
#import "FileManage.h"
@implementation musicController
-(void)update{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString *is_open = [userInfo valueForKey:MUSIC_TOKEN];
    NSArray *arr = [[DataBaseManage getDataBaseManage] getMusic];
    if ([arr count] > 0 && [is_open length] > 0) {
        [self performSelectorInBackground:@selector(updatemusic:) withObject:arr];
    }else{
        if ([arr count] > 0) {
            [[DataBaseManage getDataBaseManage] resetMusic];
        }
        NSBundle *bundle = [NSBundle mainBundle];
        NSString* html = [[NSString alloc] initWithContentsOfFile:[bundle pathForResource:@"music" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
        NSData* resData=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        NSUInteger tjnum = [array count];
        if (tjnum > 0) {
            for (int i = 0; i < [array count]; i++) {
                NSDictionary *dic = [array objectAtIndex:i];
                [[DataBaseManage getDataBaseManage] setMusic:dic];
            }
        }
        [userInfo setObject:MUSIC_TOKEN forKey:MUSIC_TOKEN];
    }
}
-(void)updatemusic:(NSArray*)arr{
    Music *music = [arr objectAtIndex:0];
    NSString *timestamp = music.timestamp;
    [HttpManage getAll:timestamp cb:^(BOOL isOK, NSMutableArray *array) {
        if (isOK && nil != array) {
            NSLog(@"%@",array);
            NSUInteger tjnum = [array count];
            if (tjnum > 0) {
                for (int i = 0; i < [array count]; i++) {
                    NSDictionary *dic = [array objectAtIndex:i];
                    [[DataBaseManage getDataBaseManage] setMusic:dic];
//                    [self downYP:[dic objectForKey:@"uniqueId"] :[dic objectForKey:@"url"]];
                }
            }
        }
    }];
}
-(void)downYP:(NSString *)ypname :(NSString *)url{
    BOOL is_bd = [[FileManage sharedFileManage] ISYPFile:ypname];
    NSString *file  = [[FileManage sharedFileManage] GetYPFile:ypname];
    if (!is_bd) {
        [HttpManage DownMusic:url filepath:file cb:^(BOOL isOK) {

        }];
    }
}
@end
