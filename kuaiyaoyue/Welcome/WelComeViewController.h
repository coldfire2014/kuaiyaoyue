//
//  WelComeViewController.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImgCollectionViewController.h"
@interface WelComeViewController : UIViewController<UIViewControllerTransitioningDelegate>
{
    BOOL zipDone;
    BOOL downloadDone;
}
- (IBAction)onclick:(id)sender;
@end
