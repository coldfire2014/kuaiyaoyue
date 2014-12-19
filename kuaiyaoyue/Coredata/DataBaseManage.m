//
//  DataBaseManage.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/4.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "DataBaseManage.h"
#import "Music.h"
#import "Template.h"
#import "Info.h"
#import "Userdata.h"
#import "UDObject.h"

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

-(NSArray *)QueryTemplate{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Template"];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"neftimestamp" ascending:NO];
    NSArray * sortDescriptors = [NSArray arrayWithObject: sort];
    [request setSortDescriptors: sortDescriptors];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
    
    return fetchedObjects;
    
}

-(BOOL)AddTemplate:(NSDictionary *) resultDic{
    Template *template = [NSEntityDescription insertNewObjectForEntityForName:@"Template" inManagedObjectContext:context];
    int nefid = [[resultDic objectForKey:@"unquieId"] intValue];
    NSString *nefids = [NSString stringWithFormat:@"%d",nefid];
    template.nefid = [resultDic objectForKey:@"unquieId"];
    template.nefbackcolor = [resultDic objectForKey:@"backColor"];
    template.nefintegral = [resultDic objectForKey:@"integral"];
    template.nefname = [resultDic objectForKey:@"name"];
    template.nefthumburl = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"thumbUrl"]];
    template.neftimestamp = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"timestamp"]];
    NSLog(@"%@",[resultDic objectForKey:@"timestamp"]);
    template.neftypeId = [resultDic objectForKey:@"type"];
    template.nefurl = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"url"]];
    template.nefbackground = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"background"]];
    NSString *testDirectory = @"/sdyy";
    [[NSFileManager defaultManager] createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    NSArray *array = [[resultDic objectForKey:@"zipUrl"] componentsSeparatedByString:@"/"];
    NSString *imgname = [array objectAtIndex:([array count] - 1)];
    NSArray *array1 = [imgname componentsSeparatedByString:@"."];
    imgname = [array1 objectAtIndex:0];
    NSString *path = [testDirectory stringByAppendingPathComponent:imgname];
    path = [path stringByAppendingPathComponent: @"assets"];
    path = [path stringByAppendingPathComponent: @"images"];
    NSString *nefmbbg = [path stringByAppendingPathComponent:@"preview"];
    NSString *nefmbdw = [path stringByAppendingPathComponent:@"base"];
    template.nefmbbg = nefmbbg;
    template.nefmbdw = nefmbdw;
    
    testDirectory = [testDirectory stringByAppendingPathComponent:imgname];
    template.nefzipurl = testDirectory;
    
    NSArray *infoarr = [resultDic objectForKey:@"infos"];
    for (int i = 0; i<[infoarr count]; i++) {
        NSDictionary *resultDic1 = [infoarr objectAtIndex:i];
        [self Addinfo:resultDic1 :nefids];
    }
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return YES;
}


-(BOOL)Addinfo:(NSDictionary *) resultDic :(NSString *) nefid{
    Info *info = [NSEntityDescription insertNewObjectForEntityForName:@"Info" inManagedObjectContext:context];
    info.neffontcolor = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"fontColor"]];
    info.neffontsize = [resultDic objectForKey:@"fontSize"];
    info.nefheight = [resultDic objectForKey:@"height"];
    info.nefparametername = [resultDic objectForKey:@"parameterName"];
    info.neftimetype = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"timeType"]];
    info.nefwidth = [resultDic objectForKey:@"width"];
    info.nefx = [resultDic objectForKey:@"x"];
    info.nefy = [resultDic objectForKey:@"y"];
    info.neftemplateid = nefid;
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
        return NO;
    }
    return YES;
}

-(BOOL)UpdataInfo :(NSDictionary *)dic{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Info"];
    NSPredicate *predict = [NSPredicate predicateWithFormat:@"(neftemplateid = %@)",[dic objectForKey:@"unquieId"]];
    [request setPredicate:predict];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
    NSArray *arry = [dic objectForKey:@"infos"];
    if ([fetchedObjects count] > 0) {
        for (int i = 0; i <[fetchedObjects count] ; i++) {
            Info *info = [fetchedObjects objectAtIndex:i];
            NSString *parameterName = info.nefparametername;
            for (int j = 0; j < [arry count] ; j++) {
                NSDictionary *dic = [arry objectAtIndex:j];
                if ([parameterName isEqualToString:[dic objectForKey:@"parameterName"]]) {
                    info.neffontcolor = [dic objectForKey:@"fontColor"];
                    info.neffontsize = [dic objectForKey:@"fontSize"];
                    info.nefheight = [dic objectForKey:@"height"];
                    info.nefwidth = [dic objectForKey:@"width"];
                    info.nefx = [dic objectForKey:@"x"];
                    info.nefy = [dic objectForKey:@"y"];
                    if (![context save:&error]) {
                        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                        abort();
                        return NO;
                    }
                }
            }
        }
    }else{
        return NO;
    }
    
    return YES;
}

