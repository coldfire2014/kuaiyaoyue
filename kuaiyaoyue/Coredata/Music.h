//
//  Music.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/4.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Music : NSManagedObject

@property (nonatomic, retain) NSString * neftypeid;
@property (nonatomic, retain) NSString * nefurl;
@property (nonatomic, retain) NSString * nefname;
@property (nonatomic, retain) NSString * timestamp;

@end
