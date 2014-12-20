

//
//  GridInfo.m
//  cartoonCard
//
//  Created by DavidWang on 14-9-9.
//  Copyright (c) 2014年 wu yangbing. All rights reserved.
//

#import "GridInfo.h"

@implementation GridInfo

- (GridInfo *)initWithDictionary:(bool) is_open :(ALAsset *)alasset{
    self.is_open = is_open;
    self.alasset = alasset;
    return self;
}

@end
