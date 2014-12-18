

//
//  GridInfo.m
//  cartoonCard
//
//  Created by DavidWang on 14-9-9.
//  Copyright (c) 2014年 wu yangbing. All rights reserved.
//

#import "GridInfo.h"

@implementation GridInfo

- (GridInfo *)initWithDictionary:(UIImage *) img :(bool) is_open{
    self.img = img;
    self.is_open = is_open;
    return self;
}

@end
