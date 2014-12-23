//
//  CHWLEditorViewController.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHWLEditorViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIViewControllerTransitioningDelegate,UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate>

@property (weak, nonatomic) NSString *unquieId;
@property (weak, nonatomic) NSString *nefmbdw;

@end
