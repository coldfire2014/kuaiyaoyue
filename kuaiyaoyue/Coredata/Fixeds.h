//
//  Fixeds.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/20.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Fixeds : NSManagedObject

@property (nonatomic, retain) NSString * neftemplateid;
@property (nonatomic, retain) NSString * nefContent;
@property (nonatomic) int16_t nefFontSize;
@property (nonatomic) int16_t nefHeight;
@property (nonatomic) int16_t nefWidth;
@property (nonatomic) int16_t nefX;
@property (nonatomic) int16_t nefY;

@end
