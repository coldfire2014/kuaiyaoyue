//
//  GridInfo.h
//  cartoonCard
//
//  Created by DavidWang on 14-9-9.
//  Copyright (c) 2014年 wu yangbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AssetHelper.h"

@interface GridInfo : NSObject

@property (strong ,nonatomic) ALAsset *alasset;
@property bool is_open;

- (GridInfo *)initWithDictionary:(bool) is_open :(ALAsset *)alasset;

@end
