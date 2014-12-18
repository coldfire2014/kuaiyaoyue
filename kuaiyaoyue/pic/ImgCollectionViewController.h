//
//  ImgCollectionViewController.h
//  SpeciallyEffect
//
//  Created by wuyangbing on 14/12/7.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCHeader.h"
//调用例子
//var imgView = segue.destinationViewController as ImgCollectionViewController
//if obj == "head" {
//    imgView.maxCount = 1
//    let head = self.view.viewWithTag(402)!
//    imgView.delegate = head as HeadInput
//}else if obj == "imgs" {
//    imgView.maxCount = 99
//    let imgs = self.view.viewWithTag(404)!
//    imgView.delegate = imgs as PicInput
//}
@protocol ImgCollectionViewDelegate <NSObject>

-(void)didSelectAssets:(NSArray*)items;
@optional
-(NSMutableArray*)ownAssets;

@end
@interface ImgCollectionViewController : UICollectionViewController
{
    BOOL isOK;
    BOOL isShow;
    CGFloat m_w;
    AssetHelper* assert;
    NSMutableArray* sections;
    NSMutableArray* cells;
    NSMutableArray* selectItems;
    NSMutableArray* selectIndexs;
}
@property (nonatomic,weak) id<ImgCollectionViewDelegate> delegate;
@property (nonatomic) BOOL needAnimation;
@property (nonatomic) int maxCount;
@end

