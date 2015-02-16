//
//  EditViewController.h
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/2/11.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadImgView.h"
#import "DatetimeInput.h"
#import "MusicViewController.h"
#import "PreviewViewController.h"
#import "ImgCollectionViewController.h"
@interface EditViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,PreviewViewControllerDelegate,ImgCollectionViewDelegate,datetimeInputDelegate,MVCDelegate>
{
    UITextField* manInput;
    UITextField* wemanInput;
    UITextField* titleInput;
    UITextField* timeInput;
    NSTimeInterval timeDouble;
    UITextField* endtimeInput;
    NSTimeInterval endtimeDouble;
    BOOL isEndTime;
    UITextField* contactmanInput;
    UITextField* contactInput;
    UITextField* locInput;
    UITextField* musicInput;
    NSString* musicURL;
    HeadImgView* headImg;
    int tipCount;
    UILabel* tipCountLbl;
    UITextView* tipInput;
    CGFloat applyTop;
    CGFloat applyHeight;
    BOOL isHead;
    AssetHelper* assert;
}
@property (strong, nonatomic) UIScrollView *editListView;
@property (nonatomic, strong) NSString *typeid;

@end