//0自定义，1婚礼，2趴体
-(BOOL)AddUserdata :(NSDictionary *) dic type:(int)type{
    Userdata *userdata = [NSEntityDescription insertNewObjectForEntityForName:@"Userdata" inManagedObjectContext:context];
    NSLog(@"%@",[UDObject getAccount]);
    userdata.nefAccount = [UDObject getAccount];
    userdata.neftype = type;
    
    if (type == 0) {
        userdata.nefid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"unquieId"]];
        NSArray *arr = [dic objectForKey:@"images"];
        if (arr != nil) {
            userdata.nefimages = [arr componentsJoinedByString:@","];
        }else{
            userdata.nefimages = @"";
        }
        userdata.neftitle = [dic objectForKey:@"title"];
        userdata.neflogo = [dic objectForKey:@"logo"];
        userdata.nefmusic = [dic objectForKey:@"music"];
        userdata.nefcontent = [dic objectForKey:@"content"];
        userdata.nefclosetimestamp = [NSString stringWithFormat:@"%@",[dic objectForKey:@"closeTimestamp"]];
        userdata.nefdate = [NSString stringWithFormat:@"%@",[dic objectForKey:@"date"]];
        userdata.neftemplateurl = [dic objectForKey:@"templateUrl"];
        userdata.nefurl = [dic objectForKey:@"url"];
        userdata.neftypeId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"typeId"]];
        userdata.nefthumb = [dic objectForKey:@"thumb"];
        userdata.nefnumber = [NSString stringWithFormat:@"%@",[dic objectForKey:@"number"]];
        userdata.neftotal = [NSString stringWithFormat:@"%@",[dic objectForKey:@"total"]];
        
    }else if (type == 1){
        userdata.nefid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"unquieId"]];
        userdata.nefbride = [dic objectForKey:@"bride"];
        userdata.nefgroom = [dic objectForKey:@"groom"];
        userdata.nefaddress = [dic objectForKey:@"address"];
        userdata.neflocation = [dic objectForKey:@"location"];
        NSArray *arr = [dic objectForKey:@"images"];
        if (arr != nil) {
            userdata.nefimages = [arr componentsJoinedByString:@","];
        }else{
            userdata.nefimages = @"";
        }
        userdata.neftimestamp = [NSString stringWithFormat:@"%@",[dic objectForKey:@"timestamp"]];
        userdata.nefdate = [NSString stringWithFormat:@"%@",[dic objectForKey:@"date"]];
        userdata.nefurl = [dic objectForKey:@"url"];
        userdata.neftypeId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"typeId"]];
        userdata.neftemplateurl = [dic objectForKey:@"templateUrl"];
        userdata.nefbackground = [dic objectForKey:@"background"];
        userdata.nefmusicurl = [dic objectForKey:@"musicUrl"];
        userdata.nefthumb = [dic objectForKey:@"thumb"];
        userdata.nefnumber = [NSString stringWithFormat:@"%@",[dic objectForKey:@"number"]];
        userdata.neftotal = [NSString stringWithFormat:@"%@",[dic objectForKey:@"total"]];
        
    }else if (type == 2){
        userdata.nefid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"unquieId"]];
        userdata.nefinviter = [dic objectForKey:@"inviter"];
        userdata.nefaddress = [dic objectForKey:@"address"];
        NSArray *arr = [dic objectForKey:@"images"];
        if (arr != nil) {
            userdata.nefimages = [arr componentsJoinedByString:@","];
        }else{
            userdata.nefimages = @"";
        }
        userdata.neftape = [dic objectForKey:@"tape"];
        userdata.neftimestamp = [NSString stringWithFormat:@"%@",[dic objectForKey:@"timestamp"]];
        userdata.nefclosetimestamp = [NSString stringWithFormat:@"%@",[dic objectForKey:@"closeTimestamp"]];
        userdata.nefdescription = [dic objectForKey:@"description"];
        userdata.nefdate = [NSString stringWithFormat:@"%@",[dic objectForKey:@"date"]];
        userdata.nefurl = [dic objectForKey:@"url"];
        userdata.neftypeId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"typeId"]];
        userdata.nefpartyname = [dic objectForKey:@"partyName"];
        userdata.neftemplateurl = [dic objectForKey:@"templateUrl"];
        userdata.nefcardtypeId = [dic objectForKey:@"cardTypeId"];
        userdata.nefthumb = [dic objectForKey:@"thumb"];
        userdata.nefnumber = [NSString stringWithFormat:@"%@",[dic objectForKey:@"number"]];
        userdata.neftotal = [NSString stringWithFormat:@"%@",[dic objectForKey:@"total"]];
    }
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
        return NO;
    }
    return YES;
}


-(NSArray *)getUserdata{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Userdata"];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"nefdate" ascending:NO];
    NSArray * sortDescriptors = [NSArray arrayWithObject: sort];
    [request setSortDescriptors: sortDescriptors];
    NSPredicate *predict = [NSPredicate predicateWithFormat:@"(nefAccount = %@)",[UDObject getAccount]];
    [request setPredicate:predict];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
    return fetchedObjects;
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
