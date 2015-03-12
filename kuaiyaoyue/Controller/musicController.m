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
    NSArray *arr = [[DataBaseManage getDataBaseManage] getMusic];
    if ([arr count] > 0) {
        [self performSelectorInBackground:@selector(updatemusic:) withObject:arr];
        
    }else{
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
    }
}
-(void)updatemusic:(NSArray*)arr{
    Music *music = [arr objectAtIndex:[arr count] -1];
    NSString *timestamp = music.timestamp;
    [HttpManage getAll:timestamp cb:^(BOOL isOK, NSMutableArray *array) {
        if (isOK && nil != array) {
            NSLog(@"%@",array);
            NSUInteger tjnum = [array count];
            if (tjnum > 0) {
                for (int i = 0; i < [array count]; i++) {
                    NSDictionary *dic = [array objectAtIndex:i];
                    [[DataBaseManage getDataBaseManage] setMusic:dic];
                    [self downYP:[dic objectForKey:@"uniqueId"] :[dic objectForKey:@"url"]];
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
