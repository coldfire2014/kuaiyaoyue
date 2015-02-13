//
//  EditViewController.h
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/2/11.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadImgView.h"
@interface EditViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>
{
    UITextField* manInput;
    UITextField* wemanInput;
    UITextField* titleInput;
    UITextField* timeInput;
    UITextField* endtimeInput;
    UITextField* contactmanInput;
    UITextField* contactInput;
    UITextField* locInput;
    UITextField* musicInput;
    HeadImgView* headImg;
    int tipCount;
    UILabel* tipCountLbl;
    UITextView* tipInput;
    CGFloat applyTop;
    CGFloat applyHeight;
}
@property (strong, nonatomic) UIScrollView *editListView;
@property (nonatomic, strong) NSString *typeid;

@end
