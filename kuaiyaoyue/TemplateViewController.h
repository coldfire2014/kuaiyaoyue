//
//  TemplateViewController.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ctView.h"
@interface TemplateViewController : UIViewController<ctViewDelegate>
{
//    ctView* tempList;
}
@property (nonatomic,strong) ctView* tempList;
@property (nonatomic,strong) NSString* type;
@property (nonatomic,weak) UIImage* bgimg;
@end
