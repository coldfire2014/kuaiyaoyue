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
#import "Contacts.h"
#import "Fixeds.h"

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
    template.nefsort = [resultDic objectForKey:@"sort"];
    
    template.nefthumburl = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"thumbUrl"]];
    template.neftimestamp = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"timestamp"]];
//    NSLog(@"%@",[resultDic objectForKey:@"timestamp"]);
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
    
    NSArray *fixeds = [resultDic objectForKey:@"fixeds"];
    for (NSDictionary *dic in fixeds) {
        [self AddFixeds:dic :nefids];
    }
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return YES;
}

-(BOOL)UpTemplate:(NSDictionary *) dic{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Template"];
    NSPredicate *predict = [NSPredicate predicateWithFormat:@"(nefid = %@)",[dic objectForKey:@"unquieId"]];
    [request setPredicate:predict];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
    if ([fetchedObjects count] > 0) {
        for (int i = 0; i <[fetchedObjects count] ; i++) {
            Template *template = [fetchedObjects objectAtIndex:i];
            template.nefsort = [dic objectForKey:@"sort"];
            if (![context save:&error]) {
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
                return NO;
            }
        }
    }else{
        return NO;
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

-(void)AddFixeds:(NSDictionary *)dic :(NSString *)nefid{
    Fixeds *info = [NSEntityDescription insertNewObjectForEntityForName:@"Fixeds" inManagedObjectContext:context];
    info.nefContent = [dic objectForKey:@"nefContent"];
    info.nefFontSize = [[dic objectForKey:@"nefFontSize"] intValue];
    info.nefHeight = [[dic objectForKey:@"nefHeight"] intValue];
    info.nefWidth = [[dic objectForKey:@"nefWidth"] intValue];
    info.nefX = [[dic objectForKey:@"nefX"] intValue];
    info.nefY = [[dic objectForKey:@"nefY"] intValue];
    info.neftemplateid = nefid;
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
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

-(NSArray *)GetInfo:(NSString *) nefid{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Info"];
    NSPredicate *predict = [NSPredicate predicateWithFormat:@"(neftemplateid = %@)",nefid];
    [request setPredicate:predict];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
    
    return fetchedObjects;
}

-(NSArray *)GetFixeds:(NSString *) nefid{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Fixeds"];
    NSPredicate *predict = [NSPredicate predicateWithFormat:@"(neftemplateid = %@)",nefid];
    [request setPredicate:predict];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
    
    return fetchedObjects;
}

//0自定义，1婚礼，2趴体
-(BOOL)AddUserdata :(NSDictionary *) dic type:(int)type{
    Userdata *userdata = [NSEntityDescription insertNewObjectForEntityForName:@"Userdata" inManagedObjectContext:context];

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
        userdata.neftimestamp = [NSString stringWithFormat:@"%@",[dic objectForKey:@"timestamp"]];
        userdata.nefdate = [NSString stringWithFormat:@"%@",[dic objectForKey:@"date"]];
        userdata.nefclosetimestamp = [NSString stringWithFormat:@"%@",[dic objectForKey:@"closeTimestamp"]];
        userdata.neftemplateurl = [dic objectForKey:@"templateUrl"];
        userdata.nefurl = [dic objectForKey:@"url"];
        userdata.neftypeId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"typeId"]];
        userdata.nefthumb = [NSString stringWithFormat:@"%@",[dic objectForKey:@"thumb"]];
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
        userdata.nefthumb = [NSString stringWithFormat:@"%@",[dic objectForKey:@"thumb"]];
        userdata.nefnumber = [NSString stringWithFormat:@"%@",[dic objectForKey:@"number"]];
        userdata.neftotal = [NSString stringWithFormat:@"%@",[dic objectForKey:@"total"]];
        userdata.nefclosetimestamp = [NSString stringWithFormat:@"%@",[dic objectForKey:@"closeTimestamp"]];
        
    }else if (type == 2){
        NSLog(@"%@",[dic objectForKey:@"partyName"]);
        
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
        userdata.nefgroom = [dic objectForKey:@"contact"];
        userdata.neftimestamp = [NSString stringWithFormat:@"%@",[dic objectForKey:@"timestamp"]];
        userdata.nefclosetimestamp = [NSString stringWithFormat:@"%@",[dic objectForKey:@"closeTimestamp"]];
        userdata.nefdescription = [dic objectForKey:@"description"];
        userdata.nefdate = [NSString stringWithFormat:@"%@",[dic objectForKey:@"date"]];
        userdata.nefurl = [dic objectForKey:@"url"];
        userdata.neftypeId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"typeId"]];
        userdata.nefpartyname = [dic objectForKey:@"partyName"];
        userdata.neftemplateurl = [dic objectForKey:@"templateUrl"];
        userdata.nefcardtypeId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"cardTypeId"]];
        userdata.nefthumb = [NSString stringWithFormat:@"%@",[dic objectForKey:@"thumb"]];
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

