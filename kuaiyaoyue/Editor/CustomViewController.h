//
//  CustomViewController.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIViewControllerTransitioningDelegate,UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    BOOL isHead;
}
@property (strong, nonatomic) NSString *unquieId;

@property (weak, nonatomic) IBOutlet UIView *send_view;
@property (weak, nonatomic) IBOutlet UIView *sendshare_view;

@end
