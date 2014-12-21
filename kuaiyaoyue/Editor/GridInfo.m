

//
//  GridInfo.m
//  cartoonCard
//
//  Created by DavidWang on 14-9-9.
//  Copyright (c) 2014年 wu yangbing. All rights reserved.
//

#import "GridInfo.h"

@implementation GridInfo

- (GridInfo *)initWithDictionary:(bool) is_open :(UIImage *)img{
    self.is_open = is_open;
    self.img = img;
    return self;
}

@end
