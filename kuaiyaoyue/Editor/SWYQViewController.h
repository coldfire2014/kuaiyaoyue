//
//  SWYQViewController.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWYQViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIViewControllerTransitioningDelegate,UIScrollViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *gridview;
@property (weak, nonatomic) IBOutlet UIView *bottomview;

@property (weak, nonatomic) NSString *unquieId;
@property (weak, nonatomic) NSString *nefmbdw;

@property (strong ,nonatomic) NSMutableArray *data;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@end
