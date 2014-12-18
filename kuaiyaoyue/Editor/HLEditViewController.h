//
//  HLEditViewController.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLEditViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *gridview;
@property (weak, nonatomic) IBOutlet UIView *bottomview;

@property (strong ,nonatomic) NSMutableArray *data;

@end
