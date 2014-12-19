//
//  Contacts.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/19.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Contacts : NSManagedObject

@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSString * mobile;
@property (nonatomic, retain) NSString * name;
@property (nonatomic) int16_t number;
@property (nonatomic, retain) NSString * timestamp;
@property (nonatomic, retain) NSString * nefid;

@end
