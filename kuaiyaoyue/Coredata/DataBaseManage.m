//
//  DataBaseManage.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/4.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "DataBaseManage.h"
#import "Music.h"

@implementation DataBaseManage

static DataBaseManage *database = nil;
static NSManagedObjectContext *context = nil;

+(DataBaseManage *)getDataBaseManage{
    if (database == nil && context == nil) {
        database = [[DataBaseManage alloc] init];
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        context = [delegate managedObjectContext];
    }
    return database;
}

-(void)setMusic:(NSDictionary *) dic{
    Music *music = [NSEntityDescription insertNewObjectForEntityForName:@"Music" inManagedObjectContext:context];
    music.neftypeid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"uniqueId"]];
    music.nefname = [dic objectForKey:@"name"];
    music.nefurl = [dic objectForKey:@"url"];
    music.timestamp = [NSString stringWithFormat:@"%@",[dic objectForKey:@"timestamp"]];
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

-(NSArray *)getMusic{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Music"];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
    return fetchedObjects;
    
}

@end
