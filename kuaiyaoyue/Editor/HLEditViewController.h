//
//  HLEditViewController.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLEditViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIViewControllerTransitioningDelegate,UIScrollViewDelegate,UITextFieldDelegate>

@property (strong ,nonatomic) NSMutableArray *data;
@property (weak, nonatomic) NSString *unquieId;
@property (weak, nonatomic) NSString *nefmbdw;

- (IBAction)send_onclick:(id)sender;
- (IBAction)sendandshare_onclick:(id)sender;

@end
