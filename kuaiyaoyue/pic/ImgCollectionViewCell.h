//
//  ImgCollectionViewCell.h
//  SpeciallyEffect
//
//  Created by wuyangbing on 14/12/7.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssetHelper.h"
@interface ImgCollectionViewCell : UICollectionViewCell
@property (nonatomic ,strong) NSIndexPath* index;
@property (nonatomic ,strong) ALAsset* asset;
@property (nonatomic ,strong) NSString* imgPath;
@property (nonatomic) int maxCount;
-(void) checkSelect;
-(void) setSelect;
@end
