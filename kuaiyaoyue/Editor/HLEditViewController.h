//
//  HLEditViewController.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PreviewViewController.h"
@interface HLEditViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIViewControllerTransitioningDelegate,UIScrollViewDelegate,UITextFieldDelegate,PreviewViewControllerDelegate>

@property (strong ,nonatomic) NSMutableArray *data;
@property (strong, nonatomic) NSString *unquieId;
@property (strong, nonatomic) NSString *nefmbdw;

@property (weak, nonatomic) IBOutlet UIView *send_view;
@property (weak, nonatomic) IBOutlet UIView *sendshare_view;
-(UIImage *)getimg :(NSString *) str;
@end
