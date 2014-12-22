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

@property (weak, nonatomic) NSString *unquieId;
@property (weak, nonatomic) NSString *nefmbdw;

@property (strong ,nonatomic) NSMutableArray *data;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
- (IBAction)xlfs_next:(id)sender;
- (IBAction)xlr_next:(id)sender;

- (IBAction)jh_next:(id)sender;
- (IBAction)address_next:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *jh_edit;
- (IBAction)time_onclick:(id)sender;
- (IBAction)bm_onclick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *bmend_label;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (weak, nonatomic) IBOutlet UITextField *address_label;
@property (weak, nonatomic) IBOutlet UITextField *xlr_label;
@property (weak, nonatomic) IBOutlet UITextField *xlfs_label;
@property (weak, nonatomic) IBOutlet UIView *more_view;
@property (weak, nonatomic) IBOutlet UIButton *more_button;
- (IBAction)more_onclick:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *add_view;

@end
