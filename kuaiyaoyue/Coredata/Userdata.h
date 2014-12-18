//
//  Userdata.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/18.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Userdata : NSManagedObject

@property (nonatomic, retain) NSString * nefid;
@property (nonatomic, retain) NSString * nefbride;
@property (nonatomic, retain) NSString * nefgroom;
@property (nonatomic, retain) NSString * nefaddress;
@property (nonatomic, retain) NSString * neflocation;
@property (nonatomic, retain) NSString * nefimages;
@property (nonatomic, retain) NSString * neftimestamp;
@property (nonatomic, retain) NSString * nefdate;
@property (nonatomic, retain) NSString * nefurl;
@property (nonatomic, retain) NSString * neftypeId;
@property (nonatomic, retain) NSString * neftemplateurl;
@property (nonatomic, retain) NSString * nefbackground;
@property (nonatomic, retain) NSString * nefmusicurl;
@property (nonatomic, retain) NSString * nefthumb;
@property (nonatomic, retain) NSString * nefnumber;
@property (nonatomic, retain) NSString * neftotal;
@property (nonatomic, retain) NSString * nefinviter;
@property (nonatomic, retain) NSString * neftape;
@property (nonatomic, retain) NSString * nefclosetimestamp;
@property (nonatomic, retain) NSString * nefdescription;
@property (nonatomic, retain) NSString * nefpartyname;
@property (nonatomic, retain) NSString * nefcardtypeId;
@property (nonatomic, retain) NSString * neftitle;
@property (nonatomic, retain) NSString * neflogo;
@property (nonatomic, retain) NSString * nefmusic;
@property (nonatomic, retain) NSString * nefcontent;
@property (nonatomic, retain) NSString * nefAccount;
@property (nonatomic) int16_t neftype;

@end
