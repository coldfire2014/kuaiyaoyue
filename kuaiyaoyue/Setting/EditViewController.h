//
//  EditViewController.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/27.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *content_edit;
- (IBAction)content_next:(id)sender;
@property int type;

@end