-(void)AddHLUserdata{
    
    
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
-(BOOL)CleanUserdata{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Userdata" inManagedObjectContext:context]];
    //删除谁的条件在这里配置；
    NSPredicate *predict = [NSPredicate predicateWithFormat:@"(nefAccount = %@)",[UDObject getAccount]];
    [fetchRequest setPredicate:predict];
    NSError* error = nil;
    NSArray* results = [context executeFetchRequest:fetchRequest error:&error];
    if ([results count] > 0) {
        for(Userdata * item in results){
            [context deleteObject:item];
        }
    }
    if (![context save:&error])
    {
        NSLog(@"error:%@",error);
        return NO;
    }
    return YES;
}
-(BOOL)DelUserdata:(NSString *)nefid{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Userdata" inManagedObjectContext:context]];
    //删除谁的条件在这里配置；
    NSPredicate *predict = [NSPredicate predicateWithFormat:@"(nefid = %@)",nefid];
    [fetchRequest setPredicate:predict];
    NSError* error = nil;
    NSArray* results = [context executeFetchRequest:fetchRequest error:&error];
    if ([results count] > 0) {
        [context deleteObject:[results objectAtIndex:0]];
    }
    if (![context save:&error])
    {
        NSLog(@"error:%@",error);
        return NO;
    }
    return YES;
}

-(BOOL)UpUserdata:(NSString *)nefid{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Userdata"];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"nefdate" ascending:NO];
    NSArray * sortDescriptors = [NSArray arrayWithObject: sort];
    [request setSortDescriptors: sortDescriptors];
    NSPredicate *predict = [NSPredicate predicateWithFormat:@"(nefid = %@)",nefid];
    [request setPredicate:predict];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
    if (fetchedObjects.count > 0) {
        Userdata *data = [fetchedObjects objectAtIndex:0];
        data.nefnumber = @"0";
        if (![context save:&error])
        {
            NSLog(@"error:%@",error);
            return NO;
        }
    }
    
    return YES;
}

-(BOOL)GetUpUserdata:(NSDictionary *)dic{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Userdata"];
    NSPredicate *predict = [NSPredicate predicateWithFormat:@"(nefid = %@)",[dic objectForKey:@"unquieId"]];
    [request setPredicate:predict];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
    if ([fetchedObjects count] > 0) {
        Userdata *user = [fetchedObjects objectAtIndex:0];
        user.nefclosetimestamp = [NSString stringWithFormat:@"%@",[dic objectForKey:@"closeTimestamp"]];
        user.neftotal = [NSString stringWithFormat:@"%@",[dic objectForKey:@"total"]];
        user.nefnumber = [NSString stringWithFormat:@"%@",[dic objectForKey:@"number"]];
        if (![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        return YES;
    }else{
        return NO;
    }
    
}

-(NSArray *)GetTemplate:(NSString *) neftypeId{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Template"];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"nefsort" ascending:YES];
    NSArray * sortDescriptors = [NSArray arrayWithObject: sort];
    [request setSortDescriptors: sortDescriptors];
    NSPredicate *predict = [NSPredicate predicateWithFormat:@"(neftypeId = %@)",neftypeId];
    [request setPredicate:predict];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
    
    return fetchedObjects;
}


-(BOOL)AddContacts:(NSDictionary *)dic :(NSString *)nefid{
    Contacts *contacts = [NSEntityDescription insertNewObjectForEntityForName:@"Contacts" inManagedObjectContext:context];
    contacts.message = [dic objectForKey:@"message"];
    contacts.mobile = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mobile"]];
    contacts.name = [dic objectForKey:@"name"];
    contacts.number = [[dic objectForKey:@"number"] integerValue];
    contacts.timestamp = [NSString stringWithFormat:@"%@",[dic objectForKey:@"timestamp"]];
    contacts.nefid = nefid;
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
        return NO;
    }
    return YES;
}

-(NSArray *)GetContacts :(NSString *)neftypeid{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Contacts"];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
    NSArray * sortDescriptors = [NSArray arrayWithObject: sort];
    [request setSortDescriptors: sortDescriptors];
    NSPredicate *predict = [NSPredicate predicateWithFormat:@"(nefid = %@)",neftypeid];
    [request setPredicate:predict];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
    return fetchedObjects;
}

-(void)setMusic:(NSDictionary *) dic{
    Music *music = [NSEntityDescription insertNewObjectForEntityForName:@"Music" inManagedObjectContext:context];
    music.neftypeid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"typeId"]];
    music.nefname = [dic objectForKey:@"name"];
    music.nefurl = [dic objectForKey:@"url"];
    music.timestamp = [NSString stringWithFormat:@"%@",[dic objectForKey:@"timestamp"]];
    music.uniqueId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"uniqueId"]];
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

-(NSArray *)getMusic:(NSString *)typeid{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Music"];
    if([typeid compare:@"4"] != NSOrderedSame){
        NSPredicate *predict = [NSPredicate predicateWithFormat:@"(neftypeid = %@)",typeid];
        [request setPredicate:predict];
    }
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
    return fetchedObjects;
}

-(NSArray *)getMusic{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Music"];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
    return fetchedObjects;
}

@end
