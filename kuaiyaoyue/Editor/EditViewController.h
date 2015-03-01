//
//  EditViewController.h
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/2/11.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tapeView.h"
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
    NSString* headFile;
    NSString* madeFile;
    int tipCount;
    UILabel* tipCountLbl;
    UITextView* tipInput;
    CGFloat applyTop;
    CGFloat applyHeight;
    BOOL isHead;
    AssetHelper* assert;
    tapeView *recordedInput;
    NSString *recordedFile;
    UIImage* drowImage;
    int firstImgIndex;
    int imageCount;
    int imageMax;
    NSMutableArray* uploadFiles;
}
@property (strong, nonatomic) UIScrollView *editListView;
@property (nonatomic, strong) NSString *typeid;

@property (nonatomic, strong) NSString *tempId;//模板id
@property (nonatomic, strong) NSString *tempLoc;//模版位置
@end
