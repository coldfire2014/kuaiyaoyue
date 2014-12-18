//
//  Template.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/18.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Template : NSManagedObject

@property (nonatomic, retain) NSString * nefbackcolor;
@property (nonatomic, retain) NSString * nefbackground;
@property (nonatomic, retain) NSNumber * nefid;
@property (nonatomic, retain) NSNumber * nefintegral;
@property (nonatomic, retain) NSNumber * nefmark;
@property (nonatomic, retain) NSString * nefmbbg;
@property (nonatomic, retain) NSString * nefmbdw;
@property (nonatomic, retain) NSString * nefname;
@property (nonatomic, retain) NSString * nefthumburl;
@property (nonatomic, retain) NSString * neftimestamp;
@property (nonatomic, retain) NSNumber * neftypeId;
@property (nonatomic, retain) NSString * nefurl;
@property (nonatomic, retain) NSString * nefzipurl;
@property (nonatomic, retain) NSString * nefpreview;

@end
