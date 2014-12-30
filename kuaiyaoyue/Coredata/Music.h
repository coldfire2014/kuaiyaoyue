//
//  Music.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/30.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Music : NSManagedObject

@property (nonatomic, retain) NSString * nefname;
@property (nonatomic, retain) NSString * neftypeid;
@property (nonatomic, retain) NSString * nefurl;
@property (nonatomic, retain) NSString * timestamp;
@property (nonatomic, retain) NSString * uniqueId;
@property (nonatomic, retain) NSString * nefa;

@end
