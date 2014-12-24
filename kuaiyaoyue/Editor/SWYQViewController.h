//
//  SWYQViewController.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWYQViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIViewControllerTransitioningDelegate,UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate>

@property (strong, nonatomic) NSString *unquieId;
@property (strong, nonatomic) NSString *nefmbdw;

@property (weak, nonatomic) IBOutlet UIView *send_view;
@property (weak, nonatomic) IBOutlet UIView *sendshare_view;

@end
