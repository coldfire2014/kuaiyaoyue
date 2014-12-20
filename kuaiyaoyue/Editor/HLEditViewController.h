//
//  HLEditViewController.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLEditViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIViewControllerTransitioningDelegate,UIScrollViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *gridview;
@property (weak, nonatomic) IBOutlet UIView *bottomview;


@property (strong ,nonatomic) NSMutableArray *data;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UITextField *xl_edit;
@property (weak, nonatomic) IBOutlet UITextField *xn_edit;
- (IBAction)hltime_onclick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *hltime_label;
- (IBAction)bmend_onclick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *bmend_label;
@property (weak, nonatomic) IBOutlet UITextField *address_edit;

- (IBAction)xl_next:(id)sender;
- (IBAction)xn_next:(id)sender;
- (IBAction)address_next:(id)sender;

@end
